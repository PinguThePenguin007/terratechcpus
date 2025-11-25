#!/usr/bin/lua

-- TODO: implement proper cli argument parser

local inputfile = arg[1]
local outbase = (arg[2] or "HEX"):upper()
local dostdout = arg[3]

io.input("instruction_list.md")

local function decodenum(num)
	if num:match("0x%S+") then
		num = tonumber(num:gsub("0x",""),16)
	elseif num:match("0b%S+") then
		num = tonumber(num:gsub("0b",""),2)
	else
		num = tonumber(num)
	end

	return num
end

local function insparse(line)
	local bytecount = 1
	local words = {}
	for word in string.gmatch(line, "%S+") do
		table.insert(words,word:upper())
	end

	if #words == 0 then return "","",0 end

	local op = words[1]

	table.remove(words,1)

	-- create unique id for every configuration
	local opmode = ""
	for _,word in ipairs(words) do
		if word:find("#") then
			word = "IMM"
			bytecount = bytecount + 1
		end
		opmode = opmode..word
		end
	return op,opmode,bytecount
end

-- parse instruction list
local ops = {}

_,_ = io.read("l"),io.read("l")

while io.read(0) do
	local line = io.read("l")

	local ins, code, dec, hex = line:match("^|(.*)|(.*)|%s*(%S*)%s*|%s*(%S*)%s*")

	-- check if opcode for the instruction exists
	-- thus ignore any headers
	if code:match("%S") then

		local op,opmode,bytecount = insparse(ins)

		if not ops[op] then
			ops[op] = {}
		end

		ops[op][opmode] = {hex = hex, dec = dec, bytecount = bytecount}

	end
end

--[[
for op in pairs(ops) do
	print(op)
	for opmode,opcodes in pairs(ops[op]) do
		print("	"..opmode.."	0x"..opcodes.hex)
	end
end

os.exit()
--]]

-- find labels and count positions for them

io.input(inputfile)

local labels = {}
local position = 0
local linenum = 0

while io.read(0) do
	local line = io.read("l")
	linenum = linenum + 1

	if line:match("%S") then

		line = line:gsub("%s*;.*$","")

		if line:match("^%s") then
			if line:match("^%s.org") then
				local val = line:gsub("^%s.org","")
				val = decodenum(val)
				position = val
			elseif line:match(".word") then
				local vals = line:gsub("^%s.word","")
				for _ in string.gmatch(vals, "%S+") do
					position = position + 1
				end
			else
				local op,opmode = insparse(line)

				if not ops[op] then
					print("Illegal instruction \""..op.."\" on line "..linenum.." :(")
					os.exit()
				elseif not ops[op][opmode] then
					print("Illegal mode of \""..op.."\" on line "..linenum.." :(")
					os.exit()
				end

				position = position + ops[op][opmode].bytecount
			end
		elseif line:match("%S+%:$") then
			local label = line:gsub(":","")
			labels[label] = tostring(position)
		elseif line:match("=") then
			local label = line:gsub("%s*=.*$","")
			local val   = line:gsub("^.*=%s*","")

			labels[label] = val
		end
	end
end
--[[
for label,bcount in pairs(labels) do
	print(label.." = "..bcount)
end
--]]

-- TODO: rewrite processing to properly support code positioning and do less things twice

-- assemble

io.input(inputfile)

if not dostdout then
	io.output("output.txt")
end

io.write("v3.0 hex words plain\n")

bytecount = 0
linenum = 0

while io.read(0) do
	local line = io.read("l")
	linenum = linenum + 1

	if line:match("^%s") and line:match("%S") then

		line = line:gsub("%s*;.*$","")

		if line:match("^%s%.word") then
			local vals = line:gsub("^%s.word","")
			for val in string.gmatch(vals, "%S+") do
				local errorval = val
				val = decodenum(val)

				if not val then
					print("Malformed number/label \""..errorval.."\" on line "..linenum.." :(")
					os.exit()
				end

				if outbase == "HEX" then
					val = string.format("%03x",val)
				else
						val = string.format("%03d",val)
				end

				io.write(val," ")

				bytecount = bytecount + 1
			end
			io.write("\n")
		elseif not line:match("^%s%.") then

		local op,opmode = insparse(line)

		-- we've checked program for errors while finding labels already

		ins = ops[op][opmode]


		local opcode = (outbase == "HEX" and ins.hex) or ins.dec
		io.write(opcode," ")


		if line:find("#") then
			local val = line:match("#(%S+)")

			if not val then
				print("Malformed number/label on line "..linenum.." :(")
				os.exit()
			end

			val = labels[val] or val

			local errorval = val
			val = decodenum(val)

			if not val then
				print("Malformed number/label \""..errorval.."\" on line "..linenum.." :(")
				os.exit()
			end

			if outbase == "HEX" then
				val = string.format("%03x",val)
			else
				val = string.format("%03d",val)
			end

			io.write(val," ")

		end

		io.write("\n")

		bytecount = bytecount + ins.bytecount

		end

	end
end

if dostdout then print(" ") end -- a lil offset
print("done! program takes "..bytecount.." TTbytes")

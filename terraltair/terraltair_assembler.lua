#!/usr/bin/env lua

Dictionary={
	DATA={
		VALUE={"1"}, STACK={"1",1},
		PUSH={"011",5}, POP={"011",2},
	},
	ALU ={
		JZ={"01"},JNZ={"10"}, JMP={"11"},DIRECT={"1",2},
		VALUE={"1",5,true},
		ADD={"0000",6,true}, SUB=  {"0001",6,true},
		LSH={"0010",6,true}, RSH=  {"0011",6,true},
		MUL={"0100",6,true}, DIV=  {"0101",6,true},
		MOD={"0110",6,true}, FLAGS={"0111",6,true},
		NOT={"1000",6,true}, AND=  {"1001",6,true},
		OR= {"1010",6,true}, XOR=  {"1011",6,true},
	},
	IO  ={
		WRITE={"1",4}, READ={"0",4},CLOCK={"1",3},

		DIRECT={"1",8,true}, THROW={"1",9,true},

		RED   ="000",BLUE ="001",GREEN="010",YELLOW="011",
		ORANGE="100",BROWN="101",PINK ="110",PURPLE="111",
	},
	CPU ={
		HALT={"1"},NOP={"0"},RESET={"1",1}
	},
}

local empty={"0"}


Modes={
	DATA={code="00",dict=Dictionary.DATA,},
	ALU= {code="01",dict=Dictionary.ALU ,noorderchange=true},
	IO=  {code="10",dict=Dictionary.IO  ,noorderchange=true,multinumber=true},
	CPU= {code="11",dict=Dictionary.CPU ,}
}


Locations={
	A={"000",5},B  ={"001",5},
	M={"010",5},RAM={"011",5},
	X={"100",5},Y  ={"101",5},
	S={"110",5},J  ={"111",5},
}


local shortcut
shortcut=Modes
shortcut.D=shortcut.DATA
shortcut.A=shortcut.ALU
shortcut.I=shortcut.IO
shortcut.C=shortcut.CPU

shortcut=Dictionary.DATA
shortcut["="]=shortcut.VALUE
shortcut["<"]=empty
shortcut[">"]=empty

shortcut=Dictionary.ALU
shortcut["+"]=shortcut.ADD
shortcut["-"]=shortcut.SUB
shortcut["<<"]=shortcut.LSH
shortcut[">>"]=shortcut.RSH
shortcut["*"]=shortcut.MUL
shortcut["/"]=shortcut.DIV
shortcut["%"]=shortcut.MOD
shortcut["!"]=shortcut.NOT
shortcut["&"]=shortcut.AND
shortcut["|"]=shortcut.OR
shortcut["^"]=shortcut.XOR
shortcut.V=shortcut.VALUE

shortcut=Dictionary.IO
shortcut[">"]=shortcut.WRITE
shortcut["<"]=shortcut.READ
shortcut["*"]=shortcut.CLOCK
shortcut["="]=shortcut.DIRECT
shortcut["|"]=shortcut.THROW

shortcut=nil


OrderReversors={[">"]=true,["PUSH"]=true}


HelpMessage=[[usage: lua ttcpu_assembler.lua [source] [options] [outfile]
options:

-h    --help     print this help message
-d    --debug    give additional information on the process
                 (use -dd for even more information)

-f    --file     output into outfile instead of printing
                 the script will use out.hex / out.txt as an outfile
                 if not provided with one

-b    --binary   format output in binary (useful for debug)
-x    --hex      format output in hexadecimal and add a special header
                 for usage in circuit simulators like Logisim
-g    --game     format output in decimal 000-999 format
                 for rewriting onto a ROM in TT

useful things: https://github.com/PinguThePenguin007/terraltair]]


-- https://stackoverflow.com/a/9080080
function ToBits(num,bits)
	-- returns a table of bits, most significant first.
	bits = bits or math.max(1, select(2, math.frexp(num)))
	local t = {} -- will contain the bits
	for b = bits, 1, -1 do
		t[b] = math.fmod(num, 2)
		num = math.floor((num - t[b]) / 2)
	end
	return table.concat(t)
end

local debug=0
local mode="g"
local tofile=false
local infile
local outfile

for i=1,#arg do

	if arg[i]=="-h" or arg[i]=="--help" then
		print(HelpMessage); os.exit()

	elseif arg[i]=="-f" or arg[i]=="--file" then
		tofile=true

	elseif arg[i]=="-b" or arg[i]=="--binary" then
		mode="b"
	elseif arg[i]=="-x" or arg[i]=="--hex" then
		mode="x"
	elseif arg[i]=="-g" or arg[i]=="--game" then
		mode="g"

	elseif arg[i]=="-d" or arg[i]=="--debug" then debug=debug+1
	elseif arg[i]=="-dd" then debug=debug+2

	else
		if not infile then infile=arg[i]
		else outfile=arg[i] end
	end
end

outfile=outfile or ((mode=="x" and "out.hex") or "out.txt")

if not infile then
	io.write("Enter input file name: ")
	infile = io.read()
end

	assert(
	 io.input(infile)
	)
if tofile then
	assert(
	 io.output(outfile)
	)
	if mode=="x" and debug<1 then io.write("v2.0 raw\n") end
end

local labels={}
local instruction_index=0

while io.read(0) do
	local line=io.read("*line")

	local header_word=line:match("%S+")
	if not header_word then goto continue end

	if header_word:find("%:") then
		local value
		if line:find("%=") then
			value=line:match(".*%s+%=%s*(.*)"):upper()
		else
			value=tostring(instruction_index)
		end
		labels[string.upper(header_word:sub(2,-1))]=value
	elseif Dictionary[header_word:upper()] then
		instruction_index=instruction_index+1
	end
	::continue::
end

if debug>=2 then
	for i,v in pairs(labels) do
		io.write(i," = ",v,"\n")
	end
	io.write("\n")
end



io.input():seek("set")


local lineindex=0
while io.read(0) do

	local Locations=Locations


	local line=""

	local addline
	local readnewline
	repeat
		addline=io.read("*line") ; lineindex=lineindex+1

		addline=addline:gsub( addline:match(".*(%-%-.*)") or "", "")

		readnewline=addline:find("%;")

		line= ( line.." ".. (addline:gsub("%s*%;","")) ) :match("^%s*(.-)%s*$"):gsub("%s+"," ")

	until not readnewline

	local modedict


	local header_word=line:match("^%S+")
	if header_word==nil or header_word=="" then goto continue end
	line=line:gsub(header_word.."%s*","",1)


	if header_word:find("%:") then
		goto continue
	else
		modedict=Dictionary[header_word:upper()]
		assert(modedict,"line "..lineindex..": invalid mode or control symbol")
	end

	local instrmode=Modes[header_word:upper()]


	local fullstr={
		[1]=tonumber(instrmode.code.."00000000",2),
		[2]=tonumber("0000000000",2)
	}
	local words={}

	local locposmod=0


	-- https://stackoverflow.com/a/2780182
	for word in line:gmatch("%S+") do

		if OrderReversors[word:upper()] and not instrmode.noorderchange then
			locposmod=3
		end

		if word:sub(1,1)=="$" then
			local lblvalue=labels[word:sub(2,-1):upper()]
			assert(lblvalue,"line "..lineindex..": unrecognized label")

			word=lblvalue
		end

		table.insert(words,word:upper())
	end


	local bits,bitspos,lowerpos
	local numberpos

	for _,word in pairs(words) do
		bits=modedict[word] or Locations[word]

		if type(bits)~="table" then
			bitspos=0
			lowerpos=((instrmode.multinumber and not numberpos) and 1) or 2
			numberpos=true
			if type(bits)=="string" then goto skipif end

			local prefix=string.upper(word:sub(1,2))

			if     prefix=="0B" then
				bits=word:sub(3,-1)

			elseif prefix=="0X" then
				bits=ToBits( tonumber( word:sub(3,-1), 16))

			else
				local value=tonumber(word)
				assert(value,"line "..lineindex..": unrecognized control symbol or malformed number")
				bits=ToBits(value)
			end

		end ::skipif::

		if type(bits)=="table" then
			bitspos=bits[2]
			lowerpos=(bits[3] and 2) or 1
			bits=bits[1]
		end

		fullstr[lowerpos]=fullstr[lowerpos] | (tonumber(bits,2) << ((bitspos or 0)-((Locations[word] and locposmod) or 0)))
		if Locations[word] then locposmod=(locposmod+3)%6 end
	end
	fullstr[1],fullstr[2]=ToBits(fullstr[1],10),ToBits(fullstr[2],10)




	if debug>=1 then
		io.write(header_word," ",line,"\n")
	end

	if     mode=="g" then
		io.write(string.format("%03d",tonumber(fullstr[1],2)),"-",
		         string.format("%03d",tonumber(fullstr[2],2)),"\n")
	elseif mode=="b" then
		io.write(fullstr[1],"\n",fullstr[2],"\n")
	elseif mode=="x" then
		io.write( string.format("%05x", tonumber(fullstr[1]..fullstr[2],2)),"\n" )
	end
	if debug>=1 then io.write("\n") end



	::continue::
end

	io.close(io.input()) ; io.close(io.output())

print("finished with "..instruction_index.." instructions")




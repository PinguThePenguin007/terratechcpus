# graybox

a box full of computing stuff

**table of contents**

- [the snapshot](#the-snapshot)
- [repo contents](#repo-contents)
- [run the assembler](#run-the-assembler)

## the snapshot

to be added :P

## repo contents

this repo contains:

#### a [Logisim Evolution](https://github.com/logisim-evolution/logisim-evolution) circuit file ([here](https://github.com/PinguThePenguin007/terratechcpus/blob/main/graybox_cpu/graybox_cpu.circ))
contains a 1-1 implementation of the CPU and various accompanying peripherals

this can be used to speed up program writing and experiment on stuff without digging around in the physical design

#### an assembler written in the Lua programming language ([here](https://github.com/PinguThePenguin007/terratechcpus/blob/main/graybox_cpu/assembler.lua))
i wrote the syntax based on various snippets of 6502 assembly code that i've seen, though i don't have any actual 6502 experience yet :P

#### some assembly programs as starting examples ([here](https://github.com/PinguThePenguin007/terratechcpus/tree/main/graybox_cpu/assembly_programs))
take a look at these to better understand the assembler syntax and the way things are generally done :)

#### the instruction list ([here](https://github.com/PinguThePenguin007/terratechcpus/blob/main/graybox_cpu/instruction_list.md))
every valid instruction including expansions

the assembler actually uses this file to get available instructions (convenient :P)

#### the documentation and layout
to be added :P

## run the assembler

- [windows](#windows-specific)
- [linux](#linux-specific)
- [mac os](#mac-os-specific)

the assembler doesn't require any external libraries and can be run using Lua 5.1-5.4

---

### windows-specific

the lua executable will be included in [releases](https://github.com/PinguThePenguin007/terratechcpus/releases)

otherwise, [download it here](https://luabinaries.sourceforge.net/download.html)

put lua and the script in the same directory, then open `cmd`

### linux-specific

install lua using your package manager:
##### apt
`
sudo apt install lua
`
##### dnf
`
sudo dnf install lua
`
##### pacman
`
sudo pacman -S lua
`

### mac os-specific

install lua using [brew](https://brew.sh/):
```
brew install lua
```
---

then, run the script:
```
lua assembler.lua --help
```
```
./assembler.lua --help
```

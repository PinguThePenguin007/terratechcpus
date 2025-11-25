# TerrAltair
A virtual CPU made in [TerraTech](https://store.steampowered.com/app/285920/TerraTech)

##### Table of Contents:
- [Capabilities](#capabilities)
- [Snapshots](#snapshots)
- [Circuit](#circuit)
- [Documentation](#documentation)
- [Assembler](#assembler)
  - [How to run it](#how-to-run-it)
    - [Linux](#linux)
    - [Windows](#windows)
    - [MacOS](#macos)
- [Contact me](#contact-me)
## Capabilities
- 7 registers, of which 4 general purpose ones
- Expandable RAM and ROM
- Single-cycle state of the art stack push/pop operaion
- Powerful I/O module with support of up to 8 devices
- Max speed of 3.5 cycles per second (omg so fast)
- Add, subtract, multiply, divide operations and more
- Reset and halt operations
## Snapshots
I will distribute the snapshots using Steam Workshop for now:

* [TBA] The main CPU snapshot
- [TBA] My CPU programs
- [TBA] My miscellaneous I/O modules
## Circuit
A circuit file for [Logisim Evolution](https://github.com/logisim-evolution/logisim-evolution) is available:
- [The circuit](https://github.com/PinguThePenguin007/terraltair/blob/main/TerrAltair.circ)
## Documentation
The assembler documentation will be in GitHub wiki for now:
* [The GitHub wiki](https://github.com/PinguThePenguin007/terraltair/wiki)

* [The instruction layout](https://github.com/PinguThePenguin007/terraltair/blob/main/TerrAltair%20instruction%20layout.txt)

## Assembler

Download the archive from the [releases tab](https://github.com/PinguThePenguin007/terraltair/releases) according to your operating system and unpack it.

### How to run it
#### Linux
Install Lua using your distribution's package manager:
##### Ubuntu/Debian
```
sudo apt install lua
```
##### Fedora
```
sudo dnf install lua
```
##### Arch (and its derivatives)
```
sudo pacman -S lua
```
--- 
<a name="linux-and-macos-instructions"></a>

First, you may need to give the script execution permissions:
```
chmod +111 terraltair_assembler.lua
```
Run the script:
```
lua terraltair_assembler.lua --help
```
Or:
```
./terraltair_assembler.lua --help
```

#### Windows

Run one of the .bat scripts included in the [release](https://github.com/PinguThePenguin007/terraltair/releases). The script names should be self-explanatory 😉

If you want to "build" the release yourself, you'll need to download [the latest Lua binary](https://luabinaries.sourceforge.net/download.html) and put it in the same directory as the assembler and the scripts.

#### MacOS
(Exact instructions TODO, need a Mac tester. Please reach out if you want to help)

I think you'll need brew if you don't want to compile Lua from source. Instructions are [here](https://brew.sh/)

Open your terminal app and run:

```
brew update
brew install lua
```

Follow [those](#linux-and-macos-instructions) instructions next. 


## Contact me
Use Matrix or Discord to ask me any questions about the CPU:
- My matrix:  @pinguthecatgirl:catgirl.cloud
- My discord: @pinguthepenguin_007

For bugs, suggestions or other issues please use [GitHub Issues](https://github.com/PinguThePenguin007/terraltair/issues) :)

*This page will explain the basic structure of the processor.*

---------------------------------------------------------------

graybox consists of several "modules" all linked together with a shared bus. As a rule, modules will have registers that control their operation, that can be written to (or read from). 

The processor's accumulator (ACC) register acts as the primary instrument for transferring data between those registers and memory. Additionally, data can be directly written into any register from the program's memory (via immediate values built into the instructions).

The processor has a single memory space that includes both ROM and RAM (a Von Neumann-like architecture). Any potential peripheral devices will have to be mapped to memory to interface with the unit.

graybox does not reserve any memory regions by default. After being reset, its program counter always starts at memory address 000.
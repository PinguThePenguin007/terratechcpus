*This page will describe the internal registers of the processor.*

------------------------------------------------------------------

|[ACC](#ACC)|[A](#A)|[B](#B)|[X](#X)|
|-----------|-------|-------|-------|

|[SHA](#SHA)|[PC](#PC)|
|-----------|---------|

*Note: every one of these registers (except SHA) can be written to from program memory.*

### ACC

The accumulator is the primary register for data transfer. As a rule, other registers can only exchange data with the accumulator. 

It is used to store or to retrieve data from memory, and store results of arithmetical/logical operations. Jumps can be performed to an address stored in this register.

### A

The first operand of all arithmetical/logical operations. Contents can be freely transferred to/from ACC, it can thus act as as auxillary storage.

### B

The second operand of all arithmetical/logical operations. Has no difference in function from A otherwise. 

### X

The contents of this register are used as the address to access memory. Contents can be transferred from ACC. 

Can also be quickly incremented for sequential memory access.

### SHA

A special register that "shadows" ACC. Used to expedite shuffling data around.

When any value is written to ACC, the previous value that was stored in ACC is copied over to SHA. In order to retrieve the stored value, contents of this register can be swapped around with ACC.

### PC

The program counter. Contains the memory location of the next instruction opcode to be loaded during the next fetch cycle. Automatically increments every fetch cycle or when an immediate value is loaded (to prevent this value from getting executed as an instruction).

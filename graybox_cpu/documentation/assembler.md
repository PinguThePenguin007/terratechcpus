*This page will describe the syntax of the assembler.*

---

The assembler's syntax consists of:
* **Mnemonics**, which are converted into opcodes in the physical program.
* **Operands**, which come after mnemonics and control the operation of the instruction.
* **Labels**, which reference memory adresses and help pinpoint program locations. A kind of operand.
* **Constants**, which are named operands that can be assigned values to in order to make code more flexible. *They're not variables, keep that in mind. :)*
* **Directives**, which don't correspond to physical instructions and instead affect the assembling process.
* **Comments**, which don't have any effect on the final program. :P  



### Mnemonics

Mnemonics are nothing more than a fancy name for instructions. They're used instead of raw opcodes (instruction identifiers) to better clarify what the code is doing and to group together instructions which are similar in function but may have drastically different opcodes.

```
; both of the instructions move data between registers

 mov acc a   ; = 0x050

 mov b acc   ; = 0x053
```

The syntax definition starts with (any amount of) space symbols, followed by the mnemonic, followed by 0 or more operands:

```
 <mnemo> <op> <op>   ; opa gangnam style           (sorry)
```

*See the [instructions.md](./instructions.md) document for the definitive list of all available instructions and explanations of their function.*



### Operands

Operands control and better define the instruction. They're most often used to define locations that are to be written to or read from, or immediate values (stored in the program as a part of an instruction, written directly to a location).

```
 
 mov       a acc ; operands can define locations like registers 
 
 mov     #42 acc ; the "#" symbol defines an immediate value
 
 mov    #0xf acc ; the "0x" prefix defines a hexadecimal value
 
 mov #0b0100 acc ; the "0b" prefix defines a binary value
 
```



### Labels

Labels take on the position of an instruction following it:

```
00: mov #2 a
01: mov #2 acc

   label:
02: mov acc b

03: jmp #label ; evaluates to "jmp 02"
```

The value of the label can then be used as operands for instructions, most often jumps.

A label definition consists of its identifier, followed by a semicolon (:) :

```
<label>:
```

Syntax as an operand is then as follows:

```
<mnemonic> #<label>
```

|*Why do we need those?*|
|--------------------|
|Suppose that we need to relocate the above code somewhere else (or we just want to add some instructions before it). We would then need to count the instructions and update the address that is to be jumped to, which is plain inconvenient. Additionally, labels add clarity to code and make it more readable. :)|



### Constants

Constants are defined similarly to labels, having the following syntax:

```
<constant> = <value>
```

They then may be similarly used as opcodes for instructions:

```
peripheral = 0x36   ; address of some peripheral device

 mov #peripheral x   ; let's communicate with it :D
```



### Directives

*Like mnemonics, directives are identified by a space at the start of the line. It's then followed by the dot (.) symbol and the directive identifier.*

There are two directives available:

```
 .org <address>
```

All code following this directive will be located starting at `address`.

*right now it only affects labels, you would have to manually put code where you want it to be in the final program :( it's on my to-do list though*

```
 .word <value> ...
```

Put an arbitrary `value` (or multiple consecutive values) at the current location.



### Comments

Any text after the `;` symbol is ignored by the assembler.

```
; hi, i'm a comment!
 mov acc b   ; i'm a comment, too!
```

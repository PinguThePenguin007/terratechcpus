*This page will list all available processor instructions.*

---

|           |           |           |           |           |
|:---------:|:---------:|:---------:|:---------:|:---------:|
|[nop](#nop)|           |           |           |           |
|[mov](#mov)|[swp](#swp)|[lod](#lod)|[str](#str)|[inc](#inc)|
|[add](#add)|[sub](#sub)|[mul](#mul)|[div](#div)|           |
|[jng](#jng)|[jeq](#jeq)|[jne](#jne)|[jgt](#jgt)|[jlt](#jlt)|
|[jmp](#jmp)|           |           |           |           |

*All instructions (except `nop`) will take 2 clock cycles to execute.*



### nop

Fetch the next instruction.

```
 nop
```


*One special thing about this instruction is that it will only take 1 clock cycle to execute.*



### mov

Move data from register `source` to register `destination`.

```
 mov <source> <destination>
```

Move a fixed (immediate) `value` to register `destination`.

```
 mov #<value> <destination>
```



### swp

Swap data from (ACC and SHA) to (SHA and ACC) simultaneously.

```
 swp
```


### lod

Load a piece of data from RAM into ACC.

```
 lod
```


### str

Store data from ACC into RAM.

```
 str
```


### inc

Increment X by 1.

```
 inc
```


### add

Add A and B together and store the result in ACC.

```
 add
```


### sub

Subtract B from A and store the result in ACC.

```
 sub
```


### mul

Multiply A by B and store the result in ACC.

```
 mul
```


### div

Divide A by B and store the result in ACC.

```
 div
```


### jng

Perform a jump if A - B is less than zero (**n**e**g**ative).


Jump to ACC.
```
 jng ACC
```

Jump to `value`.
```
 jng #<value>
```


### jeq

Perform a jump if A is **eq**ual to B.


Jump to ACC.
```
 jeq ACC
```

Jump to `value`.
```
 jeq #<value>
```


### jne

Perform a jump if A is **n**ot **e**qual to B.


Jump to ACC.
```
 jne ACC
```

Jump to `value`.
```
 jne #<value>
```


### jgt

Perform a jump if A is **g**reater **t**han B.


Jump to ACC.
```
 jgt ACC
```

Jump to `value`.
```
 jgt #<value>
```


### jlt

Perform a jump if A is **l**ess **t**han B.


Jump to ACC.
```
 jlt ACC
```

Jump to `value`.
```
 jlt #<value>
```


### jmp

Perform a jump with no conditions.


Jump to ACC.
```
 jmp ACC
```

Jump to `value`.
```
 jmp #<value>
```


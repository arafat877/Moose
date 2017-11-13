# YAK CPU
## Implementation of RISC V architecture in VHDL language

## Architecture description

 YAK CPU will contain 32 registers, according to official RISC V datasheet (found [here](https://riscv.org/specifications/)). Each of registers will be 32 bits long. It will go through standard 5 stage RISC pipeline.
![](http://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Fivestagespipeline.png/800px-Fivestagespipeline.png)  
 On the picture given We can see that pipeline has Instruction fetch, Instruction decode, Instruction execute, Memory access and Write-back phases. Fetch phase transfers instruction opcode from RAM to Instruction register. According to opcode, in decode phase CPU decides which signals should be on or off for instruction to execute correctly.Execute phase accesses ALU and does actual computing. If any data in memory has to be accessed, It is done in memory access phase. Write-Back phase transfers operation result to registers.

## Supported instructions  
 YAK CPU will  support Load and Store to memory instructions, Arithmetic and Logic Instructions, Compare and Branch instructions. Instructions will be preformed on 32bit numbers.

### Load and store instructions:
* LOAD address,register
* STORE register, address

### Arithmetic and logic instructions  
#### Arithmetic Instructions will be represented as : `opcode destination,source1,source2`  
* ADD dest,src1,src2 
* SUB dest,src1,src2
* ADDI dest,src1,I - immediate addition 
* AND dest,src1,src2
* OR dest,src1,src2
* XOR dest,src1,src2
* ANDI dest,src1,I
* ORI dest,src1,I
* XORI dest,src1,I

### Compare and Branch instructions
* CMP register,register/value
* BEQ src1,src2,label - branch if equal
* BNE src1,src2,label - branch if not equal
* BLT src1,src2,label - branch if src1 is lower than src2
* BGE src1,src2,label - branch if src1 is grater than src2  

## UPDATES :
 `13.11.2017` - first version of Program Counter working



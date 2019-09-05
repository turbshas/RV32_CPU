
SimpleFunctionCall.elf:     file format elf32-littleriscv


Disassembly of section .text:

01000000 <main>:
 1000000:	ff010113          	addi	x2,x2,-16
 1000004:	00112623          	sw	x1,12(x2)
 1000008:	030000ef          	jal	x1,1000038 <test>
 100000c:	00050793          	addi	x15,x10,0
 1000010:	00078513          	addi	x10,x15,0
 1000014:	00c12083          	lw	x1,12(x2)
 1000018:	01010113          	addi	x2,x2,16
 100001c:	00008067          	jalr	x0,0(x1)

01000020 <pass>:
 1000020:	00100793          	addi	x15,x0,1
 1000024:	00078513          	addi	x10,x15,0
 1000028:	00008067          	jalr	x0,0(x1)

0100002c <get_value>:
 100002c:	00300793          	addi	x15,x0,3
 1000030:	00078513          	addi	x10,x15,0
 1000034:	00008067          	jalr	x0,0(x1)

01000038 <test>:
 1000038:	fe010113          	addi	x2,x2,-32
 100003c:	00112e23          	sw	x1,28(x2)
 1000040:	00812c23          	sw	x8,24(x2)
 1000044:	fe9ff0ef          	jal	x1,100002c <get_value>
 1000048:	00050413          	addi	x8,x10,0
 100004c:	fe1ff0ef          	jal	x1,100002c <get_value>
 1000050:	00050793          	addi	x15,x10,0
 1000054:	00f407b3          	add	x15,x8,x15
 1000058:	00f12623          	sw	x15,12(x2)
 100005c:	00c12703          	lw	x14,12(x2)
 1000060:	00600793          	addi	x15,x0,6
 1000064:	00f71863          	bne	x14,x15,1000074 <test+0x3c>
 1000068:	fb9ff0ef          	jal	x1,1000020 <pass>
 100006c:	00050793          	addi	x15,x10,0
 1000070:	00c0006f          	jal	x0,100007c <test+0x44>
 1000074:	01c000ef          	jal	x1,1000090 <fail>
 1000078:	00050793          	addi	x15,x10,0
 100007c:	00078513          	addi	x10,x15,0
 1000080:	01c12083          	lw	x1,28(x2)
 1000084:	01812403          	lw	x8,24(x2)
 1000088:	02010113          	addi	x2,x2,32
 100008c:	00008067          	jalr	x0,0(x1)

01000090 <fail>:
 1000090:	ff010113          	addi	x2,x2,-16
 1000094:	00600793          	addi	x15,x0,6
 1000098:	00f12623          	sw	x15,12(x2)
 100009c:	00c12783          	lw	x15,12(x2)
 10000a0:	00478793          	addi	x15,x15,4
 10000a4:	00f12623          	sw	x15,12(x2)
 10000a8:	00000793          	addi	x15,x0,0
 10000ac:	00078513          	addi	x10,x15,0
 10000b0:	01010113          	addi	x2,x2,16
 10000b4:	00008067          	jalr	x0,0(x1)

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	fmsub.d	f6,f6,f4,f7,rmm
   4:	2820                	c.fld	f8,80(x8)
   6:	29554e47          	fmsub.s	f28,f10,f21,f5,rmm
   a:	3820                	c.fld	f8,112(x8)
   c:	332e                	c.fldsp	f6,232(x2)
   e:	302e                	c.fldsp	f0,232(x2)
	...

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	1941                	c.addi	x18,-16
   2:	0000                	c.unimp
   4:	7200                	c.flw	f8,32(x12)
   6:	7369                	c.lui	x6,0xffffa
   8:	01007663          	bgeu	x0,x16,14 <main-0xffffec>
   c:	0000000f          	fence	unknown,unknown
  10:	7205                	c.lui	x4,0xfffe1
  12:	3376                	c.fldsp	f6,376(x2)
  14:	6932                	c.flwsp	f18,12(x2)
  16:	7032                	c.flwsp	f0,44(x2)
  18:	0030                	c.addi4spn	x12,x2,8

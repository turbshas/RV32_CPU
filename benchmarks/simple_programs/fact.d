
fact.elf:     file format elf32-littleriscv


Disassembly of section .text:

01000000 <main>:
 1000000:	fe010113          	addi	x2,x2,-32
 1000004:	00112e23          	sw	x1,28(x2)
 1000008:	00012623          	sw	x0,12(x2)
 100000c:	01c0006f          	jal	x0,1000028 <main+0x28>
 1000010:	00c12503          	lw	x10,12(x2)
 1000014:	03c000ef          	jal	x1,1000050 <factorial>
 1000018:	00a12423          	sw	x10,8(x2)
 100001c:	00c12783          	lw	x15,12(x2)
 1000020:	00178793          	addi	x15,x15,1
 1000024:	00f12623          	sw	x15,12(x2)
 1000028:	00c12703          	lw	x14,12(x2)
 100002c:	00900793          	addi	x15,x0,9
 1000030:	fee7d0e3          	bge	x15,x14,1000010 <main+0x10>
 1000034:	00812503          	lw	x10,8(x2)
 1000038:	094000ef          	jal	x1,10000cc <test>
 100003c:	00050793          	addi	x15,x10,0
 1000040:	00078513          	addi	x10,x15,0
 1000044:	01c12083          	lw	x1,28(x2)
 1000048:	02010113          	addi	x2,x2,32
 100004c:	00008067          	jalr	x0,0(x1)

01000050 <factorial>:
 1000050:	fd010113          	addi	x2,x2,-48
 1000054:	02112623          	sw	x1,44(x2)
 1000058:	00a12623          	sw	x10,12(x2)
 100005c:	00012e23          	sw	x0,28(x2)
 1000060:	00012c23          	sw	x0,24(x2)
 1000064:	00c12783          	lw	x15,12(x2)
 1000068:	00079663          	bne	x15,x0,1000074 <factorial+0x24>
 100006c:	00100793          	addi	x15,x0,1
 1000070:	04c0006f          	jal	x0,10000bc <factorial+0x6c>
 1000074:	00c12783          	lw	x15,12(x2)
 1000078:	fff78793          	addi	x15,x15,-1
 100007c:	00078513          	addi	x10,x15,0
 1000080:	fd1ff0ef          	jal	x1,1000050 <factorial>
 1000084:	00a12a23          	sw	x10,20(x2)
 1000088:	00012e23          	sw	x0,28(x2)
 100008c:	0200006f          	jal	x0,10000ac <factorial+0x5c>
 1000090:	01812703          	lw	x14,24(x2)
 1000094:	01412783          	lw	x15,20(x2)
 1000098:	00f707b3          	add	x15,x14,x15
 100009c:	00f12c23          	sw	x15,24(x2)
 10000a0:	01c12783          	lw	x15,28(x2)
 10000a4:	00178793          	addi	x15,x15,1
 10000a8:	00f12e23          	sw	x15,28(x2)
 10000ac:	01c12703          	lw	x14,28(x2)
 10000b0:	00c12783          	lw	x15,12(x2)
 10000b4:	fcf74ee3          	blt	x14,x15,1000090 <factorial+0x40>
 10000b8:	01812783          	lw	x15,24(x2)
 10000bc:	00078513          	addi	x10,x15,0
 10000c0:	02c12083          	lw	x1,44(x2)
 10000c4:	03010113          	addi	x2,x2,48
 10000c8:	00008067          	jalr	x0,0(x1)

010000cc <test>:
 10000cc:	fe010113          	addi	x2,x2,-32
 10000d0:	00112e23          	sw	x1,28(x2)
 10000d4:	00a12623          	sw	x10,12(x2)
 10000d8:	00c12703          	lw	x14,12(x2)
 10000dc:	000597b7          	lui	x15,0x59
 10000e0:	98078793          	addi	x15,x15,-1664 # 58980 <main-0xfa7680>
 10000e4:	00f71863          	bne	x14,x15,10000f4 <test+0x28>
 10000e8:	024000ef          	jal	x1,100010c <pass>
 10000ec:	00050793          	addi	x15,x10,0
 10000f0:	00c0006f          	jal	x0,10000fc <test+0x30>
 10000f4:	024000ef          	jal	x1,1000118 <fail>
 10000f8:	00050793          	addi	x15,x10,0
 10000fc:	00078513          	addi	x10,x15,0
 1000100:	01c12083          	lw	x1,28(x2)
 1000104:	02010113          	addi	x2,x2,32
 1000108:	00008067          	jalr	x0,0(x1)

0100010c <pass>:
 100010c:	00100793          	addi	x15,x0,1
 1000110:	00078513          	addi	x10,x15,0
 1000114:	00008067          	jalr	x0,0(x1)

01000118 <fail>:
 1000118:	00000793          	addi	x15,x0,0
 100011c:	00078513          	addi	x10,x15,0
 1000120:	00008067          	jalr	x0,0(x1)

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

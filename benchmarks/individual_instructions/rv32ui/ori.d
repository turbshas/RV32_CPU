
rv32ui/ori.elf:     file format elf32-littleriscv


Disassembly of section .text.init:

01000000 <_start>:
 1000000:	a081                	c.j	1000040 <reset_vector>
 1000002:	0001                	c.addi	x0,0

01000004 <trap_vector>:
 1000004:	34202f73          	csrrs	x30,mcause,x0
 1000008:	4fa1                	c.li	x31,8
 100000a:	03ff0663          	beq	x30,x31,1000036 <write_tohost>
 100000e:	4fa5                	c.li	x31,9
 1000010:	03ff0363          	beq	x30,x31,1000036 <write_tohost>
 1000014:	4fad                	c.li	x31,11
 1000016:	03ff0063          	beq	x30,x31,1000036 <write_tohost>
 100001a:	ff000f17          	auipc	x30,0xff000
 100001e:	fe6f0f13          	addi	x30,x30,-26 # 0 <_start-0x1000000>
 1000022:	000f0363          	beq	x30,x0,1000028 <trap_vector+0x24>
 1000026:	8f02                	c.jr	x30
 1000028:	34202f73          	csrrs	x30,mcause,x0
 100002c:	000f5363          	bge	x30,x0,1000032 <handle_exception>
 1000030:	a009                	c.j	1000032 <handle_exception>

01000032 <handle_exception>:
 1000032:	5391e193          	ori	x3,x3,1337

01000036 <write_tohost>:
 1000036:	00001f17          	auipc	x30,0x1
 100003a:	fc3f2523          	sw	x3,-54(x30) # 1001000 <tohost>
 100003e:	bfe5                	c.j	1000036 <write_tohost>

01000040 <reset_vector>:
 1000040:	f1402573          	csrrs	x10,mhartid,x0
 1000044:	e101                	c.bnez	x10,1000044 <reset_vector+0x4>
 1000046:	00000297          	auipc	x5,0x0
 100004a:	01228293          	addi	x5,x5,18 # 1000058 <reset_vector+0x18>
 100004e:	30529073          	csrrw	x0,mtvec,x5
 1000052:	18005073          	csrrwi	x0,satp,0
 1000056:	0001                	c.addi	x0,0
 1000058:	00000297          	auipc	x5,0x0
 100005c:	02028293          	addi	x5,x5,32 # 1000078 <reset_vector+0x38>
 1000060:	30529073          	csrrw	x0,mtvec,x5
 1000064:	800002b7          	lui	x5,0x80000
 1000068:	fff28293          	addi	x5,x5,-1 # 7fffffff <_end+0x7effdfff>
 100006c:	3b029073          	csrrw	x0,pmpaddr0,x5
 1000070:	42fd                	c.li	x5,31
 1000072:	3a029073          	csrrw	x0,pmpcfg0,x5
 1000076:	0001                	c.addi	x0,0
 1000078:	00000297          	auipc	x5,0x0
 100007c:	01828293          	addi	x5,x5,24 # 1000090 <reset_vector+0x50>
 1000080:	30529073          	csrrw	x0,mtvec,x5
 1000084:	30205073          	csrrwi	x0,medeleg,0
 1000088:	30305073          	csrrwi	x0,mideleg,0
 100008c:	30405073          	csrrwi	x0,mie,0
 1000090:	4181                	c.li	x3,0
 1000092:	00000297          	auipc	x5,0x0
 1000096:	f7228293          	addi	x5,x5,-142 # 1000004 <trap_vector>
 100009a:	30529073          	csrrw	x0,mtvec,x5
 100009e:	4505                	c.li	x10,1
 10000a0:	057e                	c.slli	x10,0x1f
 10000a2:	00054763          	blt	x10,x0,10000b0 <reset_vector+0x70>
 10000a6:	0ff0000f          	fence	iorw,iorw
 10000aa:	4185                	c.li	x3,1
 10000ac:	00000073          	ecall
 10000b0:	ff000297          	auipc	x5,0xff000
 10000b4:	f5028293          	addi	x5,x5,-176 # 0 <_start-0x1000000>
 10000b8:	00028e63          	beq	x5,x0,10000d4 <reset_vector+0x94>
 10000bc:	10529073          	csrrw	x0,stvec,x5
 10000c0:	0000b2b7          	lui	x5,0xb
 10000c4:	10928293          	addi	x5,x5,265 # b109 <_start-0xff4ef7>
 10000c8:	30229073          	csrrw	x0,medeleg,x5
 10000cc:	30202373          	csrrs	x6,medeleg,x0
 10000d0:	f66291e3          	bne	x5,x6,1000032 <handle_exception>
 10000d4:	30005073          	csrrwi	x0,mstatus,0
 10000d8:	00000297          	auipc	x5,0x0
 10000dc:	01428293          	addi	x5,x5,20 # 10000ec <test_2>
 10000e0:	34129073          	csrrw	x0,mepc,x5
 10000e4:	f1402573          	csrrs	x10,mhartid,x0
 10000e8:	30200073          	mret

010000ec <test_2>:
 10000ec:	ff0100b7          	lui	x1,0xff010
 10000f0:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 10000f4:	f0f0e713          	ori	x14,x1,-241
 10000f8:	f0f00e93          	addi	x29,x0,-241
 10000fc:	4189                	c.li	x3,2
 10000fe:	17d71f63          	bne	x14,x29,100027c <fail>

01000102 <test_3>:
 1000102:	0ff010b7          	lui	x1,0xff01
 1000106:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 100010a:	0f00e713          	ori	x14,x1,240
 100010e:	0ff01eb7          	lui	x29,0xff01
 1000112:	ff0e8e93          	addi	x29,x29,-16 # ff00ff0 <_end+0xeefeff0>
 1000116:	418d                	c.li	x3,3
 1000118:	17d71263          	bne	x14,x29,100027c <fail>

0100011c <test_4>:
 100011c:	00ff00b7          	lui	x1,0xff0
 1000120:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 1000124:	70f0e713          	ori	x14,x1,1807
 1000128:	00ff0eb7          	lui	x29,0xff0
 100012c:	7ffe8e93          	addi	x29,x29,2047 # ff07ff <_start-0xf801>
 1000130:	4191                	c.li	x3,4
 1000132:	15d71563          	bne	x14,x29,100027c <fail>

01000136 <test_5>:
 1000136:	f00ff0b7          	lui	x1,0xf00ff
 100013a:	00f08093          	addi	x1,x1,15 # f00ff00f <_end+0xef0fd00f>
 100013e:	0f00e713          	ori	x14,x1,240
 1000142:	f00ffeb7          	lui	x29,0xf00ff
 1000146:	0ffe8e93          	addi	x29,x29,255 # f00ff0ff <_end+0xef0fd0ff>
 100014a:	4195                	c.li	x3,5
 100014c:	13d71863          	bne	x14,x29,100027c <fail>

01000150 <test_6>:
 1000150:	ff0100b7          	lui	x1,0xff010
 1000154:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 1000158:	0f00e093          	ori	x1,x1,240
 100015c:	ff010eb7          	lui	x29,0xff010
 1000160:	ff0e8e93          	addi	x29,x29,-16 # ff00fff0 <_end+0xfe00dff0>
 1000164:	4199                	c.li	x3,6
 1000166:	11d09b63          	bne	x1,x29,100027c <fail>

0100016a <test_7>:
 100016a:	4201                	c.li	x4,0
 100016c:	0ff010b7          	lui	x1,0xff01
 1000170:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 1000174:	0f00e713          	ori	x14,x1,240
 1000178:	00070313          	addi	x6,x14,0
 100017c:	0205                	c.addi	x4,1
 100017e:	4289                	c.li	x5,2
 1000180:	fe5216e3          	bne	x4,x5,100016c <test_7+0x2>
 1000184:	0ff01eb7          	lui	x29,0xff01
 1000188:	ff0e8e93          	addi	x29,x29,-16 # ff00ff0 <_end+0xeefeff0>
 100018c:	419d                	c.li	x3,7
 100018e:	0fd31763          	bne	x6,x29,100027c <fail>

01000192 <test_8>:
 1000192:	4201                	c.li	x4,0
 1000194:	00ff00b7          	lui	x1,0xff0
 1000198:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 100019c:	70f0e713          	ori	x14,x1,1807
 10001a0:	0001                	c.addi	x0,0
 10001a2:	00070313          	addi	x6,x14,0
 10001a6:	0205                	c.addi	x4,1
 10001a8:	4289                	c.li	x5,2
 10001aa:	fe5215e3          	bne	x4,x5,1000194 <test_8+0x2>
 10001ae:	00ff0eb7          	lui	x29,0xff0
 10001b2:	7ffe8e93          	addi	x29,x29,2047 # ff07ff <_start-0xf801>
 10001b6:	41a1                	c.li	x3,8
 10001b8:	0dd31263          	bne	x6,x29,100027c <fail>

010001bc <test_9>:
 10001bc:	4201                	c.li	x4,0
 10001be:	f00ff0b7          	lui	x1,0xf00ff
 10001c2:	00f08093          	addi	x1,x1,15 # f00ff00f <_end+0xef0fd00f>
 10001c6:	0f00e713          	ori	x14,x1,240
 10001ca:	0001                	c.addi	x0,0
 10001cc:	0001                	c.addi	x0,0
 10001ce:	00070313          	addi	x6,x14,0
 10001d2:	0205                	c.addi	x4,1
 10001d4:	4289                	c.li	x5,2
 10001d6:	fe5214e3          	bne	x4,x5,10001be <test_9+0x2>
 10001da:	f00ffeb7          	lui	x29,0xf00ff
 10001de:	0ffe8e93          	addi	x29,x29,255 # f00ff0ff <_end+0xef0fd0ff>
 10001e2:	41a5                	c.li	x3,9
 10001e4:	09d31c63          	bne	x6,x29,100027c <fail>

010001e8 <test_10>:
 10001e8:	4201                	c.li	x4,0
 10001ea:	0ff010b7          	lui	x1,0xff01
 10001ee:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 10001f2:	0f00e713          	ori	x14,x1,240
 10001f6:	0205                	c.addi	x4,1
 10001f8:	4289                	c.li	x5,2
 10001fa:	fe5218e3          	bne	x4,x5,10001ea <test_10+0x2>
 10001fe:	0ff01eb7          	lui	x29,0xff01
 1000202:	ff0e8e93          	addi	x29,x29,-16 # ff00ff0 <_end+0xeefeff0>
 1000206:	41a9                	c.li	x3,10
 1000208:	07d71a63          	bne	x14,x29,100027c <fail>

0100020c <test_11>:
 100020c:	4201                	c.li	x4,0
 100020e:	00ff00b7          	lui	x1,0xff0
 1000212:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 1000216:	0001                	c.addi	x0,0
 1000218:	f0f0e713          	ori	x14,x1,-241
 100021c:	0205                	c.addi	x4,1
 100021e:	4289                	c.li	x5,2
 1000220:	fe5217e3          	bne	x4,x5,100020e <test_11+0x2>
 1000224:	fff00e93          	addi	x29,x0,-1
 1000228:	41ad                	c.li	x3,11
 100022a:	05d71963          	bne	x14,x29,100027c <fail>

0100022e <test_12>:
 100022e:	4201                	c.li	x4,0
 1000230:	f00ff0b7          	lui	x1,0xf00ff
 1000234:	00f08093          	addi	x1,x1,15 # f00ff00f <_end+0xef0fd00f>
 1000238:	0001                	c.addi	x0,0
 100023a:	0001                	c.addi	x0,0
 100023c:	0f00e713          	ori	x14,x1,240
 1000240:	0205                	c.addi	x4,1
 1000242:	4289                	c.li	x5,2
 1000244:	fe5216e3          	bne	x4,x5,1000230 <test_12+0x2>
 1000248:	f00ffeb7          	lui	x29,0xf00ff
 100024c:	0ffe8e93          	addi	x29,x29,255 # f00ff0ff <_end+0xef0fd0ff>
 1000250:	41b1                	c.li	x3,12
 1000252:	03d71563          	bne	x14,x29,100027c <fail>

01000256 <test_13>:
 1000256:	0f006093          	ori	x1,x0,240
 100025a:	0f000e93          	addi	x29,x0,240
 100025e:	41b5                	c.li	x3,13
 1000260:	01d09e63          	bne	x1,x29,100027c <fail>

01000264 <test_14>:
 1000264:	00ff00b7          	lui	x1,0xff0
 1000268:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 100026c:	70f0e013          	ori	x0,x1,1807
 1000270:	4e81                	c.li	x29,0
 1000272:	41b9                	c.li	x3,14
 1000274:	01d01463          	bne	x0,x29,100027c <fail>
 1000278:	00301b63          	bne	x0,x3,100028e <pass>

0100027c <fail>:
 100027c:	0ff0000f          	fence	iorw,iorw
 1000280:	00018063          	beq	x3,x0,1000280 <fail+0x4>
 1000284:	0186                	c.slli	x3,0x1
 1000286:	0011e193          	ori	x3,x3,1
 100028a:	00000073          	ecall

0100028e <pass>:
 100028e:	0ff0000f          	fence	iorw,iorw
 1000292:	4185                	c.li	x3,1
 1000294:	00000073          	ecall
	...

Disassembly of section .tohost:

01001000 <tohost>:
	...

01001040 <fromhost>:
	...

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	3241                	c.jal	fffff980 <_end+0xfeffd980>
   2:	0000                	c.unimp
   4:	7200                	c.flw	f8,32(x12)
   6:	7369                	c.lui	x6,0xffffa
   8:	01007663          	bgeu	x0,x16,14 <_start-0xffffec>
   c:	0028                	c.addi4spn	x10,x2,8
   e:	0000                	c.unimp
  10:	7205                	c.lui	x4,0xfffe1
  12:	3376                	c.fldsp	f6,376(x2)
  14:	6932                	c.flwsp	f18,12(x2)
  16:	7032                	c.flwsp	f0,44(x2)
  18:	5f30                	c.lw	x12,120(x14)
  1a:	326d                	c.jal	fffff9c4 <_end+0xfeffd9c4>
  1c:	3070                	c.fld	f12,224(x8)
  1e:	615f 7032 5f30      	0x5f307032615f
  24:	3266                	c.fldsp	f4,120(x2)
  26:	3070                	c.fld	f12,224(x8)
  28:	645f 7032 5f30      	0x5f307032645f
  2e:	30703263          	0x30703263
	...

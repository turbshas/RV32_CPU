
rv32ui/sltiu.elf:     file format elf32-littleriscv


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
 10000ec:	4081                	c.li	x1,0
 10000ee:	0000b713          	sltiu	x14,x1,0
 10000f2:	4e81                	c.li	x29,0
 10000f4:	4189                	c.li	x3,2
 10000f6:	1bd71f63          	bne	x14,x29,10002b4 <fail>

010000fa <test_3>:
 10000fa:	4085                	c.li	x1,1
 10000fc:	0010b713          	sltiu	x14,x1,1
 1000100:	4e81                	c.li	x29,0
 1000102:	418d                	c.li	x3,3
 1000104:	1bd71863          	bne	x14,x29,10002b4 <fail>

01000108 <test_4>:
 1000108:	408d                	c.li	x1,3
 100010a:	0070b713          	sltiu	x14,x1,7
 100010e:	4e85                	c.li	x29,1
 1000110:	4191                	c.li	x3,4
 1000112:	1bd71163          	bne	x14,x29,10002b4 <fail>

01000116 <test_5>:
 1000116:	409d                	c.li	x1,7
 1000118:	0030b713          	sltiu	x14,x1,3
 100011c:	4e81                	c.li	x29,0
 100011e:	4195                	c.li	x3,5
 1000120:	19d71a63          	bne	x14,x29,10002b4 <fail>

01000124 <test_6>:
 1000124:	4081                	c.li	x1,0
 1000126:	8000b713          	sltiu	x14,x1,-2048
 100012a:	4e85                	c.li	x29,1
 100012c:	4199                	c.li	x3,6
 100012e:	19d71363          	bne	x14,x29,10002b4 <fail>

01000132 <test_7>:
 1000132:	800000b7          	lui	x1,0x80000
 1000136:	0000b713          	sltiu	x14,x1,0
 100013a:	4e81                	c.li	x29,0
 100013c:	419d                	c.li	x3,7
 100013e:	17d71b63          	bne	x14,x29,10002b4 <fail>

01000142 <test_8>:
 1000142:	800000b7          	lui	x1,0x80000
 1000146:	8000b713          	sltiu	x14,x1,-2048
 100014a:	4e85                	c.li	x29,1
 100014c:	41a1                	c.li	x3,8
 100014e:	17d71363          	bne	x14,x29,10002b4 <fail>

01000152 <test_9>:
 1000152:	4081                	c.li	x1,0
 1000154:	7ff0b713          	sltiu	x14,x1,2047
 1000158:	4e85                	c.li	x29,1
 100015a:	41a5                	c.li	x3,9
 100015c:	15d71c63          	bne	x14,x29,10002b4 <fail>

01000160 <test_10>:
 1000160:	800000b7          	lui	x1,0x80000
 1000164:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 1000168:	0000b713          	sltiu	x14,x1,0
 100016c:	4e81                	c.li	x29,0
 100016e:	41a9                	c.li	x3,10
 1000170:	15d71263          	bne	x14,x29,10002b4 <fail>

01000174 <test_11>:
 1000174:	800000b7          	lui	x1,0x80000
 1000178:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 100017c:	7ff0b713          	sltiu	x14,x1,2047
 1000180:	4e81                	c.li	x29,0
 1000182:	41ad                	c.li	x3,11
 1000184:	13d71863          	bne	x14,x29,10002b4 <fail>

01000188 <test_12>:
 1000188:	800000b7          	lui	x1,0x80000
 100018c:	7ff0b713          	sltiu	x14,x1,2047
 1000190:	4e81                	c.li	x29,0
 1000192:	41b1                	c.li	x3,12
 1000194:	13d71063          	bne	x14,x29,10002b4 <fail>

01000198 <test_13>:
 1000198:	800000b7          	lui	x1,0x80000
 100019c:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 10001a0:	8000b713          	sltiu	x14,x1,-2048
 10001a4:	4e85                	c.li	x29,1
 10001a6:	41b5                	c.li	x3,13
 10001a8:	11d71663          	bne	x14,x29,10002b4 <fail>

010001ac <test_14>:
 10001ac:	4081                	c.li	x1,0
 10001ae:	fff0b713          	sltiu	x14,x1,-1
 10001b2:	4e85                	c.li	x29,1
 10001b4:	41b9                	c.li	x3,14
 10001b6:	0fd71f63          	bne	x14,x29,10002b4 <fail>

010001ba <test_15>:
 10001ba:	fff00093          	addi	x1,x0,-1
 10001be:	0010b713          	sltiu	x14,x1,1
 10001c2:	4e81                	c.li	x29,0
 10001c4:	41bd                	c.li	x3,15
 10001c6:	0fd71763          	bne	x14,x29,10002b4 <fail>

010001ca <test_16>:
 10001ca:	fff00093          	addi	x1,x0,-1
 10001ce:	fff0b713          	sltiu	x14,x1,-1
 10001d2:	4e81                	c.li	x29,0
 10001d4:	41c1                	c.li	x3,16
 10001d6:	0dd71f63          	bne	x14,x29,10002b4 <fail>

010001da <test_17>:
 10001da:	40ad                	c.li	x1,11
 10001dc:	00d0b093          	sltiu	x1,x1,13
 10001e0:	4e85                	c.li	x29,1
 10001e2:	41c5                	c.li	x3,17
 10001e4:	0dd09863          	bne	x1,x29,10002b4 <fail>

010001e8 <test_18>:
 10001e8:	4201                	c.li	x4,0
 10001ea:	40bd                	c.li	x1,15
 10001ec:	00a0b713          	sltiu	x14,x1,10
 10001f0:	00070313          	addi	x6,x14,0
 10001f4:	0205                	c.addi	x4,1
 10001f6:	4289                	c.li	x5,2
 10001f8:	fe5219e3          	bne	x4,x5,10001ea <test_18+0x2>
 10001fc:	4e81                	c.li	x29,0
 10001fe:	41c9                	c.li	x3,18
 1000200:	0bd31a63          	bne	x6,x29,10002b4 <fail>

01000204 <test_19>:
 1000204:	4201                	c.li	x4,0
 1000206:	40a9                	c.li	x1,10
 1000208:	0100b713          	sltiu	x14,x1,16
 100020c:	0001                	c.addi	x0,0
 100020e:	00070313          	addi	x6,x14,0
 1000212:	0205                	c.addi	x4,1
 1000214:	4289                	c.li	x5,2
 1000216:	fe5218e3          	bne	x4,x5,1000206 <test_19+0x2>
 100021a:	4e85                	c.li	x29,1
 100021c:	41cd                	c.li	x3,19
 100021e:	09d31b63          	bne	x6,x29,10002b4 <fail>

01000222 <test_20>:
 1000222:	4201                	c.li	x4,0
 1000224:	40c1                	c.li	x1,16
 1000226:	0090b713          	sltiu	x14,x1,9
 100022a:	0001                	c.addi	x0,0
 100022c:	0001                	c.addi	x0,0
 100022e:	00070313          	addi	x6,x14,0
 1000232:	0205                	c.addi	x4,1
 1000234:	4289                	c.li	x5,2
 1000236:	fe5217e3          	bne	x4,x5,1000224 <test_20+0x2>
 100023a:	4e81                	c.li	x29,0
 100023c:	41d1                	c.li	x3,20
 100023e:	07d31b63          	bne	x6,x29,10002b4 <fail>

01000242 <test_21>:
 1000242:	4201                	c.li	x4,0
 1000244:	40ad                	c.li	x1,11
 1000246:	00f0b713          	sltiu	x14,x1,15
 100024a:	0205                	c.addi	x4,1
 100024c:	4289                	c.li	x5,2
 100024e:	fe521be3          	bne	x4,x5,1000244 <test_21+0x2>
 1000252:	4e85                	c.li	x29,1
 1000254:	41d5                	c.li	x3,21
 1000256:	05d71f63          	bne	x14,x29,10002b4 <fail>

0100025a <test_22>:
 100025a:	4201                	c.li	x4,0
 100025c:	40c5                	c.li	x1,17
 100025e:	0001                	c.addi	x0,0
 1000260:	0080b713          	sltiu	x14,x1,8
 1000264:	0205                	c.addi	x4,1
 1000266:	4289                	c.li	x5,2
 1000268:	fe521ae3          	bne	x4,x5,100025c <test_22+0x2>
 100026c:	4e81                	c.li	x29,0
 100026e:	41d9                	c.li	x3,22
 1000270:	05d71263          	bne	x14,x29,10002b4 <fail>

01000274 <test_23>:
 1000274:	4201                	c.li	x4,0
 1000276:	40b1                	c.li	x1,12
 1000278:	0001                	c.addi	x0,0
 100027a:	0001                	c.addi	x0,0
 100027c:	00e0b713          	sltiu	x14,x1,14
 1000280:	0205                	c.addi	x4,1
 1000282:	4289                	c.li	x5,2
 1000284:	fe5219e3          	bne	x4,x5,1000276 <test_23+0x2>
 1000288:	4e85                	c.li	x29,1
 100028a:	41dd                	c.li	x3,23
 100028c:	03d71463          	bne	x14,x29,10002b4 <fail>

01000290 <test_24>:
 1000290:	fff03093          	sltiu	x1,x0,-1
 1000294:	4e85                	c.li	x29,1
 1000296:	41e1                	c.li	x3,24
 1000298:	01d09e63          	bne	x1,x29,10002b4 <fail>

0100029c <test_25>:
 100029c:	00ff00b7          	lui	x1,0xff0
 10002a0:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 10002a4:	fff0b013          	sltiu	x0,x1,-1
 10002a8:	4e81                	c.li	x29,0
 10002aa:	41e5                	c.li	x3,25
 10002ac:	01d01463          	bne	x0,x29,10002b4 <fail>
 10002b0:	00301b63          	bne	x0,x3,10002c6 <pass>

010002b4 <fail>:
 10002b4:	0ff0000f          	fence	iorw,iorw
 10002b8:	00018063          	beq	x3,x0,10002b8 <fail+0x4>
 10002bc:	0186                	c.slli	x3,0x1
 10002be:	0011e193          	ori	x3,x3,1
 10002c2:	00000073          	ecall

010002c6 <pass>:
 10002c6:	0ff0000f          	fence	iorw,iorw
 10002ca:	4185                	c.li	x3,1
 10002cc:	00000073          	ecall
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

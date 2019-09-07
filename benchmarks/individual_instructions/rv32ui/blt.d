
rv32ui/blt.elf:     file format elf32-littleriscv


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
 10000ec:	4189                	c.li	x3,2
 10000ee:	4081                	c.li	x1,0
 10000f0:	4105                	c.li	x2,1
 10000f2:	0020c663          	blt	x1,x2,10000fe <test_2+0x12>
 10000f6:	1c301563          	bne	x0,x3,10002c0 <fail>
 10000fa:	00301663          	bne	x0,x3,1000106 <test_3>
 10000fe:	fe20cee3          	blt	x1,x2,10000fa <test_2+0xe>
 1000102:	1a301f63          	bne	x0,x3,10002c0 <fail>

01000106 <test_3>:
 1000106:	418d                	c.li	x3,3
 1000108:	50fd                	c.li	x1,-1
 100010a:	4105                	c.li	x2,1
 100010c:	0020c663          	blt	x1,x2,1000118 <test_3+0x12>
 1000110:	1a301863          	bne	x0,x3,10002c0 <fail>
 1000114:	00301663          	bne	x0,x3,1000120 <test_4>
 1000118:	fe20cee3          	blt	x1,x2,1000114 <test_3+0xe>
 100011c:	1a301263          	bne	x0,x3,10002c0 <fail>

01000120 <test_4>:
 1000120:	4191                	c.li	x3,4
 1000122:	50f9                	c.li	x1,-2
 1000124:	517d                	c.li	x2,-1
 1000126:	0020c663          	blt	x1,x2,1000132 <test_4+0x12>
 100012a:	18301b63          	bne	x0,x3,10002c0 <fail>
 100012e:	00301663          	bne	x0,x3,100013a <test_5>
 1000132:	fe20cee3          	blt	x1,x2,100012e <test_4+0xe>
 1000136:	18301563          	bne	x0,x3,10002c0 <fail>

0100013a <test_5>:
 100013a:	4195                	c.li	x3,5
 100013c:	4085                	c.li	x1,1
 100013e:	4101                	c.li	x2,0
 1000140:	0020c463          	blt	x1,x2,1000148 <test_5+0xe>
 1000144:	00301463          	bne	x0,x3,100014c <test_5+0x12>
 1000148:	16301c63          	bne	x0,x3,10002c0 <fail>
 100014c:	fe20cee3          	blt	x1,x2,1000148 <test_5+0xe>

01000150 <test_6>:
 1000150:	4199                	c.li	x3,6
 1000152:	4085                	c.li	x1,1
 1000154:	517d                	c.li	x2,-1
 1000156:	0020c463          	blt	x1,x2,100015e <test_6+0xe>
 100015a:	00301463          	bne	x0,x3,1000162 <test_6+0x12>
 100015e:	16301163          	bne	x0,x3,10002c0 <fail>
 1000162:	fe20cee3          	blt	x1,x2,100015e <test_6+0xe>

01000166 <test_7>:
 1000166:	419d                	c.li	x3,7
 1000168:	50fd                	c.li	x1,-1
 100016a:	5179                	c.li	x2,-2
 100016c:	0020c463          	blt	x1,x2,1000174 <test_7+0xe>
 1000170:	00301463          	bne	x0,x3,1000178 <test_7+0x12>
 1000174:	14301663          	bne	x0,x3,10002c0 <fail>
 1000178:	fe20cee3          	blt	x1,x2,1000174 <test_7+0xe>

0100017c <test_8>:
 100017c:	41a1                	c.li	x3,8
 100017e:	4085                	c.li	x1,1
 1000180:	5179                	c.li	x2,-2
 1000182:	0020c463          	blt	x1,x2,100018a <test_8+0xe>
 1000186:	00301463          	bne	x0,x3,100018e <test_8+0x12>
 100018a:	12301b63          	bne	x0,x3,10002c0 <fail>
 100018e:	fe20cee3          	blt	x1,x2,100018a <test_8+0xe>

01000192 <test_9>:
 1000192:	41a5                	c.li	x3,9
 1000194:	4201                	c.li	x4,0
 1000196:	4081                	c.li	x1,0
 1000198:	517d                	c.li	x2,-1
 100019a:	1220c363          	blt	x1,x2,10002c0 <fail>
 100019e:	0205                	c.addi	x4,1
 10001a0:	4289                	c.li	x5,2
 10001a2:	fe521ae3          	bne	x4,x5,1000196 <test_9+0x4>

010001a6 <test_10>:
 10001a6:	41a9                	c.li	x3,10
 10001a8:	4201                	c.li	x4,0
 10001aa:	4081                	c.li	x1,0
 10001ac:	517d                	c.li	x2,-1
 10001ae:	0001                	c.addi	x0,0
 10001b0:	1020c863          	blt	x1,x2,10002c0 <fail>
 10001b4:	0205                	c.addi	x4,1
 10001b6:	4289                	c.li	x5,2
 10001b8:	fe5219e3          	bne	x4,x5,10001aa <test_10+0x4>

010001bc <test_11>:
 10001bc:	41ad                	c.li	x3,11
 10001be:	4201                	c.li	x4,0
 10001c0:	4081                	c.li	x1,0
 10001c2:	517d                	c.li	x2,-1
 10001c4:	0001                	c.addi	x0,0
 10001c6:	0001                	c.addi	x0,0
 10001c8:	0e20cc63          	blt	x1,x2,10002c0 <fail>
 10001cc:	0205                	c.addi	x4,1
 10001ce:	4289                	c.li	x5,2
 10001d0:	fe5218e3          	bne	x4,x5,10001c0 <test_11+0x4>

010001d4 <test_12>:
 10001d4:	41b1                	c.li	x3,12
 10001d6:	4201                	c.li	x4,0
 10001d8:	4081                	c.li	x1,0
 10001da:	0001                	c.addi	x0,0
 10001dc:	517d                	c.li	x2,-1
 10001de:	0e20c163          	blt	x1,x2,10002c0 <fail>
 10001e2:	0205                	c.addi	x4,1
 10001e4:	4289                	c.li	x5,2
 10001e6:	fe5219e3          	bne	x4,x5,10001d8 <test_12+0x4>

010001ea <test_13>:
 10001ea:	41b5                	c.li	x3,13
 10001ec:	4201                	c.li	x4,0
 10001ee:	4081                	c.li	x1,0
 10001f0:	0001                	c.addi	x0,0
 10001f2:	517d                	c.li	x2,-1
 10001f4:	0001                	c.addi	x0,0
 10001f6:	0c20c563          	blt	x1,x2,10002c0 <fail>
 10001fa:	0205                	c.addi	x4,1
 10001fc:	4289                	c.li	x5,2
 10001fe:	fe5218e3          	bne	x4,x5,10001ee <test_13+0x4>

01000202 <test_14>:
 1000202:	41b9                	c.li	x3,14
 1000204:	4201                	c.li	x4,0
 1000206:	4081                	c.li	x1,0
 1000208:	0001                	c.addi	x0,0
 100020a:	0001                	c.addi	x0,0
 100020c:	517d                	c.li	x2,-1
 100020e:	0a20c963          	blt	x1,x2,10002c0 <fail>
 1000212:	0205                	c.addi	x4,1
 1000214:	4289                	c.li	x5,2
 1000216:	fe5218e3          	bne	x4,x5,1000206 <test_14+0x4>

0100021a <test_15>:
 100021a:	41bd                	c.li	x3,15
 100021c:	4201                	c.li	x4,0
 100021e:	4081                	c.li	x1,0
 1000220:	517d                	c.li	x2,-1
 1000222:	0820cf63          	blt	x1,x2,10002c0 <fail>
 1000226:	0205                	c.addi	x4,1
 1000228:	4289                	c.li	x5,2
 100022a:	fe521ae3          	bne	x4,x5,100021e <test_15+0x4>

0100022e <test_16>:
 100022e:	41c1                	c.li	x3,16
 1000230:	4201                	c.li	x4,0
 1000232:	4081                	c.li	x1,0
 1000234:	517d                	c.li	x2,-1
 1000236:	0001                	c.addi	x0,0
 1000238:	0820c463          	blt	x1,x2,10002c0 <fail>
 100023c:	0205                	c.addi	x4,1
 100023e:	4289                	c.li	x5,2
 1000240:	fe5219e3          	bne	x4,x5,1000232 <test_16+0x4>

01000244 <test_17>:
 1000244:	41c5                	c.li	x3,17
 1000246:	4201                	c.li	x4,0
 1000248:	4081                	c.li	x1,0
 100024a:	517d                	c.li	x2,-1
 100024c:	0001                	c.addi	x0,0
 100024e:	0001                	c.addi	x0,0
 1000250:	0620c863          	blt	x1,x2,10002c0 <fail>
 1000254:	0205                	c.addi	x4,1
 1000256:	4289                	c.li	x5,2
 1000258:	fe5218e3          	bne	x4,x5,1000248 <test_17+0x4>

0100025c <test_18>:
 100025c:	41c9                	c.li	x3,18
 100025e:	4201                	c.li	x4,0
 1000260:	4081                	c.li	x1,0
 1000262:	0001                	c.addi	x0,0
 1000264:	517d                	c.li	x2,-1
 1000266:	0420cd63          	blt	x1,x2,10002c0 <fail>
 100026a:	0205                	c.addi	x4,1
 100026c:	4289                	c.li	x5,2
 100026e:	fe5219e3          	bne	x4,x5,1000260 <test_18+0x4>

01000272 <test_19>:
 1000272:	41cd                	c.li	x3,19
 1000274:	4201                	c.li	x4,0
 1000276:	4081                	c.li	x1,0
 1000278:	0001                	c.addi	x0,0
 100027a:	517d                	c.li	x2,-1
 100027c:	0001                	c.addi	x0,0
 100027e:	0420c163          	blt	x1,x2,10002c0 <fail>
 1000282:	0205                	c.addi	x4,1
 1000284:	4289                	c.li	x5,2
 1000286:	fe5218e3          	bne	x4,x5,1000276 <test_19+0x4>

0100028a <test_20>:
 100028a:	41d1                	c.li	x3,20
 100028c:	4201                	c.li	x4,0
 100028e:	4081                	c.li	x1,0
 1000290:	0001                	c.addi	x0,0
 1000292:	0001                	c.addi	x0,0
 1000294:	517d                	c.li	x2,-1
 1000296:	0220c563          	blt	x1,x2,10002c0 <fail>
 100029a:	0205                	c.addi	x4,1
 100029c:	4289                	c.li	x5,2
 100029e:	fe5218e3          	bne	x4,x5,100028e <test_20+0x4>

010002a2 <test_21>:
 10002a2:	4085                	c.li	x1,1
 10002a4:	00104663          	blt	x0,x1,10002b0 <test_21+0xe>
 10002a8:	0085                	c.addi	x1,1
 10002aa:	0085                	c.addi	x1,1
 10002ac:	0085                	c.addi	x1,1
 10002ae:	0085                	c.addi	x1,1
 10002b0:	0085                	c.addi	x1,1
 10002b2:	0085                	c.addi	x1,1
 10002b4:	4e8d                	c.li	x29,3
 10002b6:	41d5                	c.li	x3,21
 10002b8:	01d09463          	bne	x1,x29,10002c0 <fail>
 10002bc:	00301b63          	bne	x0,x3,10002d2 <pass>

010002c0 <fail>:
 10002c0:	0ff0000f          	fence	iorw,iorw
 10002c4:	00018063          	beq	x3,x0,10002c4 <fail+0x4>
 10002c8:	0186                	c.slli	x3,0x1
 10002ca:	0011e193          	ori	x3,x3,1
 10002ce:	00000073          	ecall

010002d2 <pass>:
 10002d2:	0ff0000f          	fence	iorw,iorw
 10002d6:	4185                	c.li	x3,1
 10002d8:	00000073          	ecall
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

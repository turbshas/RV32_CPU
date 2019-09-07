
rv32ui/bge.elf:     file format elf32-littleriscv


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
 10000f0:	4101                	c.li	x2,0
 10000f2:	0020d663          	bge	x1,x2,10000fe <test_2+0x12>
 10000f6:	20301c63          	bne	x0,x3,100030e <fail>
 10000fa:	00301663          	bne	x0,x3,1000106 <test_3>
 10000fe:	fe20dee3          	bge	x1,x2,10000fa <test_2+0xe>
 1000102:	20301663          	bne	x0,x3,100030e <fail>

01000106 <test_3>:
 1000106:	418d                	c.li	x3,3
 1000108:	4085                	c.li	x1,1
 100010a:	4105                	c.li	x2,1
 100010c:	0020d663          	bge	x1,x2,1000118 <test_3+0x12>
 1000110:	1e301f63          	bne	x0,x3,100030e <fail>
 1000114:	00301663          	bne	x0,x3,1000120 <test_4>
 1000118:	fe20dee3          	bge	x1,x2,1000114 <test_3+0xe>
 100011c:	1e301963          	bne	x0,x3,100030e <fail>

01000120 <test_4>:
 1000120:	4191                	c.li	x3,4
 1000122:	50fd                	c.li	x1,-1
 1000124:	517d                	c.li	x2,-1
 1000126:	0020d663          	bge	x1,x2,1000132 <test_4+0x12>
 100012a:	1e301263          	bne	x0,x3,100030e <fail>
 100012e:	00301663          	bne	x0,x3,100013a <test_5>
 1000132:	fe20dee3          	bge	x1,x2,100012e <test_4+0xe>
 1000136:	1c301c63          	bne	x0,x3,100030e <fail>

0100013a <test_5>:
 100013a:	4195                	c.li	x3,5
 100013c:	4085                	c.li	x1,1
 100013e:	4101                	c.li	x2,0
 1000140:	0020d663          	bge	x1,x2,100014c <test_5+0x12>
 1000144:	1c301563          	bne	x0,x3,100030e <fail>
 1000148:	00301663          	bne	x0,x3,1000154 <test_6>
 100014c:	fe20dee3          	bge	x1,x2,1000148 <test_5+0xe>
 1000150:	1a301f63          	bne	x0,x3,100030e <fail>

01000154 <test_6>:
 1000154:	4199                	c.li	x3,6
 1000156:	4085                	c.li	x1,1
 1000158:	517d                	c.li	x2,-1
 100015a:	0020d663          	bge	x1,x2,1000166 <test_6+0x12>
 100015e:	1a301863          	bne	x0,x3,100030e <fail>
 1000162:	00301663          	bne	x0,x3,100016e <test_7>
 1000166:	fe20dee3          	bge	x1,x2,1000162 <test_6+0xe>
 100016a:	1a301263          	bne	x0,x3,100030e <fail>

0100016e <test_7>:
 100016e:	419d                	c.li	x3,7
 1000170:	50fd                	c.li	x1,-1
 1000172:	5179                	c.li	x2,-2
 1000174:	0020d663          	bge	x1,x2,1000180 <test_7+0x12>
 1000178:	18301b63          	bne	x0,x3,100030e <fail>
 100017c:	00301663          	bne	x0,x3,1000188 <test_8>
 1000180:	fe20dee3          	bge	x1,x2,100017c <test_7+0xe>
 1000184:	18301563          	bne	x0,x3,100030e <fail>

01000188 <test_8>:
 1000188:	41a1                	c.li	x3,8
 100018a:	4081                	c.li	x1,0
 100018c:	4105                	c.li	x2,1
 100018e:	0020d463          	bge	x1,x2,1000196 <test_8+0xe>
 1000192:	00301463          	bne	x0,x3,100019a <test_8+0x12>
 1000196:	16301c63          	bne	x0,x3,100030e <fail>
 100019a:	fe20dee3          	bge	x1,x2,1000196 <test_8+0xe>

0100019e <test_9>:
 100019e:	41a5                	c.li	x3,9
 10001a0:	50fd                	c.li	x1,-1
 10001a2:	4105                	c.li	x2,1
 10001a4:	0020d463          	bge	x1,x2,10001ac <test_9+0xe>
 10001a8:	00301463          	bne	x0,x3,10001b0 <test_9+0x12>
 10001ac:	16301163          	bne	x0,x3,100030e <fail>
 10001b0:	fe20dee3          	bge	x1,x2,10001ac <test_9+0xe>

010001b4 <test_10>:
 10001b4:	41a9                	c.li	x3,10
 10001b6:	50f9                	c.li	x1,-2
 10001b8:	517d                	c.li	x2,-1
 10001ba:	0020d463          	bge	x1,x2,10001c2 <test_10+0xe>
 10001be:	00301463          	bne	x0,x3,10001c6 <test_10+0x12>
 10001c2:	14301663          	bne	x0,x3,100030e <fail>
 10001c6:	fe20dee3          	bge	x1,x2,10001c2 <test_10+0xe>

010001ca <test_11>:
 10001ca:	41ad                	c.li	x3,11
 10001cc:	50f9                	c.li	x1,-2
 10001ce:	4105                	c.li	x2,1
 10001d0:	0020d463          	bge	x1,x2,10001d8 <test_11+0xe>
 10001d4:	00301463          	bne	x0,x3,10001dc <test_11+0x12>
 10001d8:	12301b63          	bne	x0,x3,100030e <fail>
 10001dc:	fe20dee3          	bge	x1,x2,10001d8 <test_11+0xe>

010001e0 <test_12>:
 10001e0:	41b1                	c.li	x3,12
 10001e2:	4201                	c.li	x4,0
 10001e4:	50fd                	c.li	x1,-1
 10001e6:	4101                	c.li	x2,0
 10001e8:	1220d363          	bge	x1,x2,100030e <fail>
 10001ec:	0205                	c.addi	x4,1
 10001ee:	4289                	c.li	x5,2
 10001f0:	fe521ae3          	bne	x4,x5,10001e4 <test_12+0x4>

010001f4 <test_13>:
 10001f4:	41b5                	c.li	x3,13
 10001f6:	4201                	c.li	x4,0
 10001f8:	50fd                	c.li	x1,-1
 10001fa:	4101                	c.li	x2,0
 10001fc:	0001                	c.addi	x0,0
 10001fe:	1020d863          	bge	x1,x2,100030e <fail>
 1000202:	0205                	c.addi	x4,1
 1000204:	4289                	c.li	x5,2
 1000206:	fe5219e3          	bne	x4,x5,10001f8 <test_13+0x4>

0100020a <test_14>:
 100020a:	41b9                	c.li	x3,14
 100020c:	4201                	c.li	x4,0
 100020e:	50fd                	c.li	x1,-1
 1000210:	4101                	c.li	x2,0
 1000212:	0001                	c.addi	x0,0
 1000214:	0001                	c.addi	x0,0
 1000216:	0e20dc63          	bge	x1,x2,100030e <fail>
 100021a:	0205                	c.addi	x4,1
 100021c:	4289                	c.li	x5,2
 100021e:	fe5218e3          	bne	x4,x5,100020e <test_14+0x4>

01000222 <test_15>:
 1000222:	41bd                	c.li	x3,15
 1000224:	4201                	c.li	x4,0
 1000226:	50fd                	c.li	x1,-1
 1000228:	0001                	c.addi	x0,0
 100022a:	4101                	c.li	x2,0
 100022c:	0e20d163          	bge	x1,x2,100030e <fail>
 1000230:	0205                	c.addi	x4,1
 1000232:	4289                	c.li	x5,2
 1000234:	fe5219e3          	bne	x4,x5,1000226 <test_15+0x4>

01000238 <test_16>:
 1000238:	41c1                	c.li	x3,16
 100023a:	4201                	c.li	x4,0
 100023c:	50fd                	c.li	x1,-1
 100023e:	0001                	c.addi	x0,0
 1000240:	4101                	c.li	x2,0
 1000242:	0001                	c.addi	x0,0
 1000244:	0c20d563          	bge	x1,x2,100030e <fail>
 1000248:	0205                	c.addi	x4,1
 100024a:	4289                	c.li	x5,2
 100024c:	fe5218e3          	bne	x4,x5,100023c <test_16+0x4>

01000250 <test_17>:
 1000250:	41c5                	c.li	x3,17
 1000252:	4201                	c.li	x4,0
 1000254:	50fd                	c.li	x1,-1
 1000256:	0001                	c.addi	x0,0
 1000258:	0001                	c.addi	x0,0
 100025a:	4101                	c.li	x2,0
 100025c:	0a20d963          	bge	x1,x2,100030e <fail>
 1000260:	0205                	c.addi	x4,1
 1000262:	4289                	c.li	x5,2
 1000264:	fe5218e3          	bne	x4,x5,1000254 <test_17+0x4>

01000268 <test_18>:
 1000268:	41c9                	c.li	x3,18
 100026a:	4201                	c.li	x4,0
 100026c:	50fd                	c.li	x1,-1
 100026e:	4101                	c.li	x2,0
 1000270:	0820df63          	bge	x1,x2,100030e <fail>
 1000274:	0205                	c.addi	x4,1
 1000276:	4289                	c.li	x5,2
 1000278:	fe521ae3          	bne	x4,x5,100026c <test_18+0x4>

0100027c <test_19>:
 100027c:	41cd                	c.li	x3,19
 100027e:	4201                	c.li	x4,0
 1000280:	50fd                	c.li	x1,-1
 1000282:	4101                	c.li	x2,0
 1000284:	0001                	c.addi	x0,0
 1000286:	0820d463          	bge	x1,x2,100030e <fail>
 100028a:	0205                	c.addi	x4,1
 100028c:	4289                	c.li	x5,2
 100028e:	fe5219e3          	bne	x4,x5,1000280 <test_19+0x4>

01000292 <test_20>:
 1000292:	41d1                	c.li	x3,20
 1000294:	4201                	c.li	x4,0
 1000296:	50fd                	c.li	x1,-1
 1000298:	4101                	c.li	x2,0
 100029a:	0001                	c.addi	x0,0
 100029c:	0001                	c.addi	x0,0
 100029e:	0620d863          	bge	x1,x2,100030e <fail>
 10002a2:	0205                	c.addi	x4,1
 10002a4:	4289                	c.li	x5,2
 10002a6:	fe5218e3          	bne	x4,x5,1000296 <test_20+0x4>

010002aa <test_21>:
 10002aa:	41d5                	c.li	x3,21
 10002ac:	4201                	c.li	x4,0
 10002ae:	50fd                	c.li	x1,-1
 10002b0:	0001                	c.addi	x0,0
 10002b2:	4101                	c.li	x2,0
 10002b4:	0420dd63          	bge	x1,x2,100030e <fail>
 10002b8:	0205                	c.addi	x4,1
 10002ba:	4289                	c.li	x5,2
 10002bc:	fe5219e3          	bne	x4,x5,10002ae <test_21+0x4>

010002c0 <test_22>:
 10002c0:	41d9                	c.li	x3,22
 10002c2:	4201                	c.li	x4,0
 10002c4:	50fd                	c.li	x1,-1
 10002c6:	0001                	c.addi	x0,0
 10002c8:	4101                	c.li	x2,0
 10002ca:	0001                	c.addi	x0,0
 10002cc:	0420d163          	bge	x1,x2,100030e <fail>
 10002d0:	0205                	c.addi	x4,1
 10002d2:	4289                	c.li	x5,2
 10002d4:	fe5218e3          	bne	x4,x5,10002c4 <test_22+0x4>

010002d8 <test_23>:
 10002d8:	41dd                	c.li	x3,23
 10002da:	4201                	c.li	x4,0
 10002dc:	50fd                	c.li	x1,-1
 10002de:	0001                	c.addi	x0,0
 10002e0:	0001                	c.addi	x0,0
 10002e2:	4101                	c.li	x2,0
 10002e4:	0220d563          	bge	x1,x2,100030e <fail>
 10002e8:	0205                	c.addi	x4,1
 10002ea:	4289                	c.li	x5,2
 10002ec:	fe5218e3          	bne	x4,x5,10002dc <test_23+0x4>

010002f0 <test_24>:
 10002f0:	4085                	c.li	x1,1
 10002f2:	0000d663          	bge	x1,x0,10002fe <test_24+0xe>
 10002f6:	0085                	c.addi	x1,1
 10002f8:	0085                	c.addi	x1,1
 10002fa:	0085                	c.addi	x1,1
 10002fc:	0085                	c.addi	x1,1
 10002fe:	0085                	c.addi	x1,1
 1000300:	0085                	c.addi	x1,1
 1000302:	4e8d                	c.li	x29,3
 1000304:	41e1                	c.li	x3,24
 1000306:	01d09463          	bne	x1,x29,100030e <fail>
 100030a:	00301b63          	bne	x0,x3,1000320 <pass>

0100030e <fail>:
 100030e:	0ff0000f          	fence	iorw,iorw
 1000312:	00018063          	beq	x3,x0,1000312 <fail+0x4>
 1000316:	0186                	c.slli	x3,0x1
 1000318:	0011e193          	ori	x3,x3,1
 100031c:	00000073          	ecall

01000320 <pass>:
 1000320:	0ff0000f          	fence	iorw,iorw
 1000324:	4185                	c.li	x3,1
 1000326:	00000073          	ecall
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

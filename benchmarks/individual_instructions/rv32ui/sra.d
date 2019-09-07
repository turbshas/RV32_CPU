
rv32ui/sra.elf:     file format elf32-littleriscv


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
 10000ec:	800000b7          	lui	x1,0x80000
 10000f0:	4101                	c.li	x2,0
 10000f2:	4020d733          	sra	x14,x1,x2
 10000f6:	80000eb7          	lui	x29,0x80000
 10000fa:	4189                	c.li	x3,2
 10000fc:	49d71163          	bne	x14,x29,100057e <fail>

01000100 <test_3>:
 1000100:	800000b7          	lui	x1,0x80000
 1000104:	4105                	c.li	x2,1
 1000106:	4020d733          	sra	x14,x1,x2
 100010a:	c0000eb7          	lui	x29,0xc0000
 100010e:	418d                	c.li	x3,3
 1000110:	47d71763          	bne	x14,x29,100057e <fail>

01000114 <test_4>:
 1000114:	800000b7          	lui	x1,0x80000
 1000118:	411d                	c.li	x2,7
 100011a:	4020d733          	sra	x14,x1,x2
 100011e:	ff000eb7          	lui	x29,0xff000
 1000122:	4191                	c.li	x3,4
 1000124:	45d71d63          	bne	x14,x29,100057e <fail>

01000128 <test_5>:
 1000128:	800000b7          	lui	x1,0x80000
 100012c:	4139                	c.li	x2,14
 100012e:	4020d733          	sra	x14,x1,x2
 1000132:	fffe0eb7          	lui	x29,0xfffe0
 1000136:	4195                	c.li	x3,5
 1000138:	45d71363          	bne	x14,x29,100057e <fail>

0100013c <test_6>:
 100013c:	800000b7          	lui	x1,0x80000
 1000140:	00108093          	addi	x1,x1,1 # 80000001 <_end+0x7effe001>
 1000144:	417d                	c.li	x2,31
 1000146:	4020d733          	sra	x14,x1,x2
 100014a:	fff00e93          	addi	x29,x0,-1
 100014e:	4199                	c.li	x3,6
 1000150:	43d71763          	bne	x14,x29,100057e <fail>

01000154 <test_7>:
 1000154:	800000b7          	lui	x1,0x80000
 1000158:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 100015c:	4101                	c.li	x2,0
 100015e:	4020d733          	sra	x14,x1,x2
 1000162:	80000eb7          	lui	x29,0x80000
 1000166:	fffe8e93          	addi	x29,x29,-1 # 7fffffff <_end+0x7effdfff>
 100016a:	419d                	c.li	x3,7
 100016c:	41d71963          	bne	x14,x29,100057e <fail>

01000170 <test_8>:
 1000170:	800000b7          	lui	x1,0x80000
 1000174:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 1000178:	4105                	c.li	x2,1
 100017a:	4020d733          	sra	x14,x1,x2
 100017e:	40000eb7          	lui	x29,0x40000
 1000182:	fffe8e93          	addi	x29,x29,-1 # 3fffffff <_end+0x3effdfff>
 1000186:	41a1                	c.li	x3,8
 1000188:	3fd71b63          	bne	x14,x29,100057e <fail>

0100018c <test_9>:
 100018c:	800000b7          	lui	x1,0x80000
 1000190:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 1000194:	411d                	c.li	x2,7
 1000196:	4020d733          	sra	x14,x1,x2
 100019a:	01000eb7          	lui	x29,0x1000
 100019e:	fffe8e93          	addi	x29,x29,-1 # ffffff <_start-0x1>
 10001a2:	41a5                	c.li	x3,9
 10001a4:	3dd71d63          	bne	x14,x29,100057e <fail>

010001a8 <test_10>:
 10001a8:	800000b7          	lui	x1,0x80000
 10001ac:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 10001b0:	4139                	c.li	x2,14
 10001b2:	4020d733          	sra	x14,x1,x2
 10001b6:	00020eb7          	lui	x29,0x20
 10001ba:	fffe8e93          	addi	x29,x29,-1 # 1ffff <_start-0xfe0001>
 10001be:	41a9                	c.li	x3,10
 10001c0:	3bd71f63          	bne	x14,x29,100057e <fail>

010001c4 <test_11>:
 10001c4:	800000b7          	lui	x1,0x80000
 10001c8:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 10001cc:	417d                	c.li	x2,31
 10001ce:	4020d733          	sra	x14,x1,x2
 10001d2:	4e81                	c.li	x29,0
 10001d4:	41ad                	c.li	x3,11
 10001d6:	3bd71463          	bne	x14,x29,100057e <fail>

010001da <test_12>:
 10001da:	818180b7          	lui	x1,0x81818
 10001de:	18108093          	addi	x1,x1,385 # 81818181 <_end+0x80816181>
 10001e2:	4101                	c.li	x2,0
 10001e4:	4020d733          	sra	x14,x1,x2
 10001e8:	81818eb7          	lui	x29,0x81818
 10001ec:	181e8e93          	addi	x29,x29,385 # 81818181 <_end+0x80816181>
 10001f0:	41b1                	c.li	x3,12
 10001f2:	39d71663          	bne	x14,x29,100057e <fail>

010001f6 <test_13>:
 10001f6:	818180b7          	lui	x1,0x81818
 10001fa:	18108093          	addi	x1,x1,385 # 81818181 <_end+0x80816181>
 10001fe:	4105                	c.li	x2,1
 1000200:	4020d733          	sra	x14,x1,x2
 1000204:	c0c0ceb7          	lui	x29,0xc0c0c
 1000208:	0c0e8e93          	addi	x29,x29,192 # c0c0c0c0 <_end+0xbfc0a0c0>
 100020c:	41b5                	c.li	x3,13
 100020e:	37d71863          	bne	x14,x29,100057e <fail>

01000212 <test_14>:
 1000212:	818180b7          	lui	x1,0x81818
 1000216:	18108093          	addi	x1,x1,385 # 81818181 <_end+0x80816181>
 100021a:	411d                	c.li	x2,7
 100021c:	4020d733          	sra	x14,x1,x2
 1000220:	ff030eb7          	lui	x29,0xff030
 1000224:	303e8e93          	addi	x29,x29,771 # ff030303 <_end+0xfe02e303>
 1000228:	41b9                	c.li	x3,14
 100022a:	35d71a63          	bne	x14,x29,100057e <fail>

0100022e <test_15>:
 100022e:	818180b7          	lui	x1,0x81818
 1000232:	18108093          	addi	x1,x1,385 # 81818181 <_end+0x80816181>
 1000236:	4139                	c.li	x2,14
 1000238:	4020d733          	sra	x14,x1,x2
 100023c:	fffe0eb7          	lui	x29,0xfffe0
 1000240:	606e8e93          	addi	x29,x29,1542 # fffe0606 <_end+0xfefde606>
 1000244:	41bd                	c.li	x3,15
 1000246:	33d71c63          	bne	x14,x29,100057e <fail>

0100024a <test_16>:
 100024a:	818180b7          	lui	x1,0x81818
 100024e:	18108093          	addi	x1,x1,385 # 81818181 <_end+0x80816181>
 1000252:	417d                	c.li	x2,31
 1000254:	4020d733          	sra	x14,x1,x2
 1000258:	fff00e93          	addi	x29,x0,-1
 100025c:	41c1                	c.li	x3,16
 100025e:	33d71063          	bne	x14,x29,100057e <fail>

01000262 <test_17>:
 1000262:	818180b7          	lui	x1,0x81818
 1000266:	18108093          	addi	x1,x1,385 # 81818181 <_end+0x80816181>
 100026a:	fc000113          	addi	x2,x0,-64
 100026e:	4020d733          	sra	x14,x1,x2
 1000272:	81818eb7          	lui	x29,0x81818
 1000276:	181e8e93          	addi	x29,x29,385 # 81818181 <_end+0x80816181>
 100027a:	41c5                	c.li	x3,17
 100027c:	31d71163          	bne	x14,x29,100057e <fail>

01000280 <test_18>:
 1000280:	818180b7          	lui	x1,0x81818
 1000284:	18108093          	addi	x1,x1,385 # 81818181 <_end+0x80816181>
 1000288:	fc100113          	addi	x2,x0,-63
 100028c:	4020d733          	sra	x14,x1,x2
 1000290:	c0c0ceb7          	lui	x29,0xc0c0c
 1000294:	0c0e8e93          	addi	x29,x29,192 # c0c0c0c0 <_end+0xbfc0a0c0>
 1000298:	41c9                	c.li	x3,18
 100029a:	2fd71263          	bne	x14,x29,100057e <fail>

0100029e <test_19>:
 100029e:	818180b7          	lui	x1,0x81818
 10002a2:	18108093          	addi	x1,x1,385 # 81818181 <_end+0x80816181>
 10002a6:	fc700113          	addi	x2,x0,-57
 10002aa:	4020d733          	sra	x14,x1,x2
 10002ae:	ff030eb7          	lui	x29,0xff030
 10002b2:	303e8e93          	addi	x29,x29,771 # ff030303 <_end+0xfe02e303>
 10002b6:	41cd                	c.li	x3,19
 10002b8:	2dd71363          	bne	x14,x29,100057e <fail>

010002bc <test_20>:
 10002bc:	818180b7          	lui	x1,0x81818
 10002c0:	18108093          	addi	x1,x1,385 # 81818181 <_end+0x80816181>
 10002c4:	fce00113          	addi	x2,x0,-50
 10002c8:	4020d733          	sra	x14,x1,x2
 10002cc:	fffe0eb7          	lui	x29,0xfffe0
 10002d0:	606e8e93          	addi	x29,x29,1542 # fffe0606 <_end+0xfefde606>
 10002d4:	41d1                	c.li	x3,20
 10002d6:	2bd71463          	bne	x14,x29,100057e <fail>

010002da <test_21>:
 10002da:	818180b7          	lui	x1,0x81818
 10002de:	18108093          	addi	x1,x1,385 # 81818181 <_end+0x80816181>
 10002e2:	fff00113          	addi	x2,x0,-1
 10002e6:	4020d733          	sra	x14,x1,x2
 10002ea:	fff00e93          	addi	x29,x0,-1
 10002ee:	41d5                	c.li	x3,21
 10002f0:	29d71763          	bne	x14,x29,100057e <fail>

010002f4 <test_22>:
 10002f4:	800000b7          	lui	x1,0x80000
 10002f8:	411d                	c.li	x2,7
 10002fa:	4020d0b3          	sra	x1,x1,x2
 10002fe:	ff000eb7          	lui	x29,0xff000
 1000302:	41d9                	c.li	x3,22
 1000304:	27d09d63          	bne	x1,x29,100057e <fail>

01000308 <test_23>:
 1000308:	800000b7          	lui	x1,0x80000
 100030c:	4139                	c.li	x2,14
 100030e:	4020d133          	sra	x2,x1,x2
 1000312:	fffe0eb7          	lui	x29,0xfffe0
 1000316:	41dd                	c.li	x3,23
 1000318:	27d11363          	bne	x2,x29,100057e <fail>

0100031c <test_24>:
 100031c:	409d                	c.li	x1,7
 100031e:	4010d0b3          	sra	x1,x1,x1
 1000322:	4e81                	c.li	x29,0
 1000324:	41e1                	c.li	x3,24
 1000326:	25d09c63          	bne	x1,x29,100057e <fail>

0100032a <test_25>:
 100032a:	4201                	c.li	x4,0
 100032c:	800000b7          	lui	x1,0x80000
 1000330:	411d                	c.li	x2,7
 1000332:	4020d733          	sra	x14,x1,x2
 1000336:	00070313          	addi	x6,x14,0
 100033a:	0205                	c.addi	x4,1
 100033c:	4289                	c.li	x5,2
 100033e:	fe5217e3          	bne	x4,x5,100032c <test_25+0x2>
 1000342:	ff000eb7          	lui	x29,0xff000
 1000346:	41e5                	c.li	x3,25
 1000348:	23d31b63          	bne	x6,x29,100057e <fail>

0100034c <test_26>:
 100034c:	4201                	c.li	x4,0
 100034e:	800000b7          	lui	x1,0x80000
 1000352:	4139                	c.li	x2,14
 1000354:	4020d733          	sra	x14,x1,x2
 1000358:	0001                	c.addi	x0,0
 100035a:	00070313          	addi	x6,x14,0
 100035e:	0205                	c.addi	x4,1
 1000360:	4289                	c.li	x5,2
 1000362:	fe5216e3          	bne	x4,x5,100034e <test_26+0x2>
 1000366:	fffe0eb7          	lui	x29,0xfffe0
 100036a:	41e9                	c.li	x3,26
 100036c:	21d31963          	bne	x6,x29,100057e <fail>

01000370 <test_27>:
 1000370:	4201                	c.li	x4,0
 1000372:	800000b7          	lui	x1,0x80000
 1000376:	417d                	c.li	x2,31
 1000378:	4020d733          	sra	x14,x1,x2
 100037c:	0001                	c.addi	x0,0
 100037e:	0001                	c.addi	x0,0
 1000380:	00070313          	addi	x6,x14,0
 1000384:	0205                	c.addi	x4,1
 1000386:	4289                	c.li	x5,2
 1000388:	fe5215e3          	bne	x4,x5,1000372 <test_27+0x2>
 100038c:	fff00e93          	addi	x29,x0,-1
 1000390:	41ed                	c.li	x3,27
 1000392:	1fd31663          	bne	x6,x29,100057e <fail>

01000396 <test_28>:
 1000396:	4201                	c.li	x4,0
 1000398:	800000b7          	lui	x1,0x80000
 100039c:	411d                	c.li	x2,7
 100039e:	4020d733          	sra	x14,x1,x2
 10003a2:	0205                	c.addi	x4,1
 10003a4:	4289                	c.li	x5,2
 10003a6:	fe5219e3          	bne	x4,x5,1000398 <test_28+0x2>
 10003aa:	ff000eb7          	lui	x29,0xff000
 10003ae:	41f1                	c.li	x3,28
 10003b0:	1dd71763          	bne	x14,x29,100057e <fail>

010003b4 <test_29>:
 10003b4:	4201                	c.li	x4,0
 10003b6:	800000b7          	lui	x1,0x80000
 10003ba:	4139                	c.li	x2,14
 10003bc:	0001                	c.addi	x0,0
 10003be:	4020d733          	sra	x14,x1,x2
 10003c2:	0205                	c.addi	x4,1
 10003c4:	4289                	c.li	x5,2
 10003c6:	fe5218e3          	bne	x4,x5,10003b6 <test_29+0x2>
 10003ca:	fffe0eb7          	lui	x29,0xfffe0
 10003ce:	41f5                	c.li	x3,29
 10003d0:	1bd71763          	bne	x14,x29,100057e <fail>

010003d4 <test_30>:
 10003d4:	4201                	c.li	x4,0
 10003d6:	800000b7          	lui	x1,0x80000
 10003da:	417d                	c.li	x2,31
 10003dc:	0001                	c.addi	x0,0
 10003de:	0001                	c.addi	x0,0
 10003e0:	4020d733          	sra	x14,x1,x2
 10003e4:	0205                	c.addi	x4,1
 10003e6:	4289                	c.li	x5,2
 10003e8:	fe5217e3          	bne	x4,x5,10003d6 <test_30+0x2>
 10003ec:	fff00e93          	addi	x29,x0,-1
 10003f0:	41f9                	c.li	x3,30
 10003f2:	19d71663          	bne	x14,x29,100057e <fail>

010003f6 <test_31>:
 10003f6:	4201                	c.li	x4,0
 10003f8:	800000b7          	lui	x1,0x80000
 10003fc:	0001                	c.addi	x0,0
 10003fe:	411d                	c.li	x2,7
 1000400:	4020d733          	sra	x14,x1,x2
 1000404:	0205                	c.addi	x4,1
 1000406:	4289                	c.li	x5,2
 1000408:	fe5218e3          	bne	x4,x5,10003f8 <test_31+0x2>
 100040c:	ff000eb7          	lui	x29,0xff000
 1000410:	41fd                	c.li	x3,31
 1000412:	17d71663          	bne	x14,x29,100057e <fail>

01000416 <test_32>:
 1000416:	4201                	c.li	x4,0
 1000418:	800000b7          	lui	x1,0x80000
 100041c:	0001                	c.addi	x0,0
 100041e:	4139                	c.li	x2,14
 1000420:	0001                	c.addi	x0,0
 1000422:	4020d733          	sra	x14,x1,x2
 1000426:	0205                	c.addi	x4,1
 1000428:	4289                	c.li	x5,2
 100042a:	fe5217e3          	bne	x4,x5,1000418 <test_32+0x2>
 100042e:	fffe0eb7          	lui	x29,0xfffe0
 1000432:	02000193          	addi	x3,x0,32
 1000436:	15d71463          	bne	x14,x29,100057e <fail>

0100043a <test_33>:
 100043a:	4201                	c.li	x4,0
 100043c:	800000b7          	lui	x1,0x80000
 1000440:	0001                	c.addi	x0,0
 1000442:	0001                	c.addi	x0,0
 1000444:	417d                	c.li	x2,31
 1000446:	4020d733          	sra	x14,x1,x2
 100044a:	0205                	c.addi	x4,1
 100044c:	4289                	c.li	x5,2
 100044e:	fe5217e3          	bne	x4,x5,100043c <test_33+0x2>
 1000452:	fff00e93          	addi	x29,x0,-1
 1000456:	02100193          	addi	x3,x0,33
 100045a:	13d71263          	bne	x14,x29,100057e <fail>

0100045e <test_34>:
 100045e:	4201                	c.li	x4,0
 1000460:	411d                	c.li	x2,7
 1000462:	800000b7          	lui	x1,0x80000
 1000466:	4020d733          	sra	x14,x1,x2
 100046a:	0205                	c.addi	x4,1
 100046c:	4289                	c.li	x5,2
 100046e:	fe5219e3          	bne	x4,x5,1000460 <test_34+0x2>
 1000472:	ff000eb7          	lui	x29,0xff000
 1000476:	02200193          	addi	x3,x0,34
 100047a:	11d71263          	bne	x14,x29,100057e <fail>

0100047e <test_35>:
 100047e:	4201                	c.li	x4,0
 1000480:	4139                	c.li	x2,14
 1000482:	800000b7          	lui	x1,0x80000
 1000486:	0001                	c.addi	x0,0
 1000488:	4020d733          	sra	x14,x1,x2
 100048c:	0205                	c.addi	x4,1
 100048e:	4289                	c.li	x5,2
 1000490:	fe5218e3          	bne	x4,x5,1000480 <test_35+0x2>
 1000494:	fffe0eb7          	lui	x29,0xfffe0
 1000498:	02300193          	addi	x3,x0,35
 100049c:	0fd71163          	bne	x14,x29,100057e <fail>

010004a0 <test_36>:
 10004a0:	4201                	c.li	x4,0
 10004a2:	417d                	c.li	x2,31
 10004a4:	800000b7          	lui	x1,0x80000
 10004a8:	0001                	c.addi	x0,0
 10004aa:	0001                	c.addi	x0,0
 10004ac:	4020d733          	sra	x14,x1,x2
 10004b0:	0205                	c.addi	x4,1
 10004b2:	4289                	c.li	x5,2
 10004b4:	fe5217e3          	bne	x4,x5,10004a2 <test_36+0x2>
 10004b8:	fff00e93          	addi	x29,x0,-1
 10004bc:	02400193          	addi	x3,x0,36
 10004c0:	0bd71f63          	bne	x14,x29,100057e <fail>

010004c4 <test_37>:
 10004c4:	4201                	c.li	x4,0
 10004c6:	411d                	c.li	x2,7
 10004c8:	0001                	c.addi	x0,0
 10004ca:	800000b7          	lui	x1,0x80000
 10004ce:	4020d733          	sra	x14,x1,x2
 10004d2:	0205                	c.addi	x4,1
 10004d4:	4289                	c.li	x5,2
 10004d6:	fe5218e3          	bne	x4,x5,10004c6 <test_37+0x2>
 10004da:	ff000eb7          	lui	x29,0xff000
 10004de:	02500193          	addi	x3,x0,37
 10004e2:	09d71e63          	bne	x14,x29,100057e <fail>

010004e6 <test_38>:
 10004e6:	4201                	c.li	x4,0
 10004e8:	4139                	c.li	x2,14
 10004ea:	0001                	c.addi	x0,0
 10004ec:	800000b7          	lui	x1,0x80000
 10004f0:	0001                	c.addi	x0,0
 10004f2:	4020d733          	sra	x14,x1,x2
 10004f6:	0205                	c.addi	x4,1
 10004f8:	4289                	c.li	x5,2
 10004fa:	fe5217e3          	bne	x4,x5,10004e8 <test_38+0x2>
 10004fe:	fffe0eb7          	lui	x29,0xfffe0
 1000502:	02600193          	addi	x3,x0,38
 1000506:	07d71c63          	bne	x14,x29,100057e <fail>

0100050a <test_39>:
 100050a:	4201                	c.li	x4,0
 100050c:	417d                	c.li	x2,31
 100050e:	0001                	c.addi	x0,0
 1000510:	0001                	c.addi	x0,0
 1000512:	800000b7          	lui	x1,0x80000
 1000516:	4020d733          	sra	x14,x1,x2
 100051a:	0205                	c.addi	x4,1
 100051c:	4289                	c.li	x5,2
 100051e:	fe5217e3          	bne	x4,x5,100050c <test_39+0x2>
 1000522:	fff00e93          	addi	x29,x0,-1
 1000526:	02700193          	addi	x3,x0,39
 100052a:	05d71a63          	bne	x14,x29,100057e <fail>

0100052e <test_40>:
 100052e:	40bd                	c.li	x1,15
 1000530:	40105133          	sra	x2,x0,x1
 1000534:	4e81                	c.li	x29,0
 1000536:	02800193          	addi	x3,x0,40
 100053a:	05d11263          	bne	x2,x29,100057e <fail>

0100053e <test_41>:
 100053e:	02000093          	addi	x1,x0,32
 1000542:	4000d133          	sra	x2,x1,x0
 1000546:	02000e93          	addi	x29,x0,32
 100054a:	02900193          	addi	x3,x0,41
 100054e:	03d11863          	bne	x2,x29,100057e <fail>

01000552 <test_42>:
 1000552:	400050b3          	sra	x1,x0,x0
 1000556:	4e81                	c.li	x29,0
 1000558:	02a00193          	addi	x3,x0,42
 100055c:	03d09163          	bne	x1,x29,100057e <fail>

01000560 <test_43>:
 1000560:	40000093          	addi	x1,x0,1024
 1000564:	00001137          	lui	x2,0x1
 1000568:	80010113          	addi	x2,x2,-2048 # 800 <_start-0xfff800>
 100056c:	4020d033          	sra	x0,x1,x2
 1000570:	4e81                	c.li	x29,0
 1000572:	02b00193          	addi	x3,x0,43
 1000576:	01d01463          	bne	x0,x29,100057e <fail>
 100057a:	00301b63          	bne	x0,x3,1000590 <pass>

0100057e <fail>:
 100057e:	0ff0000f          	fence	iorw,iorw
 1000582:	00018063          	beq	x3,x0,1000582 <fail+0x4>
 1000586:	0186                	c.slli	x3,0x1
 1000588:	0011e193          	ori	x3,x3,1
 100058c:	00000073          	ecall

01000590 <pass>:
 1000590:	0ff0000f          	fence	iorw,iorw
 1000594:	4185                	c.li	x3,1
 1000596:	00000073          	ecall
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


rv32ui/sb.elf:     file format elf32-littleriscv


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
 1000068:	fff28293          	addi	x5,x5,-1 # 7fffffff <_end+0x7effdfef>
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
 10000ec:	00002097          	auipc	x1,0x2
 10000f0:	f1408093          	addi	x1,x1,-236 # 1002000 <begin_signature>
 10000f4:	faa00113          	addi	x2,x0,-86
 10000f8:	00208023          	sb	x2,0(x1)
 10000fc:	00008703          	lb	x14,0(x1)
 1000100:	faa00e93          	addi	x29,x0,-86
 1000104:	4189                	c.li	x3,2
 1000106:	33d71463          	bne	x14,x29,100042e <fail>

0100010a <test_3>:
 100010a:	00002097          	auipc	x1,0x2
 100010e:	ef608093          	addi	x1,x1,-266 # 1002000 <begin_signature>
 1000112:	4101                	c.li	x2,0
 1000114:	002080a3          	sb	x2,1(x1)
 1000118:	00108703          	lb	x14,1(x1)
 100011c:	4e81                	c.li	x29,0
 100011e:	418d                	c.li	x3,3
 1000120:	31d71763          	bne	x14,x29,100042e <fail>

01000124 <test_4>:
 1000124:	00002097          	auipc	x1,0x2
 1000128:	edc08093          	addi	x1,x1,-292 # 1002000 <begin_signature>
 100012c:	fffff137          	lui	x2,0xfffff
 1000130:	fa010113          	addi	x2,x2,-96 # ffffefa0 <_end+0xfeffcf90>
 1000134:	00208123          	sb	x2,2(x1)
 1000138:	00209703          	lh	x14,2(x1)
 100013c:	fffffeb7          	lui	x29,0xfffff
 1000140:	fa0e8e93          	addi	x29,x29,-96 # ffffefa0 <_end+0xfeffcf90>
 1000144:	4191                	c.li	x3,4
 1000146:	2fd71463          	bne	x14,x29,100042e <fail>

0100014a <test_5>:
 100014a:	00002097          	auipc	x1,0x2
 100014e:	eb608093          	addi	x1,x1,-330 # 1002000 <begin_signature>
 1000152:	4129                	c.li	x2,10
 1000154:	002081a3          	sb	x2,3(x1)
 1000158:	00308703          	lb	x14,3(x1)
 100015c:	4ea9                	c.li	x29,10
 100015e:	4195                	c.li	x3,5
 1000160:	2dd71763          	bne	x14,x29,100042e <fail>

01000164 <test_6>:
 1000164:	00002097          	auipc	x1,0x2
 1000168:	ea308093          	addi	x1,x1,-349 # 1002007 <tdat8>
 100016c:	faa00113          	addi	x2,x0,-86
 1000170:	fe208ea3          	sb	x2,-3(x1)
 1000174:	ffd08703          	lb	x14,-3(x1)
 1000178:	faa00e93          	addi	x29,x0,-86
 100017c:	4199                	c.li	x3,6
 100017e:	2bd71863          	bne	x14,x29,100042e <fail>

01000182 <test_7>:
 1000182:	00002097          	auipc	x1,0x2
 1000186:	e8508093          	addi	x1,x1,-379 # 1002007 <tdat8>
 100018a:	4101                	c.li	x2,0
 100018c:	fe208f23          	sb	x2,-2(x1)
 1000190:	ffe08703          	lb	x14,-2(x1)
 1000194:	4e81                	c.li	x29,0
 1000196:	419d                	c.li	x3,7
 1000198:	29d71b63          	bne	x14,x29,100042e <fail>

0100019c <test_8>:
 100019c:	00002097          	auipc	x1,0x2
 10001a0:	e6b08093          	addi	x1,x1,-405 # 1002007 <tdat8>
 10001a4:	fa000113          	addi	x2,x0,-96
 10001a8:	fe208fa3          	sb	x2,-1(x1)
 10001ac:	fff08703          	lb	x14,-1(x1)
 10001b0:	fa000e93          	addi	x29,x0,-96
 10001b4:	41a1                	c.li	x3,8
 10001b6:	27d71c63          	bne	x14,x29,100042e <fail>

010001ba <test_9>:
 10001ba:	00002097          	auipc	x1,0x2
 10001be:	e4d08093          	addi	x1,x1,-435 # 1002007 <tdat8>
 10001c2:	4129                	c.li	x2,10
 10001c4:	00208023          	sb	x2,0(x1)
 10001c8:	00008703          	lb	x14,0(x1)
 10001cc:	4ea9                	c.li	x29,10
 10001ce:	41a5                	c.li	x3,9
 10001d0:	25d71f63          	bne	x14,x29,100042e <fail>

010001d4 <test_10>:
 10001d4:	00002097          	auipc	x1,0x2
 10001d8:	e3408093          	addi	x1,x1,-460 # 1002008 <tdat9>
 10001dc:	12345137          	lui	x2,0x12345
 10001e0:	67810113          	addi	x2,x2,1656 # 12345678 <_end+0x11343668>
 10001e4:	fe008213          	addi	x4,x1,-32
 10001e8:	02220023          	sb	x2,32(x4) # 20 <_start-0xffffe0>
 10001ec:	00008283          	lb	x5,0(x1)
 10001f0:	07800e93          	addi	x29,x0,120
 10001f4:	41a9                	c.li	x3,10
 10001f6:	23d29c63          	bne	x5,x29,100042e <fail>

010001fa <test_11>:
 10001fa:	00002097          	auipc	x1,0x2
 10001fe:	e0e08093          	addi	x1,x1,-498 # 1002008 <tdat9>
 1000202:	00003137          	lui	x2,0x3
 1000206:	09810113          	addi	x2,x2,152 # 3098 <_start-0xffcf68>
 100020a:	10e9                	c.addi	x1,-6
 100020c:	002083a3          	sb	x2,7(x1)
 1000210:	00002217          	auipc	x4,0x2
 1000214:	df920213          	addi	x4,x4,-519 # 1002009 <tdat10>
 1000218:	00020283          	lb	x5,0(x4) # 0 <_start-0x1000000>
 100021c:	f9800e93          	addi	x29,x0,-104
 1000220:	41ad                	c.li	x3,11
 1000222:	21d29663          	bne	x5,x29,100042e <fail>

01000226 <test_12>:
 1000226:	41b1                	c.li	x3,12
 1000228:	4201                	c.li	x4,0
 100022a:	fdd00093          	addi	x1,x0,-35
 100022e:	00002117          	auipc	x2,0x2
 1000232:	dd210113          	addi	x2,x2,-558 # 1002000 <begin_signature>
 1000236:	00110023          	sb	x1,0(x2)
 100023a:	00010703          	lb	x14,0(x2)
 100023e:	fdd00e93          	addi	x29,x0,-35
 1000242:	1fd71663          	bne	x14,x29,100042e <fail>
 1000246:	0205                	c.addi	x4,1
 1000248:	4289                	c.li	x5,2
 100024a:	fe5210e3          	bne	x4,x5,100022a <test_12+0x4>

0100024e <test_13>:
 100024e:	41b5                	c.li	x3,13
 1000250:	4201                	c.li	x4,0
 1000252:	fcd00093          	addi	x1,x0,-51
 1000256:	00002117          	auipc	x2,0x2
 100025a:	daa10113          	addi	x2,x2,-598 # 1002000 <begin_signature>
 100025e:	0001                	c.addi	x0,0
 1000260:	001100a3          	sb	x1,1(x2)
 1000264:	00110703          	lb	x14,1(x2)
 1000268:	fcd00e93          	addi	x29,x0,-51
 100026c:	1dd71163          	bne	x14,x29,100042e <fail>
 1000270:	0205                	c.addi	x4,1
 1000272:	4289                	c.li	x5,2
 1000274:	fc521fe3          	bne	x4,x5,1000252 <test_13+0x4>

01000278 <test_14>:
 1000278:	41b9                	c.li	x3,14
 100027a:	4201                	c.li	x4,0
 100027c:	fcc00093          	addi	x1,x0,-52
 1000280:	00002117          	auipc	x2,0x2
 1000284:	d8010113          	addi	x2,x2,-640 # 1002000 <begin_signature>
 1000288:	0001                	c.addi	x0,0
 100028a:	0001                	c.addi	x0,0
 100028c:	00110123          	sb	x1,2(x2)
 1000290:	00210703          	lb	x14,2(x2)
 1000294:	fcc00e93          	addi	x29,x0,-52
 1000298:	19d71b63          	bne	x14,x29,100042e <fail>
 100029c:	0205                	c.addi	x4,1
 100029e:	4289                	c.li	x5,2
 10002a0:	fc521ee3          	bne	x4,x5,100027c <test_14+0x4>

010002a4 <test_15>:
 10002a4:	41bd                	c.li	x3,15
 10002a6:	4201                	c.li	x4,0
 10002a8:	fbc00093          	addi	x1,x0,-68
 10002ac:	0001                	c.addi	x0,0
 10002ae:	00002117          	auipc	x2,0x2
 10002b2:	d5210113          	addi	x2,x2,-686 # 1002000 <begin_signature>
 10002b6:	001101a3          	sb	x1,3(x2)
 10002ba:	00310703          	lb	x14,3(x2)
 10002be:	fbc00e93          	addi	x29,x0,-68
 10002c2:	17d71663          	bne	x14,x29,100042e <fail>
 10002c6:	0205                	c.addi	x4,1
 10002c8:	4289                	c.li	x5,2
 10002ca:	fc521fe3          	bne	x4,x5,10002a8 <test_15+0x4>

010002ce <test_16>:
 10002ce:	41c1                	c.li	x3,16
 10002d0:	4201                	c.li	x4,0
 10002d2:	fbb00093          	addi	x1,x0,-69
 10002d6:	0001                	c.addi	x0,0
 10002d8:	00002117          	auipc	x2,0x2
 10002dc:	d2810113          	addi	x2,x2,-728 # 1002000 <begin_signature>
 10002e0:	0001                	c.addi	x0,0
 10002e2:	00110223          	sb	x1,4(x2)
 10002e6:	00410703          	lb	x14,4(x2)
 10002ea:	fbb00e93          	addi	x29,x0,-69
 10002ee:	15d71063          	bne	x14,x29,100042e <fail>
 10002f2:	0205                	c.addi	x4,1
 10002f4:	4289                	c.li	x5,2
 10002f6:	fc521ee3          	bne	x4,x5,10002d2 <test_16+0x4>

010002fa <test_17>:
 10002fa:	41c5                	c.li	x3,17
 10002fc:	4201                	c.li	x4,0
 10002fe:	fab00093          	addi	x1,x0,-85
 1000302:	0001                	c.addi	x0,0
 1000304:	0001                	c.addi	x0,0
 1000306:	00002117          	auipc	x2,0x2
 100030a:	cfa10113          	addi	x2,x2,-774 # 1002000 <begin_signature>
 100030e:	001102a3          	sb	x1,5(x2)
 1000312:	00510703          	lb	x14,5(x2)
 1000316:	fab00e93          	addi	x29,x0,-85
 100031a:	11d71a63          	bne	x14,x29,100042e <fail>
 100031e:	0205                	c.addi	x4,1
 1000320:	4289                	c.li	x5,2
 1000322:	fc521ee3          	bne	x4,x5,10002fe <test_17+0x4>

01000326 <test_18>:
 1000326:	41c9                	c.li	x3,18
 1000328:	4201                	c.li	x4,0
 100032a:	00002117          	auipc	x2,0x2
 100032e:	cd610113          	addi	x2,x2,-810 # 1002000 <begin_signature>
 1000332:	03300093          	addi	x1,x0,51
 1000336:	00110023          	sb	x1,0(x2)
 100033a:	00010703          	lb	x14,0(x2)
 100033e:	03300e93          	addi	x29,x0,51
 1000342:	0fd71663          	bne	x14,x29,100042e <fail>
 1000346:	0205                	c.addi	x4,1
 1000348:	4289                	c.li	x5,2
 100034a:	fe5210e3          	bne	x4,x5,100032a <test_18+0x4>

0100034e <test_19>:
 100034e:	41cd                	c.li	x3,19
 1000350:	4201                	c.li	x4,0
 1000352:	00002117          	auipc	x2,0x2
 1000356:	cae10113          	addi	x2,x2,-850 # 1002000 <begin_signature>
 100035a:	02300093          	addi	x1,x0,35
 100035e:	0001                	c.addi	x0,0
 1000360:	001100a3          	sb	x1,1(x2)
 1000364:	00110703          	lb	x14,1(x2)
 1000368:	02300e93          	addi	x29,x0,35
 100036c:	0dd71163          	bne	x14,x29,100042e <fail>
 1000370:	0205                	c.addi	x4,1
 1000372:	4289                	c.li	x5,2
 1000374:	fc521fe3          	bne	x4,x5,1000352 <test_19+0x4>

01000378 <test_20>:
 1000378:	41d1                	c.li	x3,20
 100037a:	4201                	c.li	x4,0
 100037c:	00002117          	auipc	x2,0x2
 1000380:	c8410113          	addi	x2,x2,-892 # 1002000 <begin_signature>
 1000384:	02200093          	addi	x1,x0,34
 1000388:	0001                	c.addi	x0,0
 100038a:	0001                	c.addi	x0,0
 100038c:	00110123          	sb	x1,2(x2)
 1000390:	00210703          	lb	x14,2(x2)
 1000394:	02200e93          	addi	x29,x0,34
 1000398:	09d71b63          	bne	x14,x29,100042e <fail>
 100039c:	0205                	c.addi	x4,1
 100039e:	4289                	c.li	x5,2
 10003a0:	fc521ee3          	bne	x4,x5,100037c <test_20+0x4>

010003a4 <test_21>:
 10003a4:	41d5                	c.li	x3,21
 10003a6:	4201                	c.li	x4,0
 10003a8:	00002117          	auipc	x2,0x2
 10003ac:	c5810113          	addi	x2,x2,-936 # 1002000 <begin_signature>
 10003b0:	0001                	c.addi	x0,0
 10003b2:	40c9                	c.li	x1,18
 10003b4:	001101a3          	sb	x1,3(x2)
 10003b8:	00310703          	lb	x14,3(x2)
 10003bc:	4ec9                	c.li	x29,18
 10003be:	07d71863          	bne	x14,x29,100042e <fail>
 10003c2:	0205                	c.addi	x4,1
 10003c4:	4289                	c.li	x5,2
 10003c6:	fe5211e3          	bne	x4,x5,10003a8 <test_21+0x4>

010003ca <test_22>:
 10003ca:	41d9                	c.li	x3,22
 10003cc:	4201                	c.li	x4,0
 10003ce:	00002117          	auipc	x2,0x2
 10003d2:	c3210113          	addi	x2,x2,-974 # 1002000 <begin_signature>
 10003d6:	0001                	c.addi	x0,0
 10003d8:	40c5                	c.li	x1,17
 10003da:	0001                	c.addi	x0,0
 10003dc:	00110223          	sb	x1,4(x2)
 10003e0:	00410703          	lb	x14,4(x2)
 10003e4:	4ec5                	c.li	x29,17
 10003e6:	05d71463          	bne	x14,x29,100042e <fail>
 10003ea:	0205                	c.addi	x4,1
 10003ec:	4289                	c.li	x5,2
 10003ee:	fe5210e3          	bne	x4,x5,10003ce <test_22+0x4>

010003f2 <test_23>:
 10003f2:	41dd                	c.li	x3,23
 10003f4:	4201                	c.li	x4,0
 10003f6:	00002117          	auipc	x2,0x2
 10003fa:	c0a10113          	addi	x2,x2,-1014 # 1002000 <begin_signature>
 10003fe:	0001                	c.addi	x0,0
 1000400:	0001                	c.addi	x0,0
 1000402:	4085                	c.li	x1,1
 1000404:	001102a3          	sb	x1,5(x2)
 1000408:	00510703          	lb	x14,5(x2)
 100040c:	4e85                	c.li	x29,1
 100040e:	03d71063          	bne	x14,x29,100042e <fail>
 1000412:	0205                	c.addi	x4,1
 1000414:	4289                	c.li	x5,2
 1000416:	fe5210e3          	bne	x4,x5,10003f6 <test_23+0x4>
 100041a:	0ef00513          	addi	x10,x0,239
 100041e:	00002597          	auipc	x11,0x2
 1000422:	be258593          	addi	x11,x11,-1054 # 1002000 <begin_signature>
 1000426:	00a581a3          	sb	x10,3(x11)
 100042a:	00301b63          	bne	x0,x3,1000440 <pass>

0100042e <fail>:
 100042e:	0ff0000f          	fence	iorw,iorw
 1000432:	00018063          	beq	x3,x0,1000432 <fail+0x4>
 1000436:	0186                	c.slli	x3,0x1
 1000438:	0011e193          	ori	x3,x3,1
 100043c:	00000073          	ecall

01000440 <pass>:
 1000440:	0ff0000f          	fence	iorw,iorw
 1000444:	4185                	c.li	x3,1
 1000446:	00000073          	ecall
	...

Disassembly of section .tohost:

01001000 <tohost>:
	...

01001040 <fromhost>:
	...

Disassembly of section .data:

01002000 <begin_signature>:
 1002000:	          	jal	x31,10006fe <pass+0x2be>

01002001 <tdat2>:
 1002001:	          	jal	x31,10006ff <pass+0x2bf>

01002002 <tdat3>:
 1002002:	          	jal	x31,1000700 <pass+0x2c0>

01002003 <tdat4>:
 1002003:	          	jal	x31,1000701 <pass+0x2c1>

01002004 <tdat5>:
 1002004:	          	jal	x31,1000702 <pass+0x2c2>

01002005 <tdat6>:
 1002005:	          	jal	x31,1000703 <pass+0x2c3>

01002006 <tdat7>:
 1002006:	          	jal	x31,1000704 <pass+0x2c4>

01002007 <tdat8>:
 1002007:	          	jal	x31,1100015 <_end+0xfe005>

01002008 <tdat9>:
 1002008:	          	jal	x31,1010008 <_end+0xdff8>

01002009 <tdat10>:
 1002009:	000000ef          	jal	x1,1002009 <tdat10>
 100200d:	0000                	c.unimp
	...

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	3241                	c.jal	fffff980 <_end+0xfeffd970>
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
  1a:	326d                	c.jal	fffff9c4 <_end+0xfeffd9b4>
  1c:	3070                	c.fld	f12,224(x8)
  1e:	615f 7032 5f30      	0x5f307032615f
  24:	3266                	c.fldsp	f4,120(x2)
  26:	3070                	c.fld	f12,224(x8)
  28:	645f 7032 5f30      	0x5f307032645f
  2e:	30703263          	0x30703263
	...

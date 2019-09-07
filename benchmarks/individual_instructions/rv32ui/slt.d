
rv32ui/slt.elf:     file format elf32-littleriscv


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
 10000ee:	4101                	c.li	x2,0
 10000f0:	0020a733          	slt	x14,x1,x2
 10000f4:	4e81                	c.li	x29,0
 10000f6:	4189                	c.li	x3,2
 10000f8:	35d71863          	bne	x14,x29,1000448 <fail>

010000fc <test_3>:
 10000fc:	4085                	c.li	x1,1
 10000fe:	4105                	c.li	x2,1
 1000100:	0020a733          	slt	x14,x1,x2
 1000104:	4e81                	c.li	x29,0
 1000106:	418d                	c.li	x3,3
 1000108:	35d71063          	bne	x14,x29,1000448 <fail>

0100010c <test_4>:
 100010c:	408d                	c.li	x1,3
 100010e:	411d                	c.li	x2,7
 1000110:	0020a733          	slt	x14,x1,x2
 1000114:	4e85                	c.li	x29,1
 1000116:	4191                	c.li	x3,4
 1000118:	33d71863          	bne	x14,x29,1000448 <fail>

0100011c <test_5>:
 100011c:	409d                	c.li	x1,7
 100011e:	410d                	c.li	x2,3
 1000120:	0020a733          	slt	x14,x1,x2
 1000124:	4e81                	c.li	x29,0
 1000126:	4195                	c.li	x3,5
 1000128:	33d71063          	bne	x14,x29,1000448 <fail>

0100012c <test_6>:
 100012c:	4081                	c.li	x1,0
 100012e:	ffff8137          	lui	x2,0xffff8
 1000132:	0020a733          	slt	x14,x1,x2
 1000136:	4e81                	c.li	x29,0
 1000138:	4199                	c.li	x3,6
 100013a:	31d71763          	bne	x14,x29,1000448 <fail>

0100013e <test_7>:
 100013e:	800000b7          	lui	x1,0x80000
 1000142:	4101                	c.li	x2,0
 1000144:	0020a733          	slt	x14,x1,x2
 1000148:	4e85                	c.li	x29,1
 100014a:	419d                	c.li	x3,7
 100014c:	2fd71e63          	bne	x14,x29,1000448 <fail>

01000150 <test_8>:
 1000150:	800000b7          	lui	x1,0x80000
 1000154:	ffff8137          	lui	x2,0xffff8
 1000158:	0020a733          	slt	x14,x1,x2
 100015c:	4e85                	c.li	x29,1
 100015e:	41a1                	c.li	x3,8
 1000160:	2fd71463          	bne	x14,x29,1000448 <fail>

01000164 <test_9>:
 1000164:	4081                	c.li	x1,0
 1000166:	00008137          	lui	x2,0x8
 100016a:	fff10113          	addi	x2,x2,-1 # 7fff <_start-0xff8001>
 100016e:	0020a733          	slt	x14,x1,x2
 1000172:	4e85                	c.li	x29,1
 1000174:	41a5                	c.li	x3,9
 1000176:	2dd71963          	bne	x14,x29,1000448 <fail>

0100017a <test_10>:
 100017a:	800000b7          	lui	x1,0x80000
 100017e:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 1000182:	4101                	c.li	x2,0
 1000184:	0020a733          	slt	x14,x1,x2
 1000188:	4e81                	c.li	x29,0
 100018a:	41a9                	c.li	x3,10
 100018c:	2bd71e63          	bne	x14,x29,1000448 <fail>

01000190 <test_11>:
 1000190:	800000b7          	lui	x1,0x80000
 1000194:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 1000198:	00008137          	lui	x2,0x8
 100019c:	fff10113          	addi	x2,x2,-1 # 7fff <_start-0xff8001>
 10001a0:	0020a733          	slt	x14,x1,x2
 10001a4:	4e81                	c.li	x29,0
 10001a6:	41ad                	c.li	x3,11
 10001a8:	2bd71063          	bne	x14,x29,1000448 <fail>

010001ac <test_12>:
 10001ac:	800000b7          	lui	x1,0x80000
 10001b0:	00008137          	lui	x2,0x8
 10001b4:	fff10113          	addi	x2,x2,-1 # 7fff <_start-0xff8001>
 10001b8:	0020a733          	slt	x14,x1,x2
 10001bc:	4e85                	c.li	x29,1
 10001be:	41b1                	c.li	x3,12
 10001c0:	29d71463          	bne	x14,x29,1000448 <fail>

010001c4 <test_13>:
 10001c4:	800000b7          	lui	x1,0x80000
 10001c8:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 10001cc:	ffff8137          	lui	x2,0xffff8
 10001d0:	0020a733          	slt	x14,x1,x2
 10001d4:	4e81                	c.li	x29,0
 10001d6:	41b5                	c.li	x3,13
 10001d8:	27d71863          	bne	x14,x29,1000448 <fail>

010001dc <test_14>:
 10001dc:	4081                	c.li	x1,0
 10001de:	fff00113          	addi	x2,x0,-1
 10001e2:	0020a733          	slt	x14,x1,x2
 10001e6:	4e81                	c.li	x29,0
 10001e8:	41b9                	c.li	x3,14
 10001ea:	25d71f63          	bne	x14,x29,1000448 <fail>

010001ee <test_15>:
 10001ee:	fff00093          	addi	x1,x0,-1
 10001f2:	4105                	c.li	x2,1
 10001f4:	0020a733          	slt	x14,x1,x2
 10001f8:	4e85                	c.li	x29,1
 10001fa:	41bd                	c.li	x3,15
 10001fc:	25d71663          	bne	x14,x29,1000448 <fail>

01000200 <test_16>:
 1000200:	fff00093          	addi	x1,x0,-1
 1000204:	fff00113          	addi	x2,x0,-1
 1000208:	0020a733          	slt	x14,x1,x2
 100020c:	4e81                	c.li	x29,0
 100020e:	41c1                	c.li	x3,16
 1000210:	23d71c63          	bne	x14,x29,1000448 <fail>

01000214 <test_17>:
 1000214:	40b9                	c.li	x1,14
 1000216:	4135                	c.li	x2,13
 1000218:	0020a0b3          	slt	x1,x1,x2
 100021c:	4e81                	c.li	x29,0
 100021e:	41c5                	c.li	x3,17
 1000220:	23d09463          	bne	x1,x29,1000448 <fail>

01000224 <test_18>:
 1000224:	40ad                	c.li	x1,11
 1000226:	4135                	c.li	x2,13
 1000228:	0020a133          	slt	x2,x1,x2
 100022c:	4e85                	c.li	x29,1
 100022e:	41c9                	c.li	x3,18
 1000230:	21d11c63          	bne	x2,x29,1000448 <fail>

01000234 <test_19>:
 1000234:	40b5                	c.li	x1,13
 1000236:	0010a0b3          	slt	x1,x1,x1
 100023a:	4e81                	c.li	x29,0
 100023c:	41cd                	c.li	x3,19
 100023e:	21d09563          	bne	x1,x29,1000448 <fail>

01000242 <test_20>:
 1000242:	4201                	c.li	x4,0
 1000244:	40ad                	c.li	x1,11
 1000246:	4135                	c.li	x2,13
 1000248:	0020a733          	slt	x14,x1,x2
 100024c:	00070313          	addi	x6,x14,0
 1000250:	0205                	c.addi	x4,1
 1000252:	4289                	c.li	x5,2
 1000254:	fe5218e3          	bne	x4,x5,1000244 <test_20+0x2>
 1000258:	4e85                	c.li	x29,1
 100025a:	41d1                	c.li	x3,20
 100025c:	1fd31663          	bne	x6,x29,1000448 <fail>

01000260 <test_21>:
 1000260:	4201                	c.li	x4,0
 1000262:	40b9                	c.li	x1,14
 1000264:	4135                	c.li	x2,13
 1000266:	0020a733          	slt	x14,x1,x2
 100026a:	0001                	c.addi	x0,0
 100026c:	00070313          	addi	x6,x14,0
 1000270:	0205                	c.addi	x4,1
 1000272:	4289                	c.li	x5,2
 1000274:	fe5217e3          	bne	x4,x5,1000262 <test_21+0x2>
 1000278:	4e81                	c.li	x29,0
 100027a:	41d5                	c.li	x3,21
 100027c:	1dd31663          	bne	x6,x29,1000448 <fail>

01000280 <test_22>:
 1000280:	4201                	c.li	x4,0
 1000282:	40b1                	c.li	x1,12
 1000284:	4135                	c.li	x2,13
 1000286:	0020a733          	slt	x14,x1,x2
 100028a:	0001                	c.addi	x0,0
 100028c:	0001                	c.addi	x0,0
 100028e:	00070313          	addi	x6,x14,0
 1000292:	0205                	c.addi	x4,1
 1000294:	4289                	c.li	x5,2
 1000296:	fe5216e3          	bne	x4,x5,1000282 <test_22+0x2>
 100029a:	4e85                	c.li	x29,1
 100029c:	41d9                	c.li	x3,22
 100029e:	1bd31563          	bne	x6,x29,1000448 <fail>

010002a2 <test_23>:
 10002a2:	4201                	c.li	x4,0
 10002a4:	40b9                	c.li	x1,14
 10002a6:	4135                	c.li	x2,13
 10002a8:	0020a733          	slt	x14,x1,x2
 10002ac:	0205                	c.addi	x4,1
 10002ae:	4289                	c.li	x5,2
 10002b0:	fe521ae3          	bne	x4,x5,10002a4 <test_23+0x2>
 10002b4:	4e81                	c.li	x29,0
 10002b6:	41dd                	c.li	x3,23
 10002b8:	19d71863          	bne	x14,x29,1000448 <fail>

010002bc <test_24>:
 10002bc:	4201                	c.li	x4,0
 10002be:	40ad                	c.li	x1,11
 10002c0:	4135                	c.li	x2,13
 10002c2:	0001                	c.addi	x0,0
 10002c4:	0020a733          	slt	x14,x1,x2
 10002c8:	0205                	c.addi	x4,1
 10002ca:	4289                	c.li	x5,2
 10002cc:	fe5219e3          	bne	x4,x5,10002be <test_24+0x2>
 10002d0:	4e85                	c.li	x29,1
 10002d2:	41e1                	c.li	x3,24
 10002d4:	17d71a63          	bne	x14,x29,1000448 <fail>

010002d8 <test_25>:
 10002d8:	4201                	c.li	x4,0
 10002da:	40bd                	c.li	x1,15
 10002dc:	4135                	c.li	x2,13
 10002de:	0001                	c.addi	x0,0
 10002e0:	0001                	c.addi	x0,0
 10002e2:	0020a733          	slt	x14,x1,x2
 10002e6:	0205                	c.addi	x4,1
 10002e8:	4289                	c.li	x5,2
 10002ea:	fe5218e3          	bne	x4,x5,10002da <test_25+0x2>
 10002ee:	4e81                	c.li	x29,0
 10002f0:	41e5                	c.li	x3,25
 10002f2:	15d71b63          	bne	x14,x29,1000448 <fail>

010002f6 <test_26>:
 10002f6:	4201                	c.li	x4,0
 10002f8:	40a9                	c.li	x1,10
 10002fa:	0001                	c.addi	x0,0
 10002fc:	4135                	c.li	x2,13
 10002fe:	0020a733          	slt	x14,x1,x2
 1000302:	0205                	c.addi	x4,1
 1000304:	4289                	c.li	x5,2
 1000306:	fe5219e3          	bne	x4,x5,10002f8 <test_26+0x2>
 100030a:	4e85                	c.li	x29,1
 100030c:	41e9                	c.li	x3,26
 100030e:	13d71d63          	bne	x14,x29,1000448 <fail>

01000312 <test_27>:
 1000312:	4201                	c.li	x4,0
 1000314:	40c1                	c.li	x1,16
 1000316:	0001                	c.addi	x0,0
 1000318:	4135                	c.li	x2,13
 100031a:	0001                	c.addi	x0,0
 100031c:	0020a733          	slt	x14,x1,x2
 1000320:	0205                	c.addi	x4,1
 1000322:	4289                	c.li	x5,2
 1000324:	fe5218e3          	bne	x4,x5,1000314 <test_27+0x2>
 1000328:	4e81                	c.li	x29,0
 100032a:	41ed                	c.li	x3,27
 100032c:	11d71e63          	bne	x14,x29,1000448 <fail>

01000330 <test_28>:
 1000330:	4201                	c.li	x4,0
 1000332:	40a5                	c.li	x1,9
 1000334:	0001                	c.addi	x0,0
 1000336:	0001                	c.addi	x0,0
 1000338:	4135                	c.li	x2,13
 100033a:	0020a733          	slt	x14,x1,x2
 100033e:	0205                	c.addi	x4,1
 1000340:	4289                	c.li	x5,2
 1000342:	fe5218e3          	bne	x4,x5,1000332 <test_28+0x2>
 1000346:	4e85                	c.li	x29,1
 1000348:	41f1                	c.li	x3,28
 100034a:	0fd71f63          	bne	x14,x29,1000448 <fail>

0100034e <test_29>:
 100034e:	4201                	c.li	x4,0
 1000350:	4135                	c.li	x2,13
 1000352:	40c5                	c.li	x1,17
 1000354:	0020a733          	slt	x14,x1,x2
 1000358:	0205                	c.addi	x4,1
 100035a:	4289                	c.li	x5,2
 100035c:	fe521ae3          	bne	x4,x5,1000350 <test_29+0x2>
 1000360:	4e81                	c.li	x29,0
 1000362:	41f5                	c.li	x3,29
 1000364:	0fd71263          	bne	x14,x29,1000448 <fail>

01000368 <test_30>:
 1000368:	4201                	c.li	x4,0
 100036a:	4135                	c.li	x2,13
 100036c:	40a1                	c.li	x1,8
 100036e:	0001                	c.addi	x0,0
 1000370:	0020a733          	slt	x14,x1,x2
 1000374:	0205                	c.addi	x4,1
 1000376:	4289                	c.li	x5,2
 1000378:	fe5219e3          	bne	x4,x5,100036a <test_30+0x2>
 100037c:	4e85                	c.li	x29,1
 100037e:	41f9                	c.li	x3,30
 1000380:	0dd71463          	bne	x14,x29,1000448 <fail>

01000384 <test_31>:
 1000384:	4201                	c.li	x4,0
 1000386:	4135                	c.li	x2,13
 1000388:	40c9                	c.li	x1,18
 100038a:	0001                	c.addi	x0,0
 100038c:	0001                	c.addi	x0,0
 100038e:	0020a733          	slt	x14,x1,x2
 1000392:	0205                	c.addi	x4,1
 1000394:	4289                	c.li	x5,2
 1000396:	fe5218e3          	bne	x4,x5,1000386 <test_31+0x2>
 100039a:	4e81                	c.li	x29,0
 100039c:	41fd                	c.li	x3,31
 100039e:	0bd71563          	bne	x14,x29,1000448 <fail>

010003a2 <test_32>:
 10003a2:	4201                	c.li	x4,0
 10003a4:	4135                	c.li	x2,13
 10003a6:	0001                	c.addi	x0,0
 10003a8:	409d                	c.li	x1,7
 10003aa:	0020a733          	slt	x14,x1,x2
 10003ae:	0205                	c.addi	x4,1
 10003b0:	4289                	c.li	x5,2
 10003b2:	fe5219e3          	bne	x4,x5,10003a4 <test_32+0x2>
 10003b6:	4e85                	c.li	x29,1
 10003b8:	02000193          	addi	x3,x0,32
 10003bc:	09d71663          	bne	x14,x29,1000448 <fail>

010003c0 <test_33>:
 10003c0:	4201                	c.li	x4,0
 10003c2:	4135                	c.li	x2,13
 10003c4:	0001                	c.addi	x0,0
 10003c6:	40cd                	c.li	x1,19
 10003c8:	0001                	c.addi	x0,0
 10003ca:	0020a733          	slt	x14,x1,x2
 10003ce:	0205                	c.addi	x4,1
 10003d0:	4289                	c.li	x5,2
 10003d2:	fe5218e3          	bne	x4,x5,10003c2 <test_33+0x2>
 10003d6:	4e81                	c.li	x29,0
 10003d8:	02100193          	addi	x3,x0,33
 10003dc:	07d71663          	bne	x14,x29,1000448 <fail>

010003e0 <test_34>:
 10003e0:	4201                	c.li	x4,0
 10003e2:	4135                	c.li	x2,13
 10003e4:	0001                	c.addi	x0,0
 10003e6:	0001                	c.addi	x0,0
 10003e8:	4099                	c.li	x1,6
 10003ea:	0020a733          	slt	x14,x1,x2
 10003ee:	0205                	c.addi	x4,1
 10003f0:	4289                	c.li	x5,2
 10003f2:	fe5218e3          	bne	x4,x5,10003e2 <test_34+0x2>
 10003f6:	4e85                	c.li	x29,1
 10003f8:	02200193          	addi	x3,x0,34
 10003fc:	05d71663          	bne	x14,x29,1000448 <fail>

01000400 <test_35>:
 1000400:	fff00093          	addi	x1,x0,-1
 1000404:	00102133          	slt	x2,x0,x1
 1000408:	4e81                	c.li	x29,0
 100040a:	02300193          	addi	x3,x0,35
 100040e:	03d11d63          	bne	x2,x29,1000448 <fail>

01000412 <test_36>:
 1000412:	fff00093          	addi	x1,x0,-1
 1000416:	0000a133          	slt	x2,x1,x0
 100041a:	4e85                	c.li	x29,1
 100041c:	02400193          	addi	x3,x0,36
 1000420:	03d11463          	bne	x2,x29,1000448 <fail>

01000424 <test_37>:
 1000424:	000020b3          	slt	x1,x0,x0
 1000428:	4e81                	c.li	x29,0
 100042a:	02500193          	addi	x3,x0,37
 100042e:	01d09d63          	bne	x1,x29,1000448 <fail>

01000432 <test_38>:
 1000432:	40c1                	c.li	x1,16
 1000434:	4179                	c.li	x2,30
 1000436:	0020a033          	slt	x0,x1,x2
 100043a:	4e81                	c.li	x29,0
 100043c:	02600193          	addi	x3,x0,38
 1000440:	01d01463          	bne	x0,x29,1000448 <fail>
 1000444:	00301b63          	bne	x0,x3,100045a <pass>

01000448 <fail>:
 1000448:	0ff0000f          	fence	iorw,iorw
 100044c:	00018063          	beq	x3,x0,100044c <fail+0x4>
 1000450:	0186                	c.slli	x3,0x1
 1000452:	0011e193          	ori	x3,x3,1
 1000456:	00000073          	ecall

0100045a <pass>:
 100045a:	0ff0000f          	fence	iorw,iorw
 100045e:	4185                	c.li	x3,1
 1000460:	00000073          	ecall
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

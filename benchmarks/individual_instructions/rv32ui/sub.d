
rv32ui/sub.elf:     file format elf32-littleriscv


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
 10000f0:	40208733          	sub	x14,x1,x2
 10000f4:	4e81                	c.li	x29,0
 10000f6:	4189                	c.li	x3,2
 10000f8:	37d71163          	bne	x14,x29,100045a <fail>

010000fc <test_3>:
 10000fc:	4085                	c.li	x1,1
 10000fe:	4105                	c.li	x2,1
 1000100:	40208733          	sub	x14,x1,x2
 1000104:	4e81                	c.li	x29,0
 1000106:	418d                	c.li	x3,3
 1000108:	35d71963          	bne	x14,x29,100045a <fail>

0100010c <test_4>:
 100010c:	408d                	c.li	x1,3
 100010e:	411d                	c.li	x2,7
 1000110:	40208733          	sub	x14,x1,x2
 1000114:	ffc00e93          	addi	x29,x0,-4
 1000118:	4191                	c.li	x3,4
 100011a:	35d71063          	bne	x14,x29,100045a <fail>

0100011e <test_5>:
 100011e:	4081                	c.li	x1,0
 1000120:	ffff8137          	lui	x2,0xffff8
 1000124:	40208733          	sub	x14,x1,x2
 1000128:	6ea1                	c.lui	x29,0x8
 100012a:	4195                	c.li	x3,5
 100012c:	33d71763          	bne	x14,x29,100045a <fail>

01000130 <test_6>:
 1000130:	800000b7          	lui	x1,0x80000
 1000134:	4101                	c.li	x2,0
 1000136:	40208733          	sub	x14,x1,x2
 100013a:	80000eb7          	lui	x29,0x80000
 100013e:	4199                	c.li	x3,6
 1000140:	31d71d63          	bne	x14,x29,100045a <fail>

01000144 <test_7>:
 1000144:	800000b7          	lui	x1,0x80000
 1000148:	ffff8137          	lui	x2,0xffff8
 100014c:	40208733          	sub	x14,x1,x2
 1000150:	80008eb7          	lui	x29,0x80008
 1000154:	419d                	c.li	x3,7
 1000156:	31d71263          	bne	x14,x29,100045a <fail>

0100015a <test_8>:
 100015a:	4081                	c.li	x1,0
 100015c:	00008137          	lui	x2,0x8
 1000160:	fff10113          	addi	x2,x2,-1 # 7fff <_start-0xff8001>
 1000164:	40208733          	sub	x14,x1,x2
 1000168:	ffff8eb7          	lui	x29,0xffff8
 100016c:	001e8e93          	addi	x29,x29,1 # ffff8001 <_end+0xfeff6001>
 1000170:	41a1                	c.li	x3,8
 1000172:	2fd71463          	bne	x14,x29,100045a <fail>

01000176 <test_9>:
 1000176:	800000b7          	lui	x1,0x80000
 100017a:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 100017e:	4101                	c.li	x2,0
 1000180:	40208733          	sub	x14,x1,x2
 1000184:	80000eb7          	lui	x29,0x80000
 1000188:	fffe8e93          	addi	x29,x29,-1 # 7fffffff <_end+0x7effdfff>
 100018c:	41a5                	c.li	x3,9
 100018e:	2dd71663          	bne	x14,x29,100045a <fail>

01000192 <test_10>:
 1000192:	800000b7          	lui	x1,0x80000
 1000196:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 100019a:	00008137          	lui	x2,0x8
 100019e:	fff10113          	addi	x2,x2,-1 # 7fff <_start-0xff8001>
 10001a2:	40208733          	sub	x14,x1,x2
 10001a6:	7fff8eb7          	lui	x29,0x7fff8
 10001aa:	41a9                	c.li	x3,10
 10001ac:	2bd71763          	bne	x14,x29,100045a <fail>

010001b0 <test_11>:
 10001b0:	800000b7          	lui	x1,0x80000
 10001b4:	00008137          	lui	x2,0x8
 10001b8:	fff10113          	addi	x2,x2,-1 # 7fff <_start-0xff8001>
 10001bc:	40208733          	sub	x14,x1,x2
 10001c0:	7fff8eb7          	lui	x29,0x7fff8
 10001c4:	001e8e93          	addi	x29,x29,1 # 7fff8001 <_end+0x7eff6001>
 10001c8:	41ad                	c.li	x3,11
 10001ca:	29d71863          	bne	x14,x29,100045a <fail>

010001ce <test_12>:
 10001ce:	800000b7          	lui	x1,0x80000
 10001d2:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 10001d6:	ffff8137          	lui	x2,0xffff8
 10001da:	40208733          	sub	x14,x1,x2
 10001de:	80008eb7          	lui	x29,0x80008
 10001e2:	fffe8e93          	addi	x29,x29,-1 # 80007fff <_end+0x7f005fff>
 10001e6:	41b1                	c.li	x3,12
 10001e8:	27d71963          	bne	x14,x29,100045a <fail>

010001ec <test_13>:
 10001ec:	4081                	c.li	x1,0
 10001ee:	fff00113          	addi	x2,x0,-1
 10001f2:	40208733          	sub	x14,x1,x2
 10001f6:	4e85                	c.li	x29,1
 10001f8:	41b5                	c.li	x3,13
 10001fa:	27d71063          	bne	x14,x29,100045a <fail>

010001fe <test_14>:
 10001fe:	fff00093          	addi	x1,x0,-1
 1000202:	4105                	c.li	x2,1
 1000204:	40208733          	sub	x14,x1,x2
 1000208:	ffe00e93          	addi	x29,x0,-2
 100020c:	41b9                	c.li	x3,14
 100020e:	25d71663          	bne	x14,x29,100045a <fail>

01000212 <test_15>:
 1000212:	fff00093          	addi	x1,x0,-1
 1000216:	fff00113          	addi	x2,x0,-1
 100021a:	40208733          	sub	x14,x1,x2
 100021e:	4e81                	c.li	x29,0
 1000220:	41bd                	c.li	x3,15
 1000222:	23d71c63          	bne	x14,x29,100045a <fail>

01000226 <test_16>:
 1000226:	40b5                	c.li	x1,13
 1000228:	412d                	c.li	x2,11
 100022a:	402080b3          	sub	x1,x1,x2
 100022e:	4e89                	c.li	x29,2
 1000230:	41c1                	c.li	x3,16
 1000232:	23d09463          	bne	x1,x29,100045a <fail>

01000236 <test_17>:
 1000236:	40b9                	c.li	x1,14
 1000238:	412d                	c.li	x2,11
 100023a:	40208133          	sub	x2,x1,x2
 100023e:	4e8d                	c.li	x29,3
 1000240:	41c5                	c.li	x3,17
 1000242:	21d11c63          	bne	x2,x29,100045a <fail>

01000246 <test_18>:
 1000246:	40b5                	c.li	x1,13
 1000248:	401080b3          	sub	x1,x1,x1
 100024c:	4e81                	c.li	x29,0
 100024e:	41c9                	c.li	x3,18
 1000250:	21d09563          	bne	x1,x29,100045a <fail>

01000254 <test_19>:
 1000254:	4201                	c.li	x4,0
 1000256:	40b5                	c.li	x1,13
 1000258:	412d                	c.li	x2,11
 100025a:	40208733          	sub	x14,x1,x2
 100025e:	00070313          	addi	x6,x14,0
 1000262:	0205                	c.addi	x4,1
 1000264:	4289                	c.li	x5,2
 1000266:	fe5218e3          	bne	x4,x5,1000256 <test_19+0x2>
 100026a:	4e89                	c.li	x29,2
 100026c:	41cd                	c.li	x3,19
 100026e:	1fd31663          	bne	x6,x29,100045a <fail>

01000272 <test_20>:
 1000272:	4201                	c.li	x4,0
 1000274:	40b9                	c.li	x1,14
 1000276:	412d                	c.li	x2,11
 1000278:	40208733          	sub	x14,x1,x2
 100027c:	0001                	c.addi	x0,0
 100027e:	00070313          	addi	x6,x14,0
 1000282:	0205                	c.addi	x4,1
 1000284:	4289                	c.li	x5,2
 1000286:	fe5217e3          	bne	x4,x5,1000274 <test_20+0x2>
 100028a:	4e8d                	c.li	x29,3
 100028c:	41d1                	c.li	x3,20
 100028e:	1dd31663          	bne	x6,x29,100045a <fail>

01000292 <test_21>:
 1000292:	4201                	c.li	x4,0
 1000294:	40bd                	c.li	x1,15
 1000296:	412d                	c.li	x2,11
 1000298:	40208733          	sub	x14,x1,x2
 100029c:	0001                	c.addi	x0,0
 100029e:	0001                	c.addi	x0,0
 10002a0:	00070313          	addi	x6,x14,0
 10002a4:	0205                	c.addi	x4,1
 10002a6:	4289                	c.li	x5,2
 10002a8:	fe5216e3          	bne	x4,x5,1000294 <test_21+0x2>
 10002ac:	4e91                	c.li	x29,4
 10002ae:	41d5                	c.li	x3,21
 10002b0:	1bd31563          	bne	x6,x29,100045a <fail>

010002b4 <test_22>:
 10002b4:	4201                	c.li	x4,0
 10002b6:	40b5                	c.li	x1,13
 10002b8:	412d                	c.li	x2,11
 10002ba:	40208733          	sub	x14,x1,x2
 10002be:	0205                	c.addi	x4,1
 10002c0:	4289                	c.li	x5,2
 10002c2:	fe521ae3          	bne	x4,x5,10002b6 <test_22+0x2>
 10002c6:	4e89                	c.li	x29,2
 10002c8:	41d9                	c.li	x3,22
 10002ca:	19d71863          	bne	x14,x29,100045a <fail>

010002ce <test_23>:
 10002ce:	4201                	c.li	x4,0
 10002d0:	40b9                	c.li	x1,14
 10002d2:	412d                	c.li	x2,11
 10002d4:	0001                	c.addi	x0,0
 10002d6:	40208733          	sub	x14,x1,x2
 10002da:	0205                	c.addi	x4,1
 10002dc:	4289                	c.li	x5,2
 10002de:	fe5219e3          	bne	x4,x5,10002d0 <test_23+0x2>
 10002e2:	4e8d                	c.li	x29,3
 10002e4:	41dd                	c.li	x3,23
 10002e6:	17d71a63          	bne	x14,x29,100045a <fail>

010002ea <test_24>:
 10002ea:	4201                	c.li	x4,0
 10002ec:	40bd                	c.li	x1,15
 10002ee:	412d                	c.li	x2,11
 10002f0:	0001                	c.addi	x0,0
 10002f2:	0001                	c.addi	x0,0
 10002f4:	40208733          	sub	x14,x1,x2
 10002f8:	0205                	c.addi	x4,1
 10002fa:	4289                	c.li	x5,2
 10002fc:	fe5218e3          	bne	x4,x5,10002ec <test_24+0x2>
 1000300:	4e91                	c.li	x29,4
 1000302:	41e1                	c.li	x3,24
 1000304:	15d71b63          	bne	x14,x29,100045a <fail>

01000308 <test_25>:
 1000308:	4201                	c.li	x4,0
 100030a:	40b5                	c.li	x1,13
 100030c:	0001                	c.addi	x0,0
 100030e:	412d                	c.li	x2,11
 1000310:	40208733          	sub	x14,x1,x2
 1000314:	0205                	c.addi	x4,1
 1000316:	4289                	c.li	x5,2
 1000318:	fe5219e3          	bne	x4,x5,100030a <test_25+0x2>
 100031c:	4e89                	c.li	x29,2
 100031e:	41e5                	c.li	x3,25
 1000320:	13d71d63          	bne	x14,x29,100045a <fail>

01000324 <test_26>:
 1000324:	4201                	c.li	x4,0
 1000326:	40b9                	c.li	x1,14
 1000328:	0001                	c.addi	x0,0
 100032a:	412d                	c.li	x2,11
 100032c:	0001                	c.addi	x0,0
 100032e:	40208733          	sub	x14,x1,x2
 1000332:	0205                	c.addi	x4,1
 1000334:	4289                	c.li	x5,2
 1000336:	fe5218e3          	bne	x4,x5,1000326 <test_26+0x2>
 100033a:	4e8d                	c.li	x29,3
 100033c:	41e9                	c.li	x3,26
 100033e:	11d71e63          	bne	x14,x29,100045a <fail>

01000342 <test_27>:
 1000342:	4201                	c.li	x4,0
 1000344:	40bd                	c.li	x1,15
 1000346:	0001                	c.addi	x0,0
 1000348:	0001                	c.addi	x0,0
 100034a:	412d                	c.li	x2,11
 100034c:	40208733          	sub	x14,x1,x2
 1000350:	0205                	c.addi	x4,1
 1000352:	4289                	c.li	x5,2
 1000354:	fe5218e3          	bne	x4,x5,1000344 <test_27+0x2>
 1000358:	4e91                	c.li	x29,4
 100035a:	41ed                	c.li	x3,27
 100035c:	0fd71f63          	bne	x14,x29,100045a <fail>

01000360 <test_28>:
 1000360:	4201                	c.li	x4,0
 1000362:	412d                	c.li	x2,11
 1000364:	40b5                	c.li	x1,13
 1000366:	40208733          	sub	x14,x1,x2
 100036a:	0205                	c.addi	x4,1
 100036c:	4289                	c.li	x5,2
 100036e:	fe521ae3          	bne	x4,x5,1000362 <test_28+0x2>
 1000372:	4e89                	c.li	x29,2
 1000374:	41f1                	c.li	x3,28
 1000376:	0fd71263          	bne	x14,x29,100045a <fail>

0100037a <test_29>:
 100037a:	4201                	c.li	x4,0
 100037c:	412d                	c.li	x2,11
 100037e:	40b9                	c.li	x1,14
 1000380:	0001                	c.addi	x0,0
 1000382:	40208733          	sub	x14,x1,x2
 1000386:	0205                	c.addi	x4,1
 1000388:	4289                	c.li	x5,2
 100038a:	fe5219e3          	bne	x4,x5,100037c <test_29+0x2>
 100038e:	4e8d                	c.li	x29,3
 1000390:	41f5                	c.li	x3,29
 1000392:	0dd71463          	bne	x14,x29,100045a <fail>

01000396 <test_30>:
 1000396:	4201                	c.li	x4,0
 1000398:	412d                	c.li	x2,11
 100039a:	40bd                	c.li	x1,15
 100039c:	0001                	c.addi	x0,0
 100039e:	0001                	c.addi	x0,0
 10003a0:	40208733          	sub	x14,x1,x2
 10003a4:	0205                	c.addi	x4,1
 10003a6:	4289                	c.li	x5,2
 10003a8:	fe5218e3          	bne	x4,x5,1000398 <test_30+0x2>
 10003ac:	4e91                	c.li	x29,4
 10003ae:	41f9                	c.li	x3,30
 10003b0:	0bd71563          	bne	x14,x29,100045a <fail>

010003b4 <test_31>:
 10003b4:	4201                	c.li	x4,0
 10003b6:	412d                	c.li	x2,11
 10003b8:	0001                	c.addi	x0,0
 10003ba:	40b5                	c.li	x1,13
 10003bc:	40208733          	sub	x14,x1,x2
 10003c0:	0205                	c.addi	x4,1
 10003c2:	4289                	c.li	x5,2
 10003c4:	fe5219e3          	bne	x4,x5,10003b6 <test_31+0x2>
 10003c8:	4e89                	c.li	x29,2
 10003ca:	41fd                	c.li	x3,31
 10003cc:	09d71763          	bne	x14,x29,100045a <fail>

010003d0 <test_32>:
 10003d0:	4201                	c.li	x4,0
 10003d2:	412d                	c.li	x2,11
 10003d4:	0001                	c.addi	x0,0
 10003d6:	40b9                	c.li	x1,14
 10003d8:	0001                	c.addi	x0,0
 10003da:	40208733          	sub	x14,x1,x2
 10003de:	0205                	c.addi	x4,1
 10003e0:	4289                	c.li	x5,2
 10003e2:	fe5218e3          	bne	x4,x5,10003d2 <test_32+0x2>
 10003e6:	4e8d                	c.li	x29,3
 10003e8:	02000193          	addi	x3,x0,32
 10003ec:	07d71763          	bne	x14,x29,100045a <fail>

010003f0 <test_33>:
 10003f0:	4201                	c.li	x4,0
 10003f2:	412d                	c.li	x2,11
 10003f4:	0001                	c.addi	x0,0
 10003f6:	0001                	c.addi	x0,0
 10003f8:	40bd                	c.li	x1,15
 10003fa:	40208733          	sub	x14,x1,x2
 10003fe:	0205                	c.addi	x4,1
 1000400:	4289                	c.li	x5,2
 1000402:	fe5218e3          	bne	x4,x5,10003f2 <test_33+0x2>
 1000406:	4e91                	c.li	x29,4
 1000408:	02100193          	addi	x3,x0,33
 100040c:	05d71763          	bne	x14,x29,100045a <fail>

01000410 <test_34>:
 1000410:	ff100093          	addi	x1,x0,-15
 1000414:	40100133          	sub	x2,x0,x1
 1000418:	4ebd                	c.li	x29,15
 100041a:	02200193          	addi	x3,x0,34
 100041e:	03d11e63          	bne	x2,x29,100045a <fail>

01000422 <test_35>:
 1000422:	02000093          	addi	x1,x0,32
 1000426:	40008133          	sub	x2,x1,x0
 100042a:	02000e93          	addi	x29,x0,32
 100042e:	02300193          	addi	x3,x0,35
 1000432:	03d11463          	bne	x2,x29,100045a <fail>

01000436 <test_36>:
 1000436:	400000b3          	sub	x1,x0,x0
 100043a:	4e81                	c.li	x29,0
 100043c:	02400193          	addi	x3,x0,36
 1000440:	01d09d63          	bne	x1,x29,100045a <fail>

01000444 <test_37>:
 1000444:	40c1                	c.li	x1,16
 1000446:	4179                	c.li	x2,30
 1000448:	40208033          	sub	x0,x1,x2
 100044c:	4e81                	c.li	x29,0
 100044e:	02500193          	addi	x3,x0,37
 1000452:	01d01463          	bne	x0,x29,100045a <fail>
 1000456:	00301b63          	bne	x0,x3,100046c <pass>

0100045a <fail>:
 100045a:	0ff0000f          	fence	iorw,iorw
 100045e:	00018063          	beq	x3,x0,100045e <fail+0x4>
 1000462:	0186                	c.slli	x3,0x1
 1000464:	0011e193          	ori	x3,x3,1
 1000468:	00000073          	ecall

0100046c <pass>:
 100046c:	0ff0000f          	fence	iorw,iorw
 1000470:	4185                	c.li	x3,1
 1000472:	00000073          	ecall
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

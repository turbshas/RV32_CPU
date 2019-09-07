
rv32ui/add.elf:     file format elf32-littleriscv


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
 10000f0:	00208733          	add	x14,x1,x2
 10000f4:	4e81                	c.li	x29,0
 10000f6:	4189                	c.li	x3,2
 10000f8:	37d71d63          	bne	x14,x29,1000472 <fail>

010000fc <test_3>:
 10000fc:	4085                	c.li	x1,1
 10000fe:	4105                	c.li	x2,1
 1000100:	00208733          	add	x14,x1,x2
 1000104:	4e89                	c.li	x29,2
 1000106:	418d                	c.li	x3,3
 1000108:	37d71563          	bne	x14,x29,1000472 <fail>

0100010c <test_4>:
 100010c:	408d                	c.li	x1,3
 100010e:	411d                	c.li	x2,7
 1000110:	00208733          	add	x14,x1,x2
 1000114:	4ea9                	c.li	x29,10
 1000116:	4191                	c.li	x3,4
 1000118:	35d71d63          	bne	x14,x29,1000472 <fail>

0100011c <test_5>:
 100011c:	4081                	c.li	x1,0
 100011e:	ffff8137          	lui	x2,0xffff8
 1000122:	00208733          	add	x14,x1,x2
 1000126:	ffff8eb7          	lui	x29,0xffff8
 100012a:	4195                	c.li	x3,5
 100012c:	35d71363          	bne	x14,x29,1000472 <fail>

01000130 <test_6>:
 1000130:	800000b7          	lui	x1,0x80000
 1000134:	4101                	c.li	x2,0
 1000136:	00208733          	add	x14,x1,x2
 100013a:	80000eb7          	lui	x29,0x80000
 100013e:	4199                	c.li	x3,6
 1000140:	33d71963          	bne	x14,x29,1000472 <fail>

01000144 <test_7>:
 1000144:	800000b7          	lui	x1,0x80000
 1000148:	ffff8137          	lui	x2,0xffff8
 100014c:	00208733          	add	x14,x1,x2
 1000150:	7fff8eb7          	lui	x29,0x7fff8
 1000154:	419d                	c.li	x3,7
 1000156:	31d71e63          	bne	x14,x29,1000472 <fail>

0100015a <test_8>:
 100015a:	4081                	c.li	x1,0
 100015c:	00008137          	lui	x2,0x8
 1000160:	fff10113          	addi	x2,x2,-1 # 7fff <_start-0xff8001>
 1000164:	00208733          	add	x14,x1,x2
 1000168:	00008eb7          	lui	x29,0x8
 100016c:	fffe8e93          	addi	x29,x29,-1 # 7fff <_start-0xff8001>
 1000170:	41a1                	c.li	x3,8
 1000172:	31d71063          	bne	x14,x29,1000472 <fail>

01000176 <test_9>:
 1000176:	800000b7          	lui	x1,0x80000
 100017a:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 100017e:	4101                	c.li	x2,0
 1000180:	00208733          	add	x14,x1,x2
 1000184:	80000eb7          	lui	x29,0x80000
 1000188:	fffe8e93          	addi	x29,x29,-1 # 7fffffff <_end+0x7effdfff>
 100018c:	41a5                	c.li	x3,9
 100018e:	2fd71263          	bne	x14,x29,1000472 <fail>

01000192 <test_10>:
 1000192:	800000b7          	lui	x1,0x80000
 1000196:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 100019a:	00008137          	lui	x2,0x8
 100019e:	fff10113          	addi	x2,x2,-1 # 7fff <_start-0xff8001>
 10001a2:	00208733          	add	x14,x1,x2
 10001a6:	80008eb7          	lui	x29,0x80008
 10001aa:	ffee8e93          	addi	x29,x29,-2 # 80007ffe <_end+0x7f005ffe>
 10001ae:	41a9                	c.li	x3,10
 10001b0:	2dd71163          	bne	x14,x29,1000472 <fail>

010001b4 <test_11>:
 10001b4:	800000b7          	lui	x1,0x80000
 10001b8:	00008137          	lui	x2,0x8
 10001bc:	fff10113          	addi	x2,x2,-1 # 7fff <_start-0xff8001>
 10001c0:	00208733          	add	x14,x1,x2
 10001c4:	80008eb7          	lui	x29,0x80008
 10001c8:	fffe8e93          	addi	x29,x29,-1 # 80007fff <_end+0x7f005fff>
 10001cc:	41ad                	c.li	x3,11
 10001ce:	2bd71263          	bne	x14,x29,1000472 <fail>

010001d2 <test_12>:
 10001d2:	800000b7          	lui	x1,0x80000
 10001d6:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 10001da:	ffff8137          	lui	x2,0xffff8
 10001de:	00208733          	add	x14,x1,x2
 10001e2:	7fff8eb7          	lui	x29,0x7fff8
 10001e6:	fffe8e93          	addi	x29,x29,-1 # 7fff7fff <_end+0x7eff5fff>
 10001ea:	41b1                	c.li	x3,12
 10001ec:	29d71363          	bne	x14,x29,1000472 <fail>

010001f0 <test_13>:
 10001f0:	4081                	c.li	x1,0
 10001f2:	fff00113          	addi	x2,x0,-1
 10001f6:	00208733          	add	x14,x1,x2
 10001fa:	fff00e93          	addi	x29,x0,-1
 10001fe:	41b5                	c.li	x3,13
 1000200:	27d71963          	bne	x14,x29,1000472 <fail>

01000204 <test_14>:
 1000204:	fff00093          	addi	x1,x0,-1
 1000208:	4105                	c.li	x2,1
 100020a:	00208733          	add	x14,x1,x2
 100020e:	4e81                	c.li	x29,0
 1000210:	41b9                	c.li	x3,14
 1000212:	27d71063          	bne	x14,x29,1000472 <fail>

01000216 <test_15>:
 1000216:	fff00093          	addi	x1,x0,-1
 100021a:	fff00113          	addi	x2,x0,-1
 100021e:	00208733          	add	x14,x1,x2
 1000222:	ffe00e93          	addi	x29,x0,-2
 1000226:	41bd                	c.li	x3,15
 1000228:	25d71563          	bne	x14,x29,1000472 <fail>

0100022c <test_16>:
 100022c:	4085                	c.li	x1,1
 100022e:	80000137          	lui	x2,0x80000
 1000232:	fff10113          	addi	x2,x2,-1 # 7fffffff <_end+0x7effdfff>
 1000236:	00208733          	add	x14,x1,x2
 100023a:	80000eb7          	lui	x29,0x80000
 100023e:	41c1                	c.li	x3,16
 1000240:	23d71963          	bne	x14,x29,1000472 <fail>

01000244 <test_17>:
 1000244:	40b5                	c.li	x1,13
 1000246:	412d                	c.li	x2,11
 1000248:	908a                	c.add	x1,x2
 100024a:	4ee1                	c.li	x29,24
 100024c:	41c5                	c.li	x3,17
 100024e:	23d09263          	bne	x1,x29,1000472 <fail>

01000252 <test_18>:
 1000252:	40b9                	c.li	x1,14
 1000254:	412d                	c.li	x2,11
 1000256:	9106                	c.add	x2,x1
 1000258:	4ee5                	c.li	x29,25
 100025a:	41c9                	c.li	x3,18
 100025c:	21d11b63          	bne	x2,x29,1000472 <fail>

01000260 <test_19>:
 1000260:	40b5                	c.li	x1,13
 1000262:	9086                	c.add	x1,x1
 1000264:	4ee9                	c.li	x29,26
 1000266:	41cd                	c.li	x3,19
 1000268:	21d09563          	bne	x1,x29,1000472 <fail>

0100026c <test_20>:
 100026c:	4201                	c.li	x4,0
 100026e:	40b5                	c.li	x1,13
 1000270:	412d                	c.li	x2,11
 1000272:	00208733          	add	x14,x1,x2
 1000276:	00070313          	addi	x6,x14,0
 100027a:	0205                	c.addi	x4,1
 100027c:	4289                	c.li	x5,2
 100027e:	fe5218e3          	bne	x4,x5,100026e <test_20+0x2>
 1000282:	4ee1                	c.li	x29,24
 1000284:	41d1                	c.li	x3,20
 1000286:	1fd31663          	bne	x6,x29,1000472 <fail>

0100028a <test_21>:
 100028a:	4201                	c.li	x4,0
 100028c:	40b9                	c.li	x1,14
 100028e:	412d                	c.li	x2,11
 1000290:	00208733          	add	x14,x1,x2
 1000294:	0001                	c.addi	x0,0
 1000296:	00070313          	addi	x6,x14,0
 100029a:	0205                	c.addi	x4,1
 100029c:	4289                	c.li	x5,2
 100029e:	fe5217e3          	bne	x4,x5,100028c <test_21+0x2>
 10002a2:	4ee5                	c.li	x29,25
 10002a4:	41d5                	c.li	x3,21
 10002a6:	1dd31663          	bne	x6,x29,1000472 <fail>

010002aa <test_22>:
 10002aa:	4201                	c.li	x4,0
 10002ac:	40bd                	c.li	x1,15
 10002ae:	412d                	c.li	x2,11
 10002b0:	00208733          	add	x14,x1,x2
 10002b4:	0001                	c.addi	x0,0
 10002b6:	0001                	c.addi	x0,0
 10002b8:	00070313          	addi	x6,x14,0
 10002bc:	0205                	c.addi	x4,1
 10002be:	4289                	c.li	x5,2
 10002c0:	fe5216e3          	bne	x4,x5,10002ac <test_22+0x2>
 10002c4:	4ee9                	c.li	x29,26
 10002c6:	41d9                	c.li	x3,22
 10002c8:	1bd31563          	bne	x6,x29,1000472 <fail>

010002cc <test_23>:
 10002cc:	4201                	c.li	x4,0
 10002ce:	40b5                	c.li	x1,13
 10002d0:	412d                	c.li	x2,11
 10002d2:	00208733          	add	x14,x1,x2
 10002d6:	0205                	c.addi	x4,1
 10002d8:	4289                	c.li	x5,2
 10002da:	fe521ae3          	bne	x4,x5,10002ce <test_23+0x2>
 10002de:	4ee1                	c.li	x29,24
 10002e0:	41dd                	c.li	x3,23
 10002e2:	19d71863          	bne	x14,x29,1000472 <fail>

010002e6 <test_24>:
 10002e6:	4201                	c.li	x4,0
 10002e8:	40b9                	c.li	x1,14
 10002ea:	412d                	c.li	x2,11
 10002ec:	0001                	c.addi	x0,0
 10002ee:	00208733          	add	x14,x1,x2
 10002f2:	0205                	c.addi	x4,1
 10002f4:	4289                	c.li	x5,2
 10002f6:	fe5219e3          	bne	x4,x5,10002e8 <test_24+0x2>
 10002fa:	4ee5                	c.li	x29,25
 10002fc:	41e1                	c.li	x3,24
 10002fe:	17d71a63          	bne	x14,x29,1000472 <fail>

01000302 <test_25>:
 1000302:	4201                	c.li	x4,0
 1000304:	40bd                	c.li	x1,15
 1000306:	412d                	c.li	x2,11
 1000308:	0001                	c.addi	x0,0
 100030a:	0001                	c.addi	x0,0
 100030c:	00208733          	add	x14,x1,x2
 1000310:	0205                	c.addi	x4,1
 1000312:	4289                	c.li	x5,2
 1000314:	fe5218e3          	bne	x4,x5,1000304 <test_25+0x2>
 1000318:	4ee9                	c.li	x29,26
 100031a:	41e5                	c.li	x3,25
 100031c:	15d71b63          	bne	x14,x29,1000472 <fail>

01000320 <test_26>:
 1000320:	4201                	c.li	x4,0
 1000322:	40b5                	c.li	x1,13
 1000324:	0001                	c.addi	x0,0
 1000326:	412d                	c.li	x2,11
 1000328:	00208733          	add	x14,x1,x2
 100032c:	0205                	c.addi	x4,1
 100032e:	4289                	c.li	x5,2
 1000330:	fe5219e3          	bne	x4,x5,1000322 <test_26+0x2>
 1000334:	4ee1                	c.li	x29,24
 1000336:	41e9                	c.li	x3,26
 1000338:	13d71d63          	bne	x14,x29,1000472 <fail>

0100033c <test_27>:
 100033c:	4201                	c.li	x4,0
 100033e:	40b9                	c.li	x1,14
 1000340:	0001                	c.addi	x0,0
 1000342:	412d                	c.li	x2,11
 1000344:	0001                	c.addi	x0,0
 1000346:	00208733          	add	x14,x1,x2
 100034a:	0205                	c.addi	x4,1
 100034c:	4289                	c.li	x5,2
 100034e:	fe5218e3          	bne	x4,x5,100033e <test_27+0x2>
 1000352:	4ee5                	c.li	x29,25
 1000354:	41ed                	c.li	x3,27
 1000356:	11d71e63          	bne	x14,x29,1000472 <fail>

0100035a <test_28>:
 100035a:	4201                	c.li	x4,0
 100035c:	40bd                	c.li	x1,15
 100035e:	0001                	c.addi	x0,0
 1000360:	0001                	c.addi	x0,0
 1000362:	412d                	c.li	x2,11
 1000364:	00208733          	add	x14,x1,x2
 1000368:	0205                	c.addi	x4,1
 100036a:	4289                	c.li	x5,2
 100036c:	fe5218e3          	bne	x4,x5,100035c <test_28+0x2>
 1000370:	4ee9                	c.li	x29,26
 1000372:	41f1                	c.li	x3,28
 1000374:	0fd71f63          	bne	x14,x29,1000472 <fail>

01000378 <test_29>:
 1000378:	4201                	c.li	x4,0
 100037a:	412d                	c.li	x2,11
 100037c:	40b5                	c.li	x1,13
 100037e:	00208733          	add	x14,x1,x2
 1000382:	0205                	c.addi	x4,1
 1000384:	4289                	c.li	x5,2
 1000386:	fe521ae3          	bne	x4,x5,100037a <test_29+0x2>
 100038a:	4ee1                	c.li	x29,24
 100038c:	41f5                	c.li	x3,29
 100038e:	0fd71263          	bne	x14,x29,1000472 <fail>

01000392 <test_30>:
 1000392:	4201                	c.li	x4,0
 1000394:	412d                	c.li	x2,11
 1000396:	40b9                	c.li	x1,14
 1000398:	0001                	c.addi	x0,0
 100039a:	00208733          	add	x14,x1,x2
 100039e:	0205                	c.addi	x4,1
 10003a0:	4289                	c.li	x5,2
 10003a2:	fe5219e3          	bne	x4,x5,1000394 <test_30+0x2>
 10003a6:	4ee5                	c.li	x29,25
 10003a8:	41f9                	c.li	x3,30
 10003aa:	0dd71463          	bne	x14,x29,1000472 <fail>

010003ae <test_31>:
 10003ae:	4201                	c.li	x4,0
 10003b0:	412d                	c.li	x2,11
 10003b2:	40bd                	c.li	x1,15
 10003b4:	0001                	c.addi	x0,0
 10003b6:	0001                	c.addi	x0,0
 10003b8:	00208733          	add	x14,x1,x2
 10003bc:	0205                	c.addi	x4,1
 10003be:	4289                	c.li	x5,2
 10003c0:	fe5218e3          	bne	x4,x5,10003b0 <test_31+0x2>
 10003c4:	4ee9                	c.li	x29,26
 10003c6:	41fd                	c.li	x3,31
 10003c8:	0bd71563          	bne	x14,x29,1000472 <fail>

010003cc <test_32>:
 10003cc:	4201                	c.li	x4,0
 10003ce:	412d                	c.li	x2,11
 10003d0:	0001                	c.addi	x0,0
 10003d2:	40b5                	c.li	x1,13
 10003d4:	00208733          	add	x14,x1,x2
 10003d8:	0205                	c.addi	x4,1
 10003da:	4289                	c.li	x5,2
 10003dc:	fe5219e3          	bne	x4,x5,10003ce <test_32+0x2>
 10003e0:	4ee1                	c.li	x29,24
 10003e2:	02000193          	addi	x3,x0,32
 10003e6:	09d71663          	bne	x14,x29,1000472 <fail>

010003ea <test_33>:
 10003ea:	4201                	c.li	x4,0
 10003ec:	412d                	c.li	x2,11
 10003ee:	0001                	c.addi	x0,0
 10003f0:	40b9                	c.li	x1,14
 10003f2:	0001                	c.addi	x0,0
 10003f4:	00208733          	add	x14,x1,x2
 10003f8:	0205                	c.addi	x4,1
 10003fa:	4289                	c.li	x5,2
 10003fc:	fe5218e3          	bne	x4,x5,10003ec <test_33+0x2>
 1000400:	4ee5                	c.li	x29,25
 1000402:	02100193          	addi	x3,x0,33
 1000406:	07d71663          	bne	x14,x29,1000472 <fail>

0100040a <test_34>:
 100040a:	4201                	c.li	x4,0
 100040c:	412d                	c.li	x2,11
 100040e:	0001                	c.addi	x0,0
 1000410:	0001                	c.addi	x0,0
 1000412:	40bd                	c.li	x1,15
 1000414:	00208733          	add	x14,x1,x2
 1000418:	0205                	c.addi	x4,1
 100041a:	4289                	c.li	x5,2
 100041c:	fe5218e3          	bne	x4,x5,100040c <test_34+0x2>
 1000420:	4ee9                	c.li	x29,26
 1000422:	02200193          	addi	x3,x0,34
 1000426:	05d71663          	bne	x14,x29,1000472 <fail>

0100042a <test_35>:
 100042a:	40bd                	c.li	x1,15
 100042c:	00100133          	add	x2,x0,x1
 1000430:	4ebd                	c.li	x29,15
 1000432:	02300193          	addi	x3,x0,35
 1000436:	03d11e63          	bne	x2,x29,1000472 <fail>

0100043a <test_36>:
 100043a:	02000093          	addi	x1,x0,32
 100043e:	00008133          	add	x2,x1,x0
 1000442:	02000e93          	addi	x29,x0,32
 1000446:	02400193          	addi	x3,x0,36
 100044a:	03d11463          	bne	x2,x29,1000472 <fail>

0100044e <test_37>:
 100044e:	000000b3          	add	x1,x0,x0
 1000452:	4e81                	c.li	x29,0
 1000454:	02500193          	addi	x3,x0,37
 1000458:	01d09d63          	bne	x1,x29,1000472 <fail>

0100045c <test_38>:
 100045c:	40c1                	c.li	x1,16
 100045e:	4179                	c.li	x2,30
 1000460:	00208033          	add	x0,x1,x2
 1000464:	4e81                	c.li	x29,0
 1000466:	02600193          	addi	x3,x0,38
 100046a:	01d01463          	bne	x0,x29,1000472 <fail>
 100046e:	00301b63          	bne	x0,x3,1000484 <pass>

01000472 <fail>:
 1000472:	0ff0000f          	fence	iorw,iorw
 1000476:	00018063          	beq	x3,x0,1000476 <fail+0x4>
 100047a:	0186                	c.slli	x3,0x1
 100047c:	0011e193          	ori	x3,x3,1
 1000480:	00000073          	ecall

01000484 <pass>:
 1000484:	0ff0000f          	fence	iorw,iorw
 1000488:	4185                	c.li	x3,1
 100048a:	00000073          	ecall
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

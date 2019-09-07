
rv32ui/sll.elf:     file format elf32-littleriscv


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
 10000ec:	4085                	c.li	x1,1
 10000ee:	4101                	c.li	x2,0
 10000f0:	00209733          	sll	x14,x1,x2
 10000f4:	4e85                	c.li	x29,1
 10000f6:	4189                	c.li	x3,2
 10000f8:	41d71063          	bne	x14,x29,10004f8 <fail>

010000fc <test_3>:
 10000fc:	4085                	c.li	x1,1
 10000fe:	4105                	c.li	x2,1
 1000100:	00209733          	sll	x14,x1,x2
 1000104:	4e89                	c.li	x29,2
 1000106:	418d                	c.li	x3,3
 1000108:	3fd71863          	bne	x14,x29,10004f8 <fail>

0100010c <test_4>:
 100010c:	4085                	c.li	x1,1
 100010e:	411d                	c.li	x2,7
 1000110:	00209733          	sll	x14,x1,x2
 1000114:	08000e93          	addi	x29,x0,128
 1000118:	4191                	c.li	x3,4
 100011a:	3dd71f63          	bne	x14,x29,10004f8 <fail>

0100011e <test_5>:
 100011e:	4085                	c.li	x1,1
 1000120:	4139                	c.li	x2,14
 1000122:	00209733          	sll	x14,x1,x2
 1000126:	6e91                	c.lui	x29,0x4
 1000128:	4195                	c.li	x3,5
 100012a:	3dd71763          	bne	x14,x29,10004f8 <fail>

0100012e <test_6>:
 100012e:	4085                	c.li	x1,1
 1000130:	417d                	c.li	x2,31
 1000132:	00209733          	sll	x14,x1,x2
 1000136:	80000eb7          	lui	x29,0x80000
 100013a:	4199                	c.li	x3,6
 100013c:	3bd71e63          	bne	x14,x29,10004f8 <fail>

01000140 <test_7>:
 1000140:	fff00093          	addi	x1,x0,-1
 1000144:	4101                	c.li	x2,0
 1000146:	00209733          	sll	x14,x1,x2
 100014a:	fff00e93          	addi	x29,x0,-1
 100014e:	419d                	c.li	x3,7
 1000150:	3bd71463          	bne	x14,x29,10004f8 <fail>

01000154 <test_8>:
 1000154:	fff00093          	addi	x1,x0,-1
 1000158:	4105                	c.li	x2,1
 100015a:	00209733          	sll	x14,x1,x2
 100015e:	ffe00e93          	addi	x29,x0,-2
 1000162:	41a1                	c.li	x3,8
 1000164:	39d71a63          	bne	x14,x29,10004f8 <fail>

01000168 <test_9>:
 1000168:	fff00093          	addi	x1,x0,-1
 100016c:	411d                	c.li	x2,7
 100016e:	00209733          	sll	x14,x1,x2
 1000172:	f8000e93          	addi	x29,x0,-128
 1000176:	41a5                	c.li	x3,9
 1000178:	39d71063          	bne	x14,x29,10004f8 <fail>

0100017c <test_10>:
 100017c:	fff00093          	addi	x1,x0,-1
 1000180:	4139                	c.li	x2,14
 1000182:	00209733          	sll	x14,x1,x2
 1000186:	ffffceb7          	lui	x29,0xffffc
 100018a:	41a9                	c.li	x3,10
 100018c:	37d71663          	bne	x14,x29,10004f8 <fail>

01000190 <test_11>:
 1000190:	fff00093          	addi	x1,x0,-1
 1000194:	417d                	c.li	x2,31
 1000196:	00209733          	sll	x14,x1,x2
 100019a:	80000eb7          	lui	x29,0x80000
 100019e:	41ad                	c.li	x3,11
 10001a0:	35d71c63          	bne	x14,x29,10004f8 <fail>

010001a4 <test_12>:
 10001a4:	212120b7          	lui	x1,0x21212
 10001a8:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 10001ac:	4101                	c.li	x2,0
 10001ae:	00209733          	sll	x14,x1,x2
 10001b2:	21212eb7          	lui	x29,0x21212
 10001b6:	121e8e93          	addi	x29,x29,289 # 21212121 <_end+0x20210121>
 10001ba:	41b1                	c.li	x3,12
 10001bc:	33d71e63          	bne	x14,x29,10004f8 <fail>

010001c0 <test_13>:
 10001c0:	212120b7          	lui	x1,0x21212
 10001c4:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 10001c8:	4105                	c.li	x2,1
 10001ca:	00209733          	sll	x14,x1,x2
 10001ce:	42424eb7          	lui	x29,0x42424
 10001d2:	242e8e93          	addi	x29,x29,578 # 42424242 <_end+0x41422242>
 10001d6:	41b5                	c.li	x3,13
 10001d8:	33d71063          	bne	x14,x29,10004f8 <fail>

010001dc <test_14>:
 10001dc:	212120b7          	lui	x1,0x21212
 10001e0:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 10001e4:	411d                	c.li	x2,7
 10001e6:	00209733          	sll	x14,x1,x2
 10001ea:	90909eb7          	lui	x29,0x90909
 10001ee:	080e8e93          	addi	x29,x29,128 # 90909080 <_end+0x8f907080>
 10001f2:	41b9                	c.li	x3,14
 10001f4:	31d71263          	bne	x14,x29,10004f8 <fail>

010001f8 <test_15>:
 10001f8:	212120b7          	lui	x1,0x21212
 10001fc:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 1000200:	4139                	c.li	x2,14
 1000202:	00209733          	sll	x14,x1,x2
 1000206:	48484eb7          	lui	x29,0x48484
 100020a:	41bd                	c.li	x3,15
 100020c:	2fd71663          	bne	x14,x29,10004f8 <fail>

01000210 <test_16>:
 1000210:	212120b7          	lui	x1,0x21212
 1000214:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 1000218:	417d                	c.li	x2,31
 100021a:	00209733          	sll	x14,x1,x2
 100021e:	80000eb7          	lui	x29,0x80000
 1000222:	41c1                	c.li	x3,16
 1000224:	2dd71a63          	bne	x14,x29,10004f8 <fail>

01000228 <test_17>:
 1000228:	212120b7          	lui	x1,0x21212
 100022c:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 1000230:	fc000113          	addi	x2,x0,-64
 1000234:	00209733          	sll	x14,x1,x2
 1000238:	21212eb7          	lui	x29,0x21212
 100023c:	121e8e93          	addi	x29,x29,289 # 21212121 <_end+0x20210121>
 1000240:	41c5                	c.li	x3,17
 1000242:	2bd71b63          	bne	x14,x29,10004f8 <fail>

01000246 <test_18>:
 1000246:	212120b7          	lui	x1,0x21212
 100024a:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 100024e:	fc100113          	addi	x2,x0,-63
 1000252:	00209733          	sll	x14,x1,x2
 1000256:	42424eb7          	lui	x29,0x42424
 100025a:	242e8e93          	addi	x29,x29,578 # 42424242 <_end+0x41422242>
 100025e:	41c9                	c.li	x3,18
 1000260:	29d71c63          	bne	x14,x29,10004f8 <fail>

01000264 <test_19>:
 1000264:	212120b7          	lui	x1,0x21212
 1000268:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 100026c:	fc700113          	addi	x2,x0,-57
 1000270:	00209733          	sll	x14,x1,x2
 1000274:	90909eb7          	lui	x29,0x90909
 1000278:	080e8e93          	addi	x29,x29,128 # 90909080 <_end+0x8f907080>
 100027c:	41cd                	c.li	x3,19
 100027e:	27d71d63          	bne	x14,x29,10004f8 <fail>

01000282 <test_20>:
 1000282:	212120b7          	lui	x1,0x21212
 1000286:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 100028a:	fce00113          	addi	x2,x0,-50
 100028e:	00209733          	sll	x14,x1,x2
 1000292:	48484eb7          	lui	x29,0x48484
 1000296:	41d1                	c.li	x3,20
 1000298:	27d71063          	bne	x14,x29,10004f8 <fail>

0100029c <test_22>:
 100029c:	4085                	c.li	x1,1
 100029e:	411d                	c.li	x2,7
 10002a0:	002090b3          	sll	x1,x1,x2
 10002a4:	08000e93          	addi	x29,x0,128
 10002a8:	41d9                	c.li	x3,22
 10002aa:	25d09763          	bne	x1,x29,10004f8 <fail>

010002ae <test_23>:
 10002ae:	4085                	c.li	x1,1
 10002b0:	4139                	c.li	x2,14
 10002b2:	00209133          	sll	x2,x1,x2
 10002b6:	6e91                	c.lui	x29,0x4
 10002b8:	41dd                	c.li	x3,23
 10002ba:	23d11f63          	bne	x2,x29,10004f8 <fail>

010002be <test_24>:
 10002be:	408d                	c.li	x1,3
 10002c0:	001090b3          	sll	x1,x1,x1
 10002c4:	4ee1                	c.li	x29,24
 10002c6:	41e1                	c.li	x3,24
 10002c8:	23d09863          	bne	x1,x29,10004f8 <fail>

010002cc <test_25>:
 10002cc:	4201                	c.li	x4,0
 10002ce:	4085                	c.li	x1,1
 10002d0:	411d                	c.li	x2,7
 10002d2:	00209733          	sll	x14,x1,x2
 10002d6:	00070313          	addi	x6,x14,0
 10002da:	0205                	c.addi	x4,1
 10002dc:	4289                	c.li	x5,2
 10002de:	fe5218e3          	bne	x4,x5,10002ce <test_25+0x2>
 10002e2:	08000e93          	addi	x29,x0,128
 10002e6:	41e5                	c.li	x3,25
 10002e8:	21d31863          	bne	x6,x29,10004f8 <fail>

010002ec <test_26>:
 10002ec:	4201                	c.li	x4,0
 10002ee:	4085                	c.li	x1,1
 10002f0:	4139                	c.li	x2,14
 10002f2:	00209733          	sll	x14,x1,x2
 10002f6:	0001                	c.addi	x0,0
 10002f8:	00070313          	addi	x6,x14,0
 10002fc:	0205                	c.addi	x4,1
 10002fe:	4289                	c.li	x5,2
 1000300:	fe5217e3          	bne	x4,x5,10002ee <test_26+0x2>
 1000304:	6e91                	c.lui	x29,0x4
 1000306:	41e9                	c.li	x3,26
 1000308:	1fd31863          	bne	x6,x29,10004f8 <fail>

0100030c <test_27>:
 100030c:	4201                	c.li	x4,0
 100030e:	4085                	c.li	x1,1
 1000310:	417d                	c.li	x2,31
 1000312:	00209733          	sll	x14,x1,x2
 1000316:	0001                	c.addi	x0,0
 1000318:	0001                	c.addi	x0,0
 100031a:	00070313          	addi	x6,x14,0
 100031e:	0205                	c.addi	x4,1
 1000320:	4289                	c.li	x5,2
 1000322:	fe5216e3          	bne	x4,x5,100030e <test_27+0x2>
 1000326:	80000eb7          	lui	x29,0x80000
 100032a:	41ed                	c.li	x3,27
 100032c:	1dd31663          	bne	x6,x29,10004f8 <fail>

01000330 <test_28>:
 1000330:	4201                	c.li	x4,0
 1000332:	4085                	c.li	x1,1
 1000334:	411d                	c.li	x2,7
 1000336:	00209733          	sll	x14,x1,x2
 100033a:	0205                	c.addi	x4,1
 100033c:	4289                	c.li	x5,2
 100033e:	fe521ae3          	bne	x4,x5,1000332 <test_28+0x2>
 1000342:	08000e93          	addi	x29,x0,128
 1000346:	41f1                	c.li	x3,28
 1000348:	1bd71863          	bne	x14,x29,10004f8 <fail>

0100034c <test_29>:
 100034c:	4201                	c.li	x4,0
 100034e:	4085                	c.li	x1,1
 1000350:	4139                	c.li	x2,14
 1000352:	0001                	c.addi	x0,0
 1000354:	00209733          	sll	x14,x1,x2
 1000358:	0205                	c.addi	x4,1
 100035a:	4289                	c.li	x5,2
 100035c:	fe5219e3          	bne	x4,x5,100034e <test_29+0x2>
 1000360:	6e91                	c.lui	x29,0x4
 1000362:	41f5                	c.li	x3,29
 1000364:	19d71a63          	bne	x14,x29,10004f8 <fail>

01000368 <test_30>:
 1000368:	4201                	c.li	x4,0
 100036a:	4085                	c.li	x1,1
 100036c:	417d                	c.li	x2,31
 100036e:	0001                	c.addi	x0,0
 1000370:	0001                	c.addi	x0,0
 1000372:	00209733          	sll	x14,x1,x2
 1000376:	0205                	c.addi	x4,1
 1000378:	4289                	c.li	x5,2
 100037a:	fe5218e3          	bne	x4,x5,100036a <test_30+0x2>
 100037e:	80000eb7          	lui	x29,0x80000
 1000382:	41f9                	c.li	x3,30
 1000384:	17d71a63          	bne	x14,x29,10004f8 <fail>

01000388 <test_31>:
 1000388:	4201                	c.li	x4,0
 100038a:	4085                	c.li	x1,1
 100038c:	0001                	c.addi	x0,0
 100038e:	411d                	c.li	x2,7
 1000390:	00209733          	sll	x14,x1,x2
 1000394:	0205                	c.addi	x4,1
 1000396:	4289                	c.li	x5,2
 1000398:	fe5219e3          	bne	x4,x5,100038a <test_31+0x2>
 100039c:	08000e93          	addi	x29,x0,128
 10003a0:	41fd                	c.li	x3,31
 10003a2:	15d71b63          	bne	x14,x29,10004f8 <fail>

010003a6 <test_32>:
 10003a6:	4201                	c.li	x4,0
 10003a8:	4085                	c.li	x1,1
 10003aa:	0001                	c.addi	x0,0
 10003ac:	4139                	c.li	x2,14
 10003ae:	0001                	c.addi	x0,0
 10003b0:	00209733          	sll	x14,x1,x2
 10003b4:	0205                	c.addi	x4,1
 10003b6:	4289                	c.li	x5,2
 10003b8:	fe5218e3          	bne	x4,x5,10003a8 <test_32+0x2>
 10003bc:	6e91                	c.lui	x29,0x4
 10003be:	02000193          	addi	x3,x0,32
 10003c2:	13d71b63          	bne	x14,x29,10004f8 <fail>

010003c6 <test_33>:
 10003c6:	4201                	c.li	x4,0
 10003c8:	4085                	c.li	x1,1
 10003ca:	0001                	c.addi	x0,0
 10003cc:	0001                	c.addi	x0,0
 10003ce:	417d                	c.li	x2,31
 10003d0:	00209733          	sll	x14,x1,x2
 10003d4:	0205                	c.addi	x4,1
 10003d6:	4289                	c.li	x5,2
 10003d8:	fe5218e3          	bne	x4,x5,10003c8 <test_33+0x2>
 10003dc:	80000eb7          	lui	x29,0x80000
 10003e0:	02100193          	addi	x3,x0,33
 10003e4:	11d71a63          	bne	x14,x29,10004f8 <fail>

010003e8 <test_34>:
 10003e8:	4201                	c.li	x4,0
 10003ea:	411d                	c.li	x2,7
 10003ec:	4085                	c.li	x1,1
 10003ee:	00209733          	sll	x14,x1,x2
 10003f2:	0205                	c.addi	x4,1
 10003f4:	4289                	c.li	x5,2
 10003f6:	fe521ae3          	bne	x4,x5,10003ea <test_34+0x2>
 10003fa:	08000e93          	addi	x29,x0,128
 10003fe:	02200193          	addi	x3,x0,34
 1000402:	0fd71b63          	bne	x14,x29,10004f8 <fail>

01000406 <test_35>:
 1000406:	4201                	c.li	x4,0
 1000408:	4139                	c.li	x2,14
 100040a:	4085                	c.li	x1,1
 100040c:	0001                	c.addi	x0,0
 100040e:	00209733          	sll	x14,x1,x2
 1000412:	0205                	c.addi	x4,1
 1000414:	4289                	c.li	x5,2
 1000416:	fe5219e3          	bne	x4,x5,1000408 <test_35+0x2>
 100041a:	6e91                	c.lui	x29,0x4
 100041c:	02300193          	addi	x3,x0,35
 1000420:	0dd71c63          	bne	x14,x29,10004f8 <fail>

01000424 <test_36>:
 1000424:	4201                	c.li	x4,0
 1000426:	417d                	c.li	x2,31
 1000428:	4085                	c.li	x1,1
 100042a:	0001                	c.addi	x0,0
 100042c:	0001                	c.addi	x0,0
 100042e:	00209733          	sll	x14,x1,x2
 1000432:	0205                	c.addi	x4,1
 1000434:	4289                	c.li	x5,2
 1000436:	fe5218e3          	bne	x4,x5,1000426 <test_36+0x2>
 100043a:	80000eb7          	lui	x29,0x80000
 100043e:	02400193          	addi	x3,x0,36
 1000442:	0bd71b63          	bne	x14,x29,10004f8 <fail>

01000446 <test_37>:
 1000446:	4201                	c.li	x4,0
 1000448:	411d                	c.li	x2,7
 100044a:	0001                	c.addi	x0,0
 100044c:	4085                	c.li	x1,1
 100044e:	00209733          	sll	x14,x1,x2
 1000452:	0205                	c.addi	x4,1
 1000454:	4289                	c.li	x5,2
 1000456:	fe5219e3          	bne	x4,x5,1000448 <test_37+0x2>
 100045a:	08000e93          	addi	x29,x0,128
 100045e:	02500193          	addi	x3,x0,37
 1000462:	09d71b63          	bne	x14,x29,10004f8 <fail>

01000466 <test_38>:
 1000466:	4201                	c.li	x4,0
 1000468:	4139                	c.li	x2,14
 100046a:	0001                	c.addi	x0,0
 100046c:	4085                	c.li	x1,1
 100046e:	0001                	c.addi	x0,0
 1000470:	00209733          	sll	x14,x1,x2
 1000474:	0205                	c.addi	x4,1
 1000476:	4289                	c.li	x5,2
 1000478:	fe5218e3          	bne	x4,x5,1000468 <test_38+0x2>
 100047c:	6e91                	c.lui	x29,0x4
 100047e:	02600193          	addi	x3,x0,38
 1000482:	07d71b63          	bne	x14,x29,10004f8 <fail>

01000486 <test_39>:
 1000486:	4201                	c.li	x4,0
 1000488:	417d                	c.li	x2,31
 100048a:	0001                	c.addi	x0,0
 100048c:	0001                	c.addi	x0,0
 100048e:	4085                	c.li	x1,1
 1000490:	00209733          	sll	x14,x1,x2
 1000494:	0205                	c.addi	x4,1
 1000496:	4289                	c.li	x5,2
 1000498:	fe5218e3          	bne	x4,x5,1000488 <test_39+0x2>
 100049c:	80000eb7          	lui	x29,0x80000
 10004a0:	02700193          	addi	x3,x0,39
 10004a4:	05d71a63          	bne	x14,x29,10004f8 <fail>

010004a8 <test_40>:
 10004a8:	40bd                	c.li	x1,15
 10004aa:	00101133          	sll	x2,x0,x1
 10004ae:	4e81                	c.li	x29,0
 10004b0:	02800193          	addi	x3,x0,40
 10004b4:	05d11263          	bne	x2,x29,10004f8 <fail>

010004b8 <test_41>:
 10004b8:	02000093          	addi	x1,x0,32
 10004bc:	00009133          	sll	x2,x1,x0
 10004c0:	02000e93          	addi	x29,x0,32
 10004c4:	02900193          	addi	x3,x0,41
 10004c8:	03d11863          	bne	x2,x29,10004f8 <fail>

010004cc <test_42>:
 10004cc:	000010b3          	sll	x1,x0,x0
 10004d0:	4e81                	c.li	x29,0
 10004d2:	02a00193          	addi	x3,x0,42
 10004d6:	03d09163          	bne	x1,x29,10004f8 <fail>

010004da <test_43>:
 10004da:	40000093          	addi	x1,x0,1024
 10004de:	00001137          	lui	x2,0x1
 10004e2:	80010113          	addi	x2,x2,-2048 # 800 <_start-0xfff800>
 10004e6:	00209033          	sll	x0,x1,x2
 10004ea:	4e81                	c.li	x29,0
 10004ec:	02b00193          	addi	x3,x0,43
 10004f0:	01d01463          	bne	x0,x29,10004f8 <fail>
 10004f4:	00301b63          	bne	x0,x3,100050a <pass>

010004f8 <fail>:
 10004f8:	0ff0000f          	fence	iorw,iorw
 10004fc:	00018063          	beq	x3,x0,10004fc <fail+0x4>
 1000500:	0186                	c.slli	x3,0x1
 1000502:	0011e193          	ori	x3,x3,1
 1000506:	00000073          	ecall

0100050a <pass>:
 100050a:	0ff0000f          	fence	iorw,iorw
 100050e:	4185                	c.li	x3,1
 1000510:	00000073          	ecall
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

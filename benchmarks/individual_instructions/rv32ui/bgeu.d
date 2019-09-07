
rv32ui/bgeu.elf:     file format elf32-littleriscv


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
 10000f2:	0020f663          	bgeu	x1,x2,10000fe <test_2+0x12>
 10000f6:	28301863          	bne	x0,x3,1000386 <fail>
 10000fa:	00301663          	bne	x0,x3,1000106 <test_3>
 10000fe:	fe20fee3          	bgeu	x1,x2,10000fa <test_2+0xe>
 1000102:	28301263          	bne	x0,x3,1000386 <fail>

01000106 <test_3>:
 1000106:	418d                	c.li	x3,3
 1000108:	4085                	c.li	x1,1
 100010a:	4105                	c.li	x2,1
 100010c:	0020f663          	bgeu	x1,x2,1000118 <test_3+0x12>
 1000110:	26301b63          	bne	x0,x3,1000386 <fail>
 1000114:	00301663          	bne	x0,x3,1000120 <test_4>
 1000118:	fe20fee3          	bgeu	x1,x2,1000114 <test_3+0xe>
 100011c:	26301563          	bne	x0,x3,1000386 <fail>

01000120 <test_4>:
 1000120:	4191                	c.li	x3,4
 1000122:	fff00093          	addi	x1,x0,-1
 1000126:	fff00113          	addi	x2,x0,-1
 100012a:	0020f663          	bgeu	x1,x2,1000136 <test_4+0x16>
 100012e:	24301c63          	bne	x0,x3,1000386 <fail>
 1000132:	00301663          	bne	x0,x3,100013e <test_5>
 1000136:	fe20fee3          	bgeu	x1,x2,1000132 <test_4+0x12>
 100013a:	24301663          	bne	x0,x3,1000386 <fail>

0100013e <test_5>:
 100013e:	4195                	c.li	x3,5
 1000140:	4085                	c.li	x1,1
 1000142:	4101                	c.li	x2,0
 1000144:	0020f663          	bgeu	x1,x2,1000150 <test_5+0x12>
 1000148:	22301f63          	bne	x0,x3,1000386 <fail>
 100014c:	00301663          	bne	x0,x3,1000158 <test_6>
 1000150:	fe20fee3          	bgeu	x1,x2,100014c <test_5+0xe>
 1000154:	22301963          	bne	x0,x3,1000386 <fail>

01000158 <test_6>:
 1000158:	4199                	c.li	x3,6
 100015a:	fff00093          	addi	x1,x0,-1
 100015e:	ffe00113          	addi	x2,x0,-2
 1000162:	0020f663          	bgeu	x1,x2,100016e <test_6+0x16>
 1000166:	22301063          	bne	x0,x3,1000386 <fail>
 100016a:	00301663          	bne	x0,x3,1000176 <test_7>
 100016e:	fe20fee3          	bgeu	x1,x2,100016a <test_6+0x12>
 1000172:	20301a63          	bne	x0,x3,1000386 <fail>

01000176 <test_7>:
 1000176:	419d                	c.li	x3,7
 1000178:	fff00093          	addi	x1,x0,-1
 100017c:	4101                	c.li	x2,0
 100017e:	0020f663          	bgeu	x1,x2,100018a <test_7+0x14>
 1000182:	20301263          	bne	x0,x3,1000386 <fail>
 1000186:	00301663          	bne	x0,x3,1000192 <test_8>
 100018a:	fe20fee3          	bgeu	x1,x2,1000186 <test_7+0x10>
 100018e:	1e301c63          	bne	x0,x3,1000386 <fail>

01000192 <test_8>:
 1000192:	41a1                	c.li	x3,8
 1000194:	4081                	c.li	x1,0
 1000196:	4105                	c.li	x2,1
 1000198:	0020f463          	bgeu	x1,x2,10001a0 <test_8+0xe>
 100019c:	00301463          	bne	x0,x3,10001a4 <test_8+0x12>
 10001a0:	1e301363          	bne	x0,x3,1000386 <fail>
 10001a4:	fe20fee3          	bgeu	x1,x2,10001a0 <test_8+0xe>

010001a8 <test_9>:
 10001a8:	41a5                	c.li	x3,9
 10001aa:	ffe00093          	addi	x1,x0,-2
 10001ae:	fff00113          	addi	x2,x0,-1
 10001b2:	0020f463          	bgeu	x1,x2,10001ba <test_9+0x12>
 10001b6:	00301463          	bne	x0,x3,10001be <test_9+0x16>
 10001ba:	1c301663          	bne	x0,x3,1000386 <fail>
 10001be:	fe20fee3          	bgeu	x1,x2,10001ba <test_9+0x12>

010001c2 <test_10>:
 10001c2:	41a9                	c.li	x3,10
 10001c4:	4081                	c.li	x1,0
 10001c6:	fff00113          	addi	x2,x0,-1
 10001ca:	0020f463          	bgeu	x1,x2,10001d2 <test_10+0x10>
 10001ce:	00301463          	bne	x0,x3,10001d6 <test_10+0x14>
 10001d2:	1a301a63          	bne	x0,x3,1000386 <fail>
 10001d6:	fe20fee3          	bgeu	x1,x2,10001d2 <test_10+0x10>

010001da <test_11>:
 10001da:	41ad                	c.li	x3,11
 10001dc:	800000b7          	lui	x1,0x80000
 10001e0:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 10001e4:	80000137          	lui	x2,0x80000
 10001e8:	0020f463          	bgeu	x1,x2,10001f0 <test_11+0x16>
 10001ec:	00301463          	bne	x0,x3,10001f4 <test_11+0x1a>
 10001f0:	18301b63          	bne	x0,x3,1000386 <fail>
 10001f4:	fe20fee3          	bgeu	x1,x2,10001f0 <test_11+0x16>

010001f8 <test_12>:
 10001f8:	41b1                	c.li	x3,12
 10001fa:	4201                	c.li	x4,0
 10001fc:	f00000b7          	lui	x1,0xf0000
 1000200:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0xeeffdfff>
 1000204:	f0000137          	lui	x2,0xf0000
 1000208:	1620ff63          	bgeu	x1,x2,1000386 <fail>
 100020c:	0205                	c.addi	x4,1
 100020e:	4289                	c.li	x5,2
 1000210:	fe5216e3          	bne	x4,x5,10001fc <test_12+0x4>

01000214 <test_13>:
 1000214:	41b5                	c.li	x3,13
 1000216:	4201                	c.li	x4,0
 1000218:	f00000b7          	lui	x1,0xf0000
 100021c:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0xeeffdfff>
 1000220:	f0000137          	lui	x2,0xf0000
 1000224:	0001                	c.addi	x0,0
 1000226:	1620f063          	bgeu	x1,x2,1000386 <fail>
 100022a:	0205                	c.addi	x4,1
 100022c:	4289                	c.li	x5,2
 100022e:	fe5215e3          	bne	x4,x5,1000218 <test_13+0x4>

01000232 <test_14>:
 1000232:	41b9                	c.li	x3,14
 1000234:	4201                	c.li	x4,0
 1000236:	f00000b7          	lui	x1,0xf0000
 100023a:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0xeeffdfff>
 100023e:	f0000137          	lui	x2,0xf0000
 1000242:	0001                	c.addi	x0,0
 1000244:	0001                	c.addi	x0,0
 1000246:	1420f063          	bgeu	x1,x2,1000386 <fail>
 100024a:	0205                	c.addi	x4,1
 100024c:	4289                	c.li	x5,2
 100024e:	fe5214e3          	bne	x4,x5,1000236 <test_14+0x4>

01000252 <test_15>:
 1000252:	41bd                	c.li	x3,15
 1000254:	4201                	c.li	x4,0
 1000256:	f00000b7          	lui	x1,0xf0000
 100025a:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0xeeffdfff>
 100025e:	0001                	c.addi	x0,0
 1000260:	f0000137          	lui	x2,0xf0000
 1000264:	1220f163          	bgeu	x1,x2,1000386 <fail>
 1000268:	0205                	c.addi	x4,1
 100026a:	4289                	c.li	x5,2
 100026c:	fe5215e3          	bne	x4,x5,1000256 <test_15+0x4>

01000270 <test_16>:
 1000270:	41c1                	c.li	x3,16
 1000272:	4201                	c.li	x4,0
 1000274:	f00000b7          	lui	x1,0xf0000
 1000278:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0xeeffdfff>
 100027c:	0001                	c.addi	x0,0
 100027e:	f0000137          	lui	x2,0xf0000
 1000282:	0001                	c.addi	x0,0
 1000284:	1020f163          	bgeu	x1,x2,1000386 <fail>
 1000288:	0205                	c.addi	x4,1
 100028a:	4289                	c.li	x5,2
 100028c:	fe5214e3          	bne	x4,x5,1000274 <test_16+0x4>

01000290 <test_17>:
 1000290:	41c5                	c.li	x3,17
 1000292:	4201                	c.li	x4,0
 1000294:	f00000b7          	lui	x1,0xf0000
 1000298:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0xeeffdfff>
 100029c:	0001                	c.addi	x0,0
 100029e:	0001                	c.addi	x0,0
 10002a0:	f0000137          	lui	x2,0xf0000
 10002a4:	0e20f163          	bgeu	x1,x2,1000386 <fail>
 10002a8:	0205                	c.addi	x4,1
 10002aa:	4289                	c.li	x5,2
 10002ac:	fe5214e3          	bne	x4,x5,1000294 <test_17+0x4>

010002b0 <test_18>:
 10002b0:	41c9                	c.li	x3,18
 10002b2:	4201                	c.li	x4,0
 10002b4:	f00000b7          	lui	x1,0xf0000
 10002b8:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0xeeffdfff>
 10002bc:	f0000137          	lui	x2,0xf0000
 10002c0:	0c20f363          	bgeu	x1,x2,1000386 <fail>
 10002c4:	0205                	c.addi	x4,1
 10002c6:	4289                	c.li	x5,2
 10002c8:	fe5216e3          	bne	x4,x5,10002b4 <test_18+0x4>

010002cc <test_19>:
 10002cc:	41cd                	c.li	x3,19
 10002ce:	4201                	c.li	x4,0
 10002d0:	f00000b7          	lui	x1,0xf0000
 10002d4:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0xeeffdfff>
 10002d8:	f0000137          	lui	x2,0xf0000
 10002dc:	0001                	c.addi	x0,0
 10002de:	0a20f463          	bgeu	x1,x2,1000386 <fail>
 10002e2:	0205                	c.addi	x4,1
 10002e4:	4289                	c.li	x5,2
 10002e6:	fe5215e3          	bne	x4,x5,10002d0 <test_19+0x4>

010002ea <test_20>:
 10002ea:	41d1                	c.li	x3,20
 10002ec:	4201                	c.li	x4,0
 10002ee:	f00000b7          	lui	x1,0xf0000
 10002f2:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0xeeffdfff>
 10002f6:	f0000137          	lui	x2,0xf0000
 10002fa:	0001                	c.addi	x0,0
 10002fc:	0001                	c.addi	x0,0
 10002fe:	0820f463          	bgeu	x1,x2,1000386 <fail>
 1000302:	0205                	c.addi	x4,1
 1000304:	4289                	c.li	x5,2
 1000306:	fe5214e3          	bne	x4,x5,10002ee <test_20+0x4>

0100030a <test_21>:
 100030a:	41d5                	c.li	x3,21
 100030c:	4201                	c.li	x4,0
 100030e:	f00000b7          	lui	x1,0xf0000
 1000312:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0xeeffdfff>
 1000316:	0001                	c.addi	x0,0
 1000318:	f0000137          	lui	x2,0xf0000
 100031c:	0620f563          	bgeu	x1,x2,1000386 <fail>
 1000320:	0205                	c.addi	x4,1
 1000322:	4289                	c.li	x5,2
 1000324:	fe5215e3          	bne	x4,x5,100030e <test_21+0x4>

01000328 <test_22>:
 1000328:	41d9                	c.li	x3,22
 100032a:	4201                	c.li	x4,0
 100032c:	f00000b7          	lui	x1,0xf0000
 1000330:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0xeeffdfff>
 1000334:	0001                	c.addi	x0,0
 1000336:	f0000137          	lui	x2,0xf0000
 100033a:	0001                	c.addi	x0,0
 100033c:	0420f563          	bgeu	x1,x2,1000386 <fail>
 1000340:	0205                	c.addi	x4,1
 1000342:	4289                	c.li	x5,2
 1000344:	fe5214e3          	bne	x4,x5,100032c <test_22+0x4>

01000348 <test_23>:
 1000348:	41dd                	c.li	x3,23
 100034a:	4201                	c.li	x4,0
 100034c:	f00000b7          	lui	x1,0xf0000
 1000350:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0xeeffdfff>
 1000354:	0001                	c.addi	x0,0
 1000356:	0001                	c.addi	x0,0
 1000358:	f0000137          	lui	x2,0xf0000
 100035c:	0220f563          	bgeu	x1,x2,1000386 <fail>
 1000360:	0205                	c.addi	x4,1
 1000362:	4289                	c.li	x5,2
 1000364:	fe5214e3          	bne	x4,x5,100034c <test_23+0x4>

01000368 <test_24>:
 1000368:	4085                	c.li	x1,1
 100036a:	0000f663          	bgeu	x1,x0,1000376 <test_24+0xe>
 100036e:	0085                	c.addi	x1,1
 1000370:	0085                	c.addi	x1,1
 1000372:	0085                	c.addi	x1,1
 1000374:	0085                	c.addi	x1,1
 1000376:	0085                	c.addi	x1,1
 1000378:	0085                	c.addi	x1,1
 100037a:	4e8d                	c.li	x29,3
 100037c:	41e1                	c.li	x3,24
 100037e:	01d09463          	bne	x1,x29,1000386 <fail>
 1000382:	00301b63          	bne	x0,x3,1000398 <pass>

01000386 <fail>:
 1000386:	0ff0000f          	fence	iorw,iorw
 100038a:	00018063          	beq	x3,x0,100038a <fail+0x4>
 100038e:	0186                	c.slli	x3,0x1
 1000390:	0011e193          	ori	x3,x3,1
 1000394:	00000073          	ecall

01000398 <pass>:
 1000398:	0ff0000f          	fence	iorw,iorw
 100039c:	4185                	c.li	x3,1
 100039e:	00000073          	ecall
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

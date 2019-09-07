
rv32ui/bltu.elf:     file format elf32-littleriscv


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
 10000f2:	0020e663          	bltu	x1,x2,10000fe <test_2+0x12>
 10000f6:	22301f63          	bne	x0,x3,1000334 <fail>
 10000fa:	00301663          	bne	x0,x3,1000106 <test_3>
 10000fe:	fe20eee3          	bltu	x1,x2,10000fa <test_2+0xe>
 1000102:	22301963          	bne	x0,x3,1000334 <fail>

01000106 <test_3>:
 1000106:	418d                	c.li	x3,3
 1000108:	ffe00093          	addi	x1,x0,-2
 100010c:	fff00113          	addi	x2,x0,-1
 1000110:	0020e663          	bltu	x1,x2,100011c <test_3+0x16>
 1000114:	22301063          	bne	x0,x3,1000334 <fail>
 1000118:	00301663          	bne	x0,x3,1000124 <test_4>
 100011c:	fe20eee3          	bltu	x1,x2,1000118 <test_3+0x12>
 1000120:	20301a63          	bne	x0,x3,1000334 <fail>

01000124 <test_4>:
 1000124:	4191                	c.li	x3,4
 1000126:	4081                	c.li	x1,0
 1000128:	fff00113          	addi	x2,x0,-1
 100012c:	0020e663          	bltu	x1,x2,1000138 <test_4+0x14>
 1000130:	20301263          	bne	x0,x3,1000334 <fail>
 1000134:	00301663          	bne	x0,x3,1000140 <test_5>
 1000138:	fe20eee3          	bltu	x1,x2,1000134 <test_4+0x10>
 100013c:	1e301c63          	bne	x0,x3,1000334 <fail>

01000140 <test_5>:
 1000140:	4195                	c.li	x3,5
 1000142:	4085                	c.li	x1,1
 1000144:	4101                	c.li	x2,0
 1000146:	0020e463          	bltu	x1,x2,100014e <test_5+0xe>
 100014a:	00301463          	bne	x0,x3,1000152 <test_5+0x12>
 100014e:	1e301363          	bne	x0,x3,1000334 <fail>
 1000152:	fe20eee3          	bltu	x1,x2,100014e <test_5+0xe>

01000156 <test_6>:
 1000156:	4199                	c.li	x3,6
 1000158:	fff00093          	addi	x1,x0,-1
 100015c:	ffe00113          	addi	x2,x0,-2
 1000160:	0020e463          	bltu	x1,x2,1000168 <test_6+0x12>
 1000164:	00301463          	bne	x0,x3,100016c <test_6+0x16>
 1000168:	1c301663          	bne	x0,x3,1000334 <fail>
 100016c:	fe20eee3          	bltu	x1,x2,1000168 <test_6+0x12>

01000170 <test_7>:
 1000170:	419d                	c.li	x3,7
 1000172:	fff00093          	addi	x1,x0,-1
 1000176:	4101                	c.li	x2,0
 1000178:	0020e463          	bltu	x1,x2,1000180 <test_7+0x10>
 100017c:	00301463          	bne	x0,x3,1000184 <test_7+0x14>
 1000180:	1a301a63          	bne	x0,x3,1000334 <fail>
 1000184:	fe20eee3          	bltu	x1,x2,1000180 <test_7+0x10>

01000188 <test_8>:
 1000188:	41a1                	c.li	x3,8
 100018a:	800000b7          	lui	x1,0x80000
 100018e:	80000137          	lui	x2,0x80000
 1000192:	fff10113          	addi	x2,x2,-1 # 7fffffff <_end+0x7effdfff>
 1000196:	0020e463          	bltu	x1,x2,100019e <test_8+0x16>
 100019a:	00301463          	bne	x0,x3,10001a2 <test_8+0x1a>
 100019e:	18301b63          	bne	x0,x3,1000334 <fail>
 10001a2:	fe20eee3          	bltu	x1,x2,100019e <test_8+0x16>

010001a6 <test_9>:
 10001a6:	41a5                	c.li	x3,9
 10001a8:	4201                	c.li	x4,0
 10001aa:	f00000b7          	lui	x1,0xf0000
 10001ae:	f0000137          	lui	x2,0xf0000
 10001b2:	fff10113          	addi	x2,x2,-1 # efffffff <_end+0xeeffdfff>
 10001b6:	1620ef63          	bltu	x1,x2,1000334 <fail>
 10001ba:	0205                	c.addi	x4,1
 10001bc:	4289                	c.li	x5,2
 10001be:	fe5216e3          	bne	x4,x5,10001aa <test_9+0x4>

010001c2 <test_10>:
 10001c2:	41a9                	c.li	x3,10
 10001c4:	4201                	c.li	x4,0
 10001c6:	f00000b7          	lui	x1,0xf0000
 10001ca:	f0000137          	lui	x2,0xf0000
 10001ce:	fff10113          	addi	x2,x2,-1 # efffffff <_end+0xeeffdfff>
 10001d2:	0001                	c.addi	x0,0
 10001d4:	1620e063          	bltu	x1,x2,1000334 <fail>
 10001d8:	0205                	c.addi	x4,1
 10001da:	4289                	c.li	x5,2
 10001dc:	fe5215e3          	bne	x4,x5,10001c6 <test_10+0x4>

010001e0 <test_11>:
 10001e0:	41ad                	c.li	x3,11
 10001e2:	4201                	c.li	x4,0
 10001e4:	f00000b7          	lui	x1,0xf0000
 10001e8:	f0000137          	lui	x2,0xf0000
 10001ec:	fff10113          	addi	x2,x2,-1 # efffffff <_end+0xeeffdfff>
 10001f0:	0001                	c.addi	x0,0
 10001f2:	0001                	c.addi	x0,0
 10001f4:	1420e063          	bltu	x1,x2,1000334 <fail>
 10001f8:	0205                	c.addi	x4,1
 10001fa:	4289                	c.li	x5,2
 10001fc:	fe5214e3          	bne	x4,x5,10001e4 <test_11+0x4>

01000200 <test_12>:
 1000200:	41b1                	c.li	x3,12
 1000202:	4201                	c.li	x4,0
 1000204:	f00000b7          	lui	x1,0xf0000
 1000208:	0001                	c.addi	x0,0
 100020a:	f0000137          	lui	x2,0xf0000
 100020e:	fff10113          	addi	x2,x2,-1 # efffffff <_end+0xeeffdfff>
 1000212:	1220e163          	bltu	x1,x2,1000334 <fail>
 1000216:	0205                	c.addi	x4,1
 1000218:	4289                	c.li	x5,2
 100021a:	fe5215e3          	bne	x4,x5,1000204 <test_12+0x4>

0100021e <test_13>:
 100021e:	41b5                	c.li	x3,13
 1000220:	4201                	c.li	x4,0
 1000222:	f00000b7          	lui	x1,0xf0000
 1000226:	0001                	c.addi	x0,0
 1000228:	f0000137          	lui	x2,0xf0000
 100022c:	fff10113          	addi	x2,x2,-1 # efffffff <_end+0xeeffdfff>
 1000230:	0001                	c.addi	x0,0
 1000232:	1020e163          	bltu	x1,x2,1000334 <fail>
 1000236:	0205                	c.addi	x4,1
 1000238:	4289                	c.li	x5,2
 100023a:	fe5214e3          	bne	x4,x5,1000222 <test_13+0x4>

0100023e <test_14>:
 100023e:	41b9                	c.li	x3,14
 1000240:	4201                	c.li	x4,0
 1000242:	f00000b7          	lui	x1,0xf0000
 1000246:	0001                	c.addi	x0,0
 1000248:	0001                	c.addi	x0,0
 100024a:	f0000137          	lui	x2,0xf0000
 100024e:	fff10113          	addi	x2,x2,-1 # efffffff <_end+0xeeffdfff>
 1000252:	0e20e163          	bltu	x1,x2,1000334 <fail>
 1000256:	0205                	c.addi	x4,1
 1000258:	4289                	c.li	x5,2
 100025a:	fe5214e3          	bne	x4,x5,1000242 <test_14+0x4>

0100025e <test_15>:
 100025e:	41bd                	c.li	x3,15
 1000260:	4201                	c.li	x4,0
 1000262:	f00000b7          	lui	x1,0xf0000
 1000266:	f0000137          	lui	x2,0xf0000
 100026a:	fff10113          	addi	x2,x2,-1 # efffffff <_end+0xeeffdfff>
 100026e:	0c20e363          	bltu	x1,x2,1000334 <fail>
 1000272:	0205                	c.addi	x4,1
 1000274:	4289                	c.li	x5,2
 1000276:	fe5216e3          	bne	x4,x5,1000262 <test_15+0x4>

0100027a <test_16>:
 100027a:	41c1                	c.li	x3,16
 100027c:	4201                	c.li	x4,0
 100027e:	f00000b7          	lui	x1,0xf0000
 1000282:	f0000137          	lui	x2,0xf0000
 1000286:	fff10113          	addi	x2,x2,-1 # efffffff <_end+0xeeffdfff>
 100028a:	0001                	c.addi	x0,0
 100028c:	0a20e463          	bltu	x1,x2,1000334 <fail>
 1000290:	0205                	c.addi	x4,1
 1000292:	4289                	c.li	x5,2
 1000294:	fe5215e3          	bne	x4,x5,100027e <test_16+0x4>

01000298 <test_17>:
 1000298:	41c5                	c.li	x3,17
 100029a:	4201                	c.li	x4,0
 100029c:	f00000b7          	lui	x1,0xf0000
 10002a0:	f0000137          	lui	x2,0xf0000
 10002a4:	fff10113          	addi	x2,x2,-1 # efffffff <_end+0xeeffdfff>
 10002a8:	0001                	c.addi	x0,0
 10002aa:	0001                	c.addi	x0,0
 10002ac:	0820e463          	bltu	x1,x2,1000334 <fail>
 10002b0:	0205                	c.addi	x4,1
 10002b2:	4289                	c.li	x5,2
 10002b4:	fe5214e3          	bne	x4,x5,100029c <test_17+0x4>

010002b8 <test_18>:
 10002b8:	41c9                	c.li	x3,18
 10002ba:	4201                	c.li	x4,0
 10002bc:	f00000b7          	lui	x1,0xf0000
 10002c0:	0001                	c.addi	x0,0
 10002c2:	f0000137          	lui	x2,0xf0000
 10002c6:	fff10113          	addi	x2,x2,-1 # efffffff <_end+0xeeffdfff>
 10002ca:	0620e563          	bltu	x1,x2,1000334 <fail>
 10002ce:	0205                	c.addi	x4,1
 10002d0:	4289                	c.li	x5,2
 10002d2:	fe5215e3          	bne	x4,x5,10002bc <test_18+0x4>

010002d6 <test_19>:
 10002d6:	41cd                	c.li	x3,19
 10002d8:	4201                	c.li	x4,0
 10002da:	f00000b7          	lui	x1,0xf0000
 10002de:	0001                	c.addi	x0,0
 10002e0:	f0000137          	lui	x2,0xf0000
 10002e4:	fff10113          	addi	x2,x2,-1 # efffffff <_end+0xeeffdfff>
 10002e8:	0001                	c.addi	x0,0
 10002ea:	0420e563          	bltu	x1,x2,1000334 <fail>
 10002ee:	0205                	c.addi	x4,1
 10002f0:	4289                	c.li	x5,2
 10002f2:	fe5214e3          	bne	x4,x5,10002da <test_19+0x4>

010002f6 <test_20>:
 10002f6:	41d1                	c.li	x3,20
 10002f8:	4201                	c.li	x4,0
 10002fa:	f00000b7          	lui	x1,0xf0000
 10002fe:	0001                	c.addi	x0,0
 1000300:	0001                	c.addi	x0,0
 1000302:	f0000137          	lui	x2,0xf0000
 1000306:	fff10113          	addi	x2,x2,-1 # efffffff <_end+0xeeffdfff>
 100030a:	0220e563          	bltu	x1,x2,1000334 <fail>
 100030e:	0205                	c.addi	x4,1
 1000310:	4289                	c.li	x5,2
 1000312:	fe5214e3          	bne	x4,x5,10002fa <test_20+0x4>

01000316 <test_21>:
 1000316:	4085                	c.li	x1,1
 1000318:	00106663          	bltu	x0,x1,1000324 <test_21+0xe>
 100031c:	0085                	c.addi	x1,1
 100031e:	0085                	c.addi	x1,1
 1000320:	0085                	c.addi	x1,1
 1000322:	0085                	c.addi	x1,1
 1000324:	0085                	c.addi	x1,1
 1000326:	0085                	c.addi	x1,1
 1000328:	4e8d                	c.li	x29,3
 100032a:	41d5                	c.li	x3,21
 100032c:	01d09463          	bne	x1,x29,1000334 <fail>
 1000330:	00301b63          	bne	x0,x3,1000346 <pass>

01000334 <fail>:
 1000334:	0ff0000f          	fence	iorw,iorw
 1000338:	00018063          	beq	x3,x0,1000338 <fail+0x4>
 100033c:	0186                	c.slli	x3,0x1
 100033e:	0011e193          	ori	x3,x3,1
 1000342:	00000073          	ecall

01000346 <pass>:
 1000346:	0ff0000f          	fence	iorw,iorw
 100034a:	4185                	c.li	x3,1
 100034c:	00000073          	ecall
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

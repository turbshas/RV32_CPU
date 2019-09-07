
rv32ui/lhu.elf:     file format elf32-littleriscv


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
 10000f4:	0000d703          	lhu	x14,0(x1)
 10000f8:	0ff00e93          	addi	x29,x0,255
 10000fc:	4189                	c.li	x3,2
 10000fe:	21d71663          	bne	x14,x29,100030a <fail>

01000102 <test_3>:
 1000102:	00002097          	auipc	x1,0x2
 1000106:	efe08093          	addi	x1,x1,-258 # 1002000 <begin_signature>
 100010a:	0020d703          	lhu	x14,2(x1)
 100010e:	00010eb7          	lui	x29,0x10
 1000112:	f00e8e93          	addi	x29,x29,-256 # ff00 <_start-0xff0100>
 1000116:	418d                	c.li	x3,3
 1000118:	1fd71963          	bne	x14,x29,100030a <fail>

0100011c <test_4>:
 100011c:	00002097          	auipc	x1,0x2
 1000120:	ee408093          	addi	x1,x1,-284 # 1002000 <begin_signature>
 1000124:	0040d703          	lhu	x14,4(x1)
 1000128:	00001eb7          	lui	x29,0x1
 100012c:	ff0e8e93          	addi	x29,x29,-16 # ff0 <_start-0xfff010>
 1000130:	4191                	c.li	x3,4
 1000132:	1dd71c63          	bne	x14,x29,100030a <fail>

01000136 <test_5>:
 1000136:	00002097          	auipc	x1,0x2
 100013a:	eca08093          	addi	x1,x1,-310 # 1002000 <begin_signature>
 100013e:	0060d703          	lhu	x14,6(x1)
 1000142:	0000feb7          	lui	x29,0xf
 1000146:	00fe8e93          	addi	x29,x29,15 # f00f <_start-0xff0ff1>
 100014a:	4195                	c.li	x3,5
 100014c:	1bd71f63          	bne	x14,x29,100030a <fail>

01000150 <test_6>:
 1000150:	00002097          	auipc	x1,0x2
 1000154:	eb608093          	addi	x1,x1,-330 # 1002006 <tdat4>
 1000158:	ffa0d703          	lhu	x14,-6(x1)
 100015c:	0ff00e93          	addi	x29,x0,255
 1000160:	4199                	c.li	x3,6
 1000162:	1bd71463          	bne	x14,x29,100030a <fail>

01000166 <test_7>:
 1000166:	00002097          	auipc	x1,0x2
 100016a:	ea008093          	addi	x1,x1,-352 # 1002006 <tdat4>
 100016e:	ffc0d703          	lhu	x14,-4(x1)
 1000172:	00010eb7          	lui	x29,0x10
 1000176:	f00e8e93          	addi	x29,x29,-256 # ff00 <_start-0xff0100>
 100017a:	419d                	c.li	x3,7
 100017c:	19d71763          	bne	x14,x29,100030a <fail>

01000180 <test_8>:
 1000180:	00002097          	auipc	x1,0x2
 1000184:	e8608093          	addi	x1,x1,-378 # 1002006 <tdat4>
 1000188:	ffe0d703          	lhu	x14,-2(x1)
 100018c:	00001eb7          	lui	x29,0x1
 1000190:	ff0e8e93          	addi	x29,x29,-16 # ff0 <_start-0xfff010>
 1000194:	41a1                	c.li	x3,8
 1000196:	17d71a63          	bne	x14,x29,100030a <fail>

0100019a <test_9>:
 100019a:	00002097          	auipc	x1,0x2
 100019e:	e6c08093          	addi	x1,x1,-404 # 1002006 <tdat4>
 10001a2:	0000d703          	lhu	x14,0(x1)
 10001a6:	0000feb7          	lui	x29,0xf
 10001aa:	00fe8e93          	addi	x29,x29,15 # f00f <_start-0xff0ff1>
 10001ae:	41a5                	c.li	x3,9
 10001b0:	15d71d63          	bne	x14,x29,100030a <fail>

010001b4 <test_10>:
 10001b4:	00002097          	auipc	x1,0x2
 10001b8:	e4c08093          	addi	x1,x1,-436 # 1002000 <begin_signature>
 10001bc:	1081                	c.addi	x1,-32
 10001be:	0200d283          	lhu	x5,32(x1)
 10001c2:	0ff00e93          	addi	x29,x0,255
 10001c6:	41a9                	c.li	x3,10
 10001c8:	15d29163          	bne	x5,x29,100030a <fail>

010001cc <test_11>:
 10001cc:	00002097          	auipc	x1,0x2
 10001d0:	e3408093          	addi	x1,x1,-460 # 1002000 <begin_signature>
 10001d4:	10ed                	c.addi	x1,-5
 10001d6:	0070d283          	lhu	x5,7(x1)
 10001da:	00010eb7          	lui	x29,0x10
 10001de:	f00e8e93          	addi	x29,x29,-256 # ff00 <_start-0xff0100>
 10001e2:	41ad                	c.li	x3,11
 10001e4:	13d29363          	bne	x5,x29,100030a <fail>

010001e8 <test_12>:
 10001e8:	41b1                	c.li	x3,12
 10001ea:	4201                	c.li	x4,0
 10001ec:	00002097          	auipc	x1,0x2
 10001f0:	e1608093          	addi	x1,x1,-490 # 1002002 <tdat2>
 10001f4:	0020d703          	lhu	x14,2(x1)
 10001f8:	00070313          	addi	x6,x14,0
 10001fc:	00001eb7          	lui	x29,0x1
 1000200:	ff0e8e93          	addi	x29,x29,-16 # ff0 <_start-0xfff010>
 1000204:	11d31363          	bne	x6,x29,100030a <fail>
 1000208:	0205                	c.addi	x4,1
 100020a:	4289                	c.li	x5,2
 100020c:	fe5210e3          	bne	x4,x5,10001ec <test_12+0x4>

01000210 <test_13>:
 1000210:	41b5                	c.li	x3,13
 1000212:	4201                	c.li	x4,0
 1000214:	00002097          	auipc	x1,0x2
 1000218:	df008093          	addi	x1,x1,-528 # 1002004 <tdat3>
 100021c:	0020d703          	lhu	x14,2(x1)
 1000220:	0001                	c.addi	x0,0
 1000222:	00070313          	addi	x6,x14,0
 1000226:	0000feb7          	lui	x29,0xf
 100022a:	00fe8e93          	addi	x29,x29,15 # f00f <_start-0xff0ff1>
 100022e:	0dd31e63          	bne	x6,x29,100030a <fail>
 1000232:	0205                	c.addi	x4,1
 1000234:	4289                	c.li	x5,2
 1000236:	fc521fe3          	bne	x4,x5,1000214 <test_13+0x4>

0100023a <test_14>:
 100023a:	41b9                	c.li	x3,14
 100023c:	4201                	c.li	x4,0
 100023e:	00002097          	auipc	x1,0x2
 1000242:	dc208093          	addi	x1,x1,-574 # 1002000 <begin_signature>
 1000246:	0020d703          	lhu	x14,2(x1)
 100024a:	0001                	c.addi	x0,0
 100024c:	0001                	c.addi	x0,0
 100024e:	00070313          	addi	x6,x14,0
 1000252:	00010eb7          	lui	x29,0x10
 1000256:	f00e8e93          	addi	x29,x29,-256 # ff00 <_start-0xff0100>
 100025a:	0bd31863          	bne	x6,x29,100030a <fail>
 100025e:	0205                	c.addi	x4,1
 1000260:	4289                	c.li	x5,2
 1000262:	fc521ee3          	bne	x4,x5,100023e <test_14+0x4>

01000266 <test_15>:
 1000266:	41bd                	c.li	x3,15
 1000268:	4201                	c.li	x4,0
 100026a:	00002097          	auipc	x1,0x2
 100026e:	d9808093          	addi	x1,x1,-616 # 1002002 <tdat2>
 1000272:	0020d703          	lhu	x14,2(x1)
 1000276:	00001eb7          	lui	x29,0x1
 100027a:	ff0e8e93          	addi	x29,x29,-16 # ff0 <_start-0xfff010>
 100027e:	09d71663          	bne	x14,x29,100030a <fail>
 1000282:	0205                	c.addi	x4,1
 1000284:	4289                	c.li	x5,2
 1000286:	fe5212e3          	bne	x4,x5,100026a <test_15+0x4>

0100028a <test_16>:
 100028a:	41c1                	c.li	x3,16
 100028c:	4201                	c.li	x4,0
 100028e:	00002097          	auipc	x1,0x2
 1000292:	d7608093          	addi	x1,x1,-650 # 1002004 <tdat3>
 1000296:	0001                	c.addi	x0,0
 1000298:	0020d703          	lhu	x14,2(x1)
 100029c:	0000feb7          	lui	x29,0xf
 10002a0:	00fe8e93          	addi	x29,x29,15 # f00f <_start-0xff0ff1>
 10002a4:	07d71363          	bne	x14,x29,100030a <fail>
 10002a8:	0205                	c.addi	x4,1
 10002aa:	4289                	c.li	x5,2
 10002ac:	fe5211e3          	bne	x4,x5,100028e <test_16+0x4>

010002b0 <test_17>:
 10002b0:	41c5                	c.li	x3,17
 10002b2:	4201                	c.li	x4,0
 10002b4:	00002097          	auipc	x1,0x2
 10002b8:	d4c08093          	addi	x1,x1,-692 # 1002000 <begin_signature>
 10002bc:	0001                	c.addi	x0,0
 10002be:	0001                	c.addi	x0,0
 10002c0:	0020d703          	lhu	x14,2(x1)
 10002c4:	00010eb7          	lui	x29,0x10
 10002c8:	f00e8e93          	addi	x29,x29,-256 # ff00 <_start-0xff0100>
 10002cc:	03d71f63          	bne	x14,x29,100030a <fail>
 10002d0:	0205                	c.addi	x4,1
 10002d2:	4289                	c.li	x5,2
 10002d4:	fe5210e3          	bne	x4,x5,10002b4 <test_17+0x4>

010002d8 <test_18>:
 10002d8:	00002297          	auipc	x5,0x2
 10002dc:	d2828293          	addi	x5,x5,-728 # 1002000 <begin_signature>
 10002e0:	0002d103          	lhu	x2,0(x5)
 10002e4:	4109                	c.li	x2,2
 10002e6:	4e89                	c.li	x29,2
 10002e8:	41c9                	c.li	x3,18
 10002ea:	03d11063          	bne	x2,x29,100030a <fail>

010002ee <test_19>:
 10002ee:	00002297          	auipc	x5,0x2
 10002f2:	d1228293          	addi	x5,x5,-750 # 1002000 <begin_signature>
 10002f6:	0002d103          	lhu	x2,0(x5)
 10002fa:	0001                	c.addi	x0,0
 10002fc:	4109                	c.li	x2,2
 10002fe:	4e89                	c.li	x29,2
 1000300:	41cd                	c.li	x3,19
 1000302:	01d11463          	bne	x2,x29,100030a <fail>
 1000306:	00301b63          	bne	x0,x3,100031c <pass>

0100030a <fail>:
 100030a:	0ff0000f          	fence	iorw,iorw
 100030e:	00018063          	beq	x3,x0,100030e <fail+0x4>
 1000312:	0186                	c.slli	x3,0x1
 1000314:	0011e193          	ori	x3,x3,1
 1000318:	00000073          	ecall

0100031c <pass>:
 100031c:	0ff0000f          	fence	iorw,iorw
 1000320:	4185                	c.li	x3,1
 1000322:	00000073          	ecall
	...

Disassembly of section .tohost:

01001000 <tohost>:
	...

01001040 <fromhost>:
	...

Disassembly of section .data:

01002000 <begin_signature>:
 1002000:	00ff                	0xff

01002002 <tdat2>:
 1002002:	ff00                	c.fsw	f8,56(x14)

01002004 <tdat3>:
 1002004:	0ff0                	c.addi4spn	x12,x2,988

01002006 <tdat4>:
 1002006:	0000f00f          	0xf00f
 100200a:	0000                	c.unimp
 100200c:	0000                	c.unimp
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

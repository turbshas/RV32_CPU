
rv32ui/lb.elf:     file format elf32-littleriscv


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
 10000f4:	00008703          	lb	x14,0(x1)
 10000f8:	fff00e93          	addi	x29,x0,-1
 10000fc:	4189                	c.li	x3,2
 10000fe:	1dd71163          	bne	x14,x29,10002c0 <fail>

01000102 <test_3>:
 1000102:	00002097          	auipc	x1,0x2
 1000106:	efe08093          	addi	x1,x1,-258 # 1002000 <begin_signature>
 100010a:	00108703          	lb	x14,1(x1)
 100010e:	4e81                	c.li	x29,0
 1000110:	418d                	c.li	x3,3
 1000112:	1bd71763          	bne	x14,x29,10002c0 <fail>

01000116 <test_4>:
 1000116:	00002097          	auipc	x1,0x2
 100011a:	eea08093          	addi	x1,x1,-278 # 1002000 <begin_signature>
 100011e:	00208703          	lb	x14,2(x1)
 1000122:	ff000e93          	addi	x29,x0,-16
 1000126:	4191                	c.li	x3,4
 1000128:	19d71c63          	bne	x14,x29,10002c0 <fail>

0100012c <test_5>:
 100012c:	00002097          	auipc	x1,0x2
 1000130:	ed408093          	addi	x1,x1,-300 # 1002000 <begin_signature>
 1000134:	00308703          	lb	x14,3(x1)
 1000138:	4ebd                	c.li	x29,15
 100013a:	4195                	c.li	x3,5
 100013c:	19d71263          	bne	x14,x29,10002c0 <fail>

01000140 <test_6>:
 1000140:	00002097          	auipc	x1,0x2
 1000144:	ec308093          	addi	x1,x1,-317 # 1002003 <tdat4>
 1000148:	ffd08703          	lb	x14,-3(x1)
 100014c:	fff00e93          	addi	x29,x0,-1
 1000150:	4199                	c.li	x3,6
 1000152:	17d71763          	bne	x14,x29,10002c0 <fail>

01000156 <test_7>:
 1000156:	00002097          	auipc	x1,0x2
 100015a:	ead08093          	addi	x1,x1,-339 # 1002003 <tdat4>
 100015e:	ffe08703          	lb	x14,-2(x1)
 1000162:	4e81                	c.li	x29,0
 1000164:	419d                	c.li	x3,7
 1000166:	15d71d63          	bne	x14,x29,10002c0 <fail>

0100016a <test_8>:
 100016a:	00002097          	auipc	x1,0x2
 100016e:	e9908093          	addi	x1,x1,-359 # 1002003 <tdat4>
 1000172:	fff08703          	lb	x14,-1(x1)
 1000176:	ff000e93          	addi	x29,x0,-16
 100017a:	41a1                	c.li	x3,8
 100017c:	15d71263          	bne	x14,x29,10002c0 <fail>

01000180 <test_9>:
 1000180:	00002097          	auipc	x1,0x2
 1000184:	e8308093          	addi	x1,x1,-381 # 1002003 <tdat4>
 1000188:	00008703          	lb	x14,0(x1)
 100018c:	4ebd                	c.li	x29,15
 100018e:	41a5                	c.li	x3,9
 1000190:	13d71863          	bne	x14,x29,10002c0 <fail>

01000194 <test_10>:
 1000194:	00002097          	auipc	x1,0x2
 1000198:	e6c08093          	addi	x1,x1,-404 # 1002000 <begin_signature>
 100019c:	1081                	c.addi	x1,-32
 100019e:	02008283          	lb	x5,32(x1)
 10001a2:	fff00e93          	addi	x29,x0,-1
 10001a6:	41a9                	c.li	x3,10
 10001a8:	11d29c63          	bne	x5,x29,10002c0 <fail>

010001ac <test_11>:
 10001ac:	00002097          	auipc	x1,0x2
 10001b0:	e5408093          	addi	x1,x1,-428 # 1002000 <begin_signature>
 10001b4:	10e9                	c.addi	x1,-6
 10001b6:	00708283          	lb	x5,7(x1)
 10001ba:	4e81                	c.li	x29,0
 10001bc:	41ad                	c.li	x3,11
 10001be:	11d29163          	bne	x5,x29,10002c0 <fail>

010001c2 <test_12>:
 10001c2:	41b1                	c.li	x3,12
 10001c4:	4201                	c.li	x4,0
 10001c6:	00002097          	auipc	x1,0x2
 10001ca:	e3b08093          	addi	x1,x1,-453 # 1002001 <tdat2>
 10001ce:	00108703          	lb	x14,1(x1)
 10001d2:	00070313          	addi	x6,x14,0
 10001d6:	5ec1                	c.li	x29,-16
 10001d8:	0fd31463          	bne	x6,x29,10002c0 <fail>
 10001dc:	0205                	c.addi	x4,1
 10001de:	4289                	c.li	x5,2
 10001e0:	fe5213e3          	bne	x4,x5,10001c6 <test_12+0x4>

010001e4 <test_13>:
 10001e4:	41b5                	c.li	x3,13
 10001e6:	4201                	c.li	x4,0
 10001e8:	00002097          	auipc	x1,0x2
 10001ec:	e1a08093          	addi	x1,x1,-486 # 1002002 <tdat3>
 10001f0:	00108703          	lb	x14,1(x1)
 10001f4:	0001                	c.addi	x0,0
 10001f6:	00070313          	addi	x6,x14,0
 10001fa:	4ebd                	c.li	x29,15
 10001fc:	0dd31263          	bne	x6,x29,10002c0 <fail>
 1000200:	0205                	c.addi	x4,1
 1000202:	4289                	c.li	x5,2
 1000204:	fe5212e3          	bne	x4,x5,10001e8 <test_13+0x4>

01000208 <test_14>:
 1000208:	41b9                	c.li	x3,14
 100020a:	4201                	c.li	x4,0
 100020c:	00002097          	auipc	x1,0x2
 1000210:	df408093          	addi	x1,x1,-524 # 1002000 <begin_signature>
 1000214:	00108703          	lb	x14,1(x1)
 1000218:	0001                	c.addi	x0,0
 100021a:	0001                	c.addi	x0,0
 100021c:	00070313          	addi	x6,x14,0
 1000220:	4e81                	c.li	x29,0
 1000222:	09d31f63          	bne	x6,x29,10002c0 <fail>
 1000226:	0205                	c.addi	x4,1
 1000228:	4289                	c.li	x5,2
 100022a:	fe5211e3          	bne	x4,x5,100020c <test_14+0x4>

0100022e <test_15>:
 100022e:	41bd                	c.li	x3,15
 1000230:	4201                	c.li	x4,0
 1000232:	00002097          	auipc	x1,0x2
 1000236:	dcf08093          	addi	x1,x1,-561 # 1002001 <tdat2>
 100023a:	00108703          	lb	x14,1(x1)
 100023e:	5ec1                	c.li	x29,-16
 1000240:	09d71063          	bne	x14,x29,10002c0 <fail>
 1000244:	0205                	c.addi	x4,1
 1000246:	4289                	c.li	x5,2
 1000248:	fe5215e3          	bne	x4,x5,1000232 <test_15+0x4>

0100024c <test_16>:
 100024c:	41c1                	c.li	x3,16
 100024e:	4201                	c.li	x4,0
 1000250:	00002097          	auipc	x1,0x2
 1000254:	db208093          	addi	x1,x1,-590 # 1002002 <tdat3>
 1000258:	0001                	c.addi	x0,0
 100025a:	00108703          	lb	x14,1(x1)
 100025e:	4ebd                	c.li	x29,15
 1000260:	07d71063          	bne	x14,x29,10002c0 <fail>
 1000264:	0205                	c.addi	x4,1
 1000266:	4289                	c.li	x5,2
 1000268:	fe5214e3          	bne	x4,x5,1000250 <test_16+0x4>

0100026c <test_17>:
 100026c:	41c5                	c.li	x3,17
 100026e:	4201                	c.li	x4,0
 1000270:	00002097          	auipc	x1,0x2
 1000274:	d9008093          	addi	x1,x1,-624 # 1002000 <begin_signature>
 1000278:	0001                	c.addi	x0,0
 100027a:	0001                	c.addi	x0,0
 100027c:	00108703          	lb	x14,1(x1)
 1000280:	4e81                	c.li	x29,0
 1000282:	03d71f63          	bne	x14,x29,10002c0 <fail>
 1000286:	0205                	c.addi	x4,1
 1000288:	4289                	c.li	x5,2
 100028a:	fe5213e3          	bne	x4,x5,1000270 <test_17+0x4>

0100028e <test_18>:
 100028e:	00002297          	auipc	x5,0x2
 1000292:	d7228293          	addi	x5,x5,-654 # 1002000 <begin_signature>
 1000296:	00028103          	lb	x2,0(x5)
 100029a:	4109                	c.li	x2,2
 100029c:	4e89                	c.li	x29,2
 100029e:	41c9                	c.li	x3,18
 10002a0:	03d11063          	bne	x2,x29,10002c0 <fail>

010002a4 <test_19>:
 10002a4:	00002297          	auipc	x5,0x2
 10002a8:	d5c28293          	addi	x5,x5,-676 # 1002000 <begin_signature>
 10002ac:	00028103          	lb	x2,0(x5)
 10002b0:	0001                	c.addi	x0,0
 10002b2:	4109                	c.li	x2,2
 10002b4:	4e89                	c.li	x29,2
 10002b6:	41cd                	c.li	x3,19
 10002b8:	01d11463          	bne	x2,x29,10002c0 <fail>
 10002bc:	00301b63          	bne	x0,x3,10002d2 <pass>

010002c0 <fail>:
 10002c0:	0ff0000f          	fence	iorw,iorw
 10002c4:	00018063          	beq	x3,x0,10002c4 <fail+0x4>
 10002c8:	0186                	c.slli	x3,0x1
 10002ca:	0011e193          	ori	x3,x3,1
 10002ce:	00000073          	ecall

010002d2 <pass>:
 10002d2:	0ff0000f          	fence	iorw,iorw
 10002d6:	4185                	c.li	x3,1
 10002d8:	00000073          	ecall
	...

Disassembly of section .tohost:

01001000 <tohost>:
	...

01001040 <fromhost>:
	...

Disassembly of section .data:

01002000 <begin_signature>:
 1002000:	                	0xff

01002001 <tdat2>:
	...

01002002 <tdat3>:
 1002002:	                	c.addi4spn	x12,x2,988

01002003 <tdat4>:
 1002003:	0000000f          	fence	unknown,unknown
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

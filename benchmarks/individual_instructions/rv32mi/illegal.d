
rv32mi/illegal.elf:     file format elf32-littleriscv


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
 100001a:	00000f17          	auipc	x30,0x0
 100001e:	2e6f0f13          	addi	x30,x30,742 # 1000300 <mtvec_handler>
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
 10000d8:	00002537          	lui	x10,0x2
 10000dc:	80050513          	addi	x10,x10,-2048 # 1800 <_start-0xffe800>
 10000e0:	30052073          	csrrs	x0,mstatus,x10
 10000e4:	00000297          	auipc	x5,0x0
 10000e8:	01428293          	addi	x5,x5,20 # 10000f8 <reset_vector+0xb8>
 10000ec:	34129073          	csrrw	x0,mepc,x5
 10000f0:	f1402573          	csrrs	x10,mhartid,x0
 10000f4:	30200073          	mret
 10000f8:	00200193          	addi	x3,x0,2

010000fc <bad2>:
 10000fc:	0000                	c.unimp
 10000fe:	0000                	c.unimp
 1000100:	0f40006f          	jal	x0,10001f4 <fail>
 1000104:	000022b7          	lui	x5,0x2
 1000108:	80028293          	addi	x5,x5,-2048 # 1800 <_start-0xffe800>
 100010c:	3002b073          	csrrc	x0,mstatus,x5
 1000110:	00001337          	lui	x6,0x1
 1000114:	80030313          	addi	x6,x6,-2048 # 800 <_start-0xfff800>
 1000118:	30032073          	csrrs	x0,mstatus,x6
 100011c:	300023f3          	csrrs	x7,mstatus,x0
 1000120:	0053f3b3          	and	x7,x7,x5
 1000124:	0e731263          	bne	x6,x7,1000208 <pass>

01000128 <test_vectored_interrupts>:
 1000128:	34415073          	csrrwi	x0,mip,2
 100012c:	30415073          	csrrwi	x0,mie,2
 1000130:	00000297          	auipc	x5,0x0
 1000134:	1d128293          	addi	x5,x5,465 # 1000301 <mtvec_handler+0x1>
 1000138:	30529473          	csrrw	x8,mtvec,x5
 100013c:	305022f3          	csrrs	x5,mtvec,x0
 1000140:	0012f293          	andi	x5,x5,1
 1000144:	00028663          	beq	x5,x0,1000150 <msip>
 1000148:	30046073          	csrrsi	x0,mstatus,8
 100014c:	0000006f          	jal	x0,100014c <test_vectored_interrupts+0x24>

01000150 <msip>:
 1000150:	30541073          	csrrw	x0,mtvec,x8
 1000154:	30315073          	csrrwi	x0,mideleg,2
 1000158:	00000297          	auipc	x5,0x0
 100015c:	02828293          	addi	x5,x5,40 # 1000180 <msip+0x30>
 1000160:	34129073          	csrrw	x0,mepc,x5
 1000164:	000022b7          	lui	x5,0x2
 1000168:	80028293          	addi	x5,x5,-2048 # 1800 <_start-0xffe800>
 100016c:	3002b073          	csrrc	x0,mstatus,x5
 1000170:	00001337          	lui	x6,0x1
 1000174:	80030313          	addi	x6,x6,-2048 # 800 <_start-0xfff800>
 1000178:	30032073          	csrrs	x0,mstatus,x6
 100017c:	30200073          	mret
 1000180:	10500073          	wfi

01000184 <bad3>:
 1000184:	0000                	c.unimp
 1000186:	0000                	c.unimp
 1000188:	06c0006f          	jal	x0,10001f4 <fail>

0100018c <bad4>:
 100018c:	10500073          	wfi
 1000190:	0640006f          	jal	x0,10001f4 <fail>
 1000194:	12000073          	sfence.vma	x0,x0
 1000198:	180022f3          	csrrs	x5,satp,x0

0100019c <bad5>:
 100019c:	0000                	c.unimp
 100019e:	0000                	c.unimp
 10001a0:	0540006f          	jal	x0,10001f4 <fail>

010001a4 <bad6>:
 10001a4:	12000073          	sfence.vma	x0,x0
 10001a8:	04c0006f          	jal	x0,10001f4 <fail>

010001ac <bad7>:
 10001ac:	180022f3          	csrrs	x5,satp,x0
 10001b0:	0440006f          	jal	x0,10001f4 <fail>
 10001b4:	00000297          	auipc	x5,0x0
 10001b8:	02028293          	addi	x5,x5,32 # 10001d4 <bad8>
 10001bc:	14129073          	csrrw	x0,sepc,x5
 10001c0:	10000293          	addi	x5,x0,256
 10001c4:	1002a073          	csrrs	x0,sstatus,x5
 10001c8:	02000293          	addi	x5,x0,32
 10001cc:	1002b073          	csrrc	x0,sstatus,x5
 10001d0:	10200073          	sret

010001d4 <bad8>:
 10001d4:	0000                	c.unimp
 10001d6:	0000                	c.unimp
 10001d8:	01c0006f          	jal	x0,10001f4 <fail>
 10001dc:	00000297          	auipc	x5,0x0
 10001e0:	01028293          	addi	x5,x5,16 # 10001ec <bad9+0x4>
 10001e4:	14129073          	csrrw	x0,sepc,x5

010001e8 <bad9>:
 10001e8:	10200073          	sret
 10001ec:	0080006f          	jal	x0,10001f4 <fail>
 10001f0:	00301c63          	bne	x0,x3,1000208 <pass>

010001f4 <fail>:
 10001f4:	0ff0000f          	fence	iorw,iorw
 10001f8:	00018063          	beq	x3,x0,10001f8 <fail+0x4>
 10001fc:	00119193          	slli	x3,x3,0x1
 1000200:	0011e193          	ori	x3,x3,1
 1000204:	00000073          	ecall

01000208 <pass>:
 1000208:	0ff0000f          	fence	iorw,iorw
 100020c:	00100193          	addi	x3,x0,1
 1000210:	00000073          	ecall
 1000214:	00000013          	addi	x0,x0,0
 1000218:	00000013          	addi	x0,x0,0
 100021c:	00000013          	addi	x0,x0,0
 1000220:	00000013          	addi	x0,x0,0
 1000224:	00000013          	addi	x0,x0,0
 1000228:	00000013          	addi	x0,x0,0
 100022c:	00000013          	addi	x0,x0,0
 1000230:	00000013          	addi	x0,x0,0
 1000234:	00000013          	addi	x0,x0,0
 1000238:	00000013          	addi	x0,x0,0
 100023c:	00000013          	addi	x0,x0,0
 1000240:	00000013          	addi	x0,x0,0
 1000244:	00000013          	addi	x0,x0,0
 1000248:	00000013          	addi	x0,x0,0
 100024c:	00000013          	addi	x0,x0,0
 1000250:	00000013          	addi	x0,x0,0
 1000254:	00000013          	addi	x0,x0,0
 1000258:	00000013          	addi	x0,x0,0
 100025c:	00000013          	addi	x0,x0,0
 1000260:	00000013          	addi	x0,x0,0
 1000264:	00000013          	addi	x0,x0,0
 1000268:	00000013          	addi	x0,x0,0
 100026c:	00000013          	addi	x0,x0,0
 1000270:	00000013          	addi	x0,x0,0
 1000274:	00000013          	addi	x0,x0,0
 1000278:	00000013          	addi	x0,x0,0
 100027c:	00000013          	addi	x0,x0,0
 1000280:	00000013          	addi	x0,x0,0
 1000284:	00000013          	addi	x0,x0,0
 1000288:	00000013          	addi	x0,x0,0
 100028c:	00000013          	addi	x0,x0,0
 1000290:	00000013          	addi	x0,x0,0
 1000294:	00000013          	addi	x0,x0,0
 1000298:	00000013          	addi	x0,x0,0
 100029c:	00000013          	addi	x0,x0,0
 10002a0:	00000013          	addi	x0,x0,0
 10002a4:	00000013          	addi	x0,x0,0
 10002a8:	00000013          	addi	x0,x0,0
 10002ac:	00000013          	addi	x0,x0,0
 10002b0:	00000013          	addi	x0,x0,0
 10002b4:	00000013          	addi	x0,x0,0
 10002b8:	00000013          	addi	x0,x0,0
 10002bc:	00000013          	addi	x0,x0,0
 10002c0:	00000013          	addi	x0,x0,0
 10002c4:	00000013          	addi	x0,x0,0
 10002c8:	00000013          	addi	x0,x0,0
 10002cc:	00000013          	addi	x0,x0,0
 10002d0:	00000013          	addi	x0,x0,0
 10002d4:	00000013          	addi	x0,x0,0
 10002d8:	00000013          	addi	x0,x0,0
 10002dc:	00000013          	addi	x0,x0,0
 10002e0:	00000013          	addi	x0,x0,0
 10002e4:	00000013          	addi	x0,x0,0
 10002e8:	00000013          	addi	x0,x0,0
 10002ec:	00000013          	addi	x0,x0,0
 10002f0:	00000013          	addi	x0,x0,0
 10002f4:	00000013          	addi	x0,x0,0
 10002f8:	00000013          	addi	x0,x0,0
 10002fc:	00000013          	addi	x0,x0,0

01000300 <mtvec_handler>:
 1000300:	0400006f          	jal	x0,1000340 <synchronous_exception>
 1000304:	e4dff06f          	jal	x0,1000150 <msip>
 1000308:	eedff06f          	jal	x0,10001f4 <fail>
 100030c:	ee9ff06f          	jal	x0,10001f4 <fail>
 1000310:	ee5ff06f          	jal	x0,10001f4 <fail>
 1000314:	ee1ff06f          	jal	x0,10001f4 <fail>
 1000318:	eddff06f          	jal	x0,10001f4 <fail>
 100031c:	ed9ff06f          	jal	x0,10001f4 <fail>
 1000320:	ed5ff06f          	jal	x0,10001f4 <fail>
 1000324:	ed1ff06f          	jal	x0,10001f4 <fail>
 1000328:	ecdff06f          	jal	x0,10001f4 <fail>
 100032c:	ec9ff06f          	jal	x0,10001f4 <fail>
 1000330:	ec5ff06f          	jal	x0,10001f4 <fail>
 1000334:	ec1ff06f          	jal	x0,10001f4 <fail>
 1000338:	ebdff06f          	jal	x0,10001f4 <fail>
 100033c:	eb9ff06f          	jal	x0,10001f4 <fail>

01000340 <synchronous_exception>:
 1000340:	00200313          	addi	x6,x0,2
 1000344:	342022f3          	csrrs	x5,mcause,x0
 1000348:	ea6296e3          	bne	x5,x6,10001f4 <fail>
 100034c:	341022f3          	csrrs	x5,mepc,x0
 1000350:	343023f3          	csrrs	x7,mtval,x0
 1000354:	00038e63          	beq	x7,x0,1000370 <synchronous_exception+0x30>
 1000358:	0002d303          	lhu	x6,0(x5)
 100035c:	0063c3b3          	xor	x7,x7,x6
 1000360:	0022d303          	lhu	x6,2(x5)
 1000364:	01031313          	slli	x6,x6,0x10
 1000368:	0063c3b3          	xor	x7,x7,x6
 100036c:	e80394e3          	bne	x7,x0,10001f4 <fail>
 1000370:	00000317          	auipc	x6,0x0
 1000374:	d8c30313          	addi	x6,x6,-628 # 10000fc <bad2>
 1000378:	04628e63          	beq	x5,x6,10003d4 <synchronous_exception+0x94>
 100037c:	00000317          	auipc	x6,0x0
 1000380:	e0830313          	addi	x6,x6,-504 # 1000184 <bad3>
 1000384:	04628e63          	beq	x5,x6,10003e0 <synchronous_exception+0xa0>
 1000388:	00000317          	auipc	x6,0x0
 100038c:	e0430313          	addi	x6,x6,-508 # 100018c <bad4>
 1000390:	04628263          	beq	x5,x6,10003d4 <synchronous_exception+0x94>
 1000394:	00000317          	auipc	x6,0x0
 1000398:	e0830313          	addi	x6,x6,-504 # 100019c <bad5>
 100039c:	04628863          	beq	x5,x6,10003ec <synchronous_exception+0xac>
 10003a0:	00000317          	auipc	x6,0x0
 10003a4:	e0430313          	addi	x6,x6,-508 # 10001a4 <bad6>
 10003a8:	02628663          	beq	x5,x6,10003d4 <synchronous_exception+0x94>
 10003ac:	00000317          	auipc	x6,0x0
 10003b0:	e0030313          	addi	x6,x6,-512 # 10001ac <bad7>
 10003b4:	02628063          	beq	x5,x6,10003d4 <synchronous_exception+0x94>
 10003b8:	00000317          	auipc	x6,0x0
 10003bc:	e1c30313          	addi	x6,x6,-484 # 10001d4 <bad8>
 10003c0:	02628c63          	beq	x5,x6,10003f8 <synchronous_exception+0xb8>
 10003c4:	00000317          	auipc	x6,0x0
 10003c8:	e2430313          	addi	x6,x6,-476 # 10001e8 <bad9>
 10003cc:	02628c63          	beq	x5,x6,1000404 <synchronous_exception+0xc4>
 10003d0:	e25ff06f          	jal	x0,10001f4 <fail>
 10003d4:	00828293          	addi	x5,x5,8
 10003d8:	34129073          	csrrw	x0,mepc,x5
 10003dc:	30200073          	mret
 10003e0:	00200337          	lui	x6,0x200
 10003e4:	30032073          	csrrs	x0,mstatus,x6
 10003e8:	fedff06f          	jal	x0,10003d4 <synchronous_exception+0x94>
 10003ec:	00100337          	lui	x6,0x100
 10003f0:	30032073          	csrrs	x0,mstatus,x6
 10003f4:	fe1ff06f          	jal	x0,10003d4 <synchronous_exception+0x94>
 10003f8:	00400337          	lui	x6,0x400
 10003fc:	30032073          	csrrs	x0,mstatus,x6
 1000400:	fd5ff06f          	jal	x0,10003d4 <synchronous_exception+0x94>
 1000404:	fd1ff06f          	jal	x0,10003d4 <synchronous_exception+0x94>
 1000408:	c0001073          	unimp
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

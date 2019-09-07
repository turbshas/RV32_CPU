
rv32mi/ma_fetch.elf:     file format elf32-littleriscv


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
 100001e:	1fef0f13          	addi	x30,x30,510 # 1000218 <mtvec_handler>
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
 10000fc:	00000313          	addi	x6,x0,0
 1000100:	00000297          	auipc	x5,0x0
 1000104:	00c28293          	addi	x5,x5,12 # 100010c <reset_vector+0xcc>
 1000108:	00228367          	jalr	x6,2(x5)
 100010c:	a011                	c.j	1000110 <reset_vector+0xd0>
 100010e:	a019                	c.j	1000114 <reset_vector+0xd4>
 1000110:	0e80006f          	jal	x0,10001f8 <fail>
 1000114:	00300193          	addi	x3,x0,3
 1000118:	00000297          	auipc	x5,0x0
 100011c:	00c28293          	addi	x5,x5,12 # 1000124 <reset_vector+0xe4>
 1000120:	00128367          	jalr	x6,1(x5)
 1000124:	0080006f          	jal	x0,100012c <reset_vector+0xec>
 1000128:	0d00006f          	jal	x0,10001f8 <fail>
 100012c:	00400193          	addi	x3,x0,4
 1000130:	00000313          	addi	x6,x0,0
 1000134:	00000297          	auipc	x5,0x0
 1000138:	00c28293          	addi	x5,x5,12 # 1000140 <reset_vector+0x100>
 100013c:	00328367          	jalr	x6,3(x5)
 1000140:	a011                	c.j	1000144 <reset_vector+0x104>
 1000142:	a019                	c.j	1000148 <reset_vector+0x108>
 1000144:	0b40006f          	jal	x0,10001f8 <fail>
 1000148:	00500193          	addi	x3,x0,5
 100014c:	00000313          	addi	x6,x0,0
 1000150:	00000297          	auipc	x5,0x0
 1000154:	00c28293          	addi	x5,x5,12 # 100015c <reset_vector+0x11c>
 1000158:	0060036f          	jal	x6,100015e <reset_vector+0x11e>
 100015c:	a011                	c.j	1000160 <reset_vector+0x120>
 100015e:	a019                	c.j	1000164 <reset_vector+0x124>
 1000160:	0980006f          	jal	x0,10001f8 <fail>
 1000164:	00600193          	addi	x3,x0,6
 1000168:	00000313          	addi	x6,x0,0
 100016c:	00000297          	auipc	x5,0x0
 1000170:	00c28293          	addi	x5,x5,12 # 1000178 <reset_vector+0x138>
 1000174:	00000363          	beq	x0,x0,100017a <reset_vector+0x13a>
 1000178:	a011                	c.j	100017c <reset_vector+0x13c>
 100017a:	a019                	c.j	1000180 <reset_vector+0x140>
 100017c:	07c0006f          	jal	x0,10001f8 <fail>
 1000180:	00700193          	addi	x3,x0,7
 1000184:	00001563          	bne	x0,x0,100018e <reset_vector+0x14e>
 1000188:	00c0006f          	jal	x0,1000194 <reset_vector+0x154>
 100018c:	a009                	c.j	100018e <reset_vector+0x14e>
 100018e:	a009                	c.j	1000190 <reset_vector+0x150>
 1000190:	0680006f          	jal	x0,10001f8 <fail>
 1000194:	00800193          	addi	x3,x0,8
 1000198:	301023f3          	csrrs	x7,misa,x0
 100019c:	0043f393          	andi	x7,x7,4
 10001a0:	04038863          	beq	x7,x0,10001f0 <reset_vector+0x1b0>
 10001a4:	0001                	c.addi	x0,0
 10001a6:	30127073          	csrrci	x0,misa,4
 10001aa:	0001                	c.addi	x0,0
 10001ac:	301023f3          	csrrs	x7,misa,x0
 10001b0:	0043f393          	andi	x7,x7,4
 10001b4:	04038263          	beq	x7,x0,10001f8 <fail>
 10001b8:	00000297          	auipc	x5,0x0
 10001bc:	03428293          	addi	x5,x5,52 # 10001ec <reset_vector+0x1ac>
 10001c0:	ffe28293          	addi	x5,x5,-2
 10001c4:	34129073          	csrrw	x0,mepc,x5
 10001c8:	30127073          	csrrci	x0,misa,4
 10001cc:	301023f3          	csrrs	x7,misa,x0
 10001d0:	0043f393          	andi	x7,x7,4
 10001d4:	00039e63          	bne	x7,x0,10001f0 <reset_vector+0x1b0>
 10001d8:	000023b7          	lui	x7,0x2
 10001dc:	80038393          	addi	x7,x7,-2048 # 1800 <_start-0xffe800>
 10001e0:	3003a073          	csrrs	x0,mstatus,x7
 10001e4:	30200073          	mret
 10001e8:	00000263          	beq	x0,x0,10001ec <reset_vector+0x1ac>
 10001ec:	30126073          	csrrsi	x0,misa,4
 10001f0:	01c0006f          	jal	x0,100020c <pass>
 10001f4:	00301c63          	bne	x0,x3,100020c <pass>

010001f8 <fail>:
 10001f8:	0ff0000f          	fence	iorw,iorw
 10001fc:	00018063          	beq	x3,x0,10001fc <fail+0x4>
 1000200:	00119193          	slli	x3,x3,0x1
 1000204:	0011e193          	ori	x3,x3,1
 1000208:	00000073          	ecall

0100020c <pass>:
 100020c:	0ff0000f          	fence	iorw,iorw
 1000210:	00100193          	addi	x3,x0,1
 1000214:	00000073          	ecall

01000218 <mtvec_handler>:
 1000218:	00200513          	addi	x10,x0,2
 100021c:	02a18063          	beq	x3,x10,100023c <mtvec_handler+0x24>
 1000220:	00400513          	addi	x10,x0,4
 1000224:	00a18c63          	beq	x3,x10,100023c <mtvec_handler+0x24>
 1000228:	00500513          	addi	x10,x0,5
 100022c:	00a18863          	beq	x3,x10,100023c <mtvec_handler+0x24>
 1000230:	00600513          	addi	x10,x0,6
 1000234:	00a18463          	beq	x3,x10,100023c <mtvec_handler+0x24>
 1000238:	fc1ff06f          	jal	x0,10001f8 <fail>
 100023c:	fa031ee3          	bne	x6,x0,10001f8 <fail>
 1000240:	00000593          	addi	x11,x0,0
 1000244:	34202573          	csrrs	x10,mcause,x0
 1000248:	fab518e3          	bne	x10,x11,10001f8 <fail>
 100024c:	341025f3          	csrrs	x11,mepc,x0
 1000250:	00458593          	addi	x11,x11,4
 1000254:	fab292e3          	bne	x5,x11,10001f8 <fail>
 1000258:	34302573          	csrrs	x10,mtval,x0
 100025c:	00050663          	beq	x10,x0,1000268 <mtvec_handler+0x50>
 1000260:	ffe50513          	addi	x10,x10,-2
 1000264:	f8551ae3          	bne	x10,x5,10001f8 <fail>
 1000268:	00c58593          	addi	x11,x11,12
 100026c:	34159073          	csrrw	x0,mepc,x11
 1000270:	30200073          	mret
 1000274:	c0001073          	unimp
 1000278:	0000                	c.unimp
 100027a:	0000                	c.unimp
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


rv32si/dirty.elf:     file format elf32-littleriscv


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
 100001e:	1aef0f13          	addi	x30,x30,430 # 10001c8 <mtvec_handler>
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
 10000d8:	00002537          	lui	x10,0x2
 10000dc:	80050513          	addi	x10,x10,-2048 # 1800 <_start-0xffe800>
 10000e0:	30052073          	csrrs	x0,mstatus,x10
 10000e4:	00000297          	auipc	x5,0x0
 10000e8:	01428293          	addi	x5,x5,20 # 10000f8 <reset_vector+0xb8>
 10000ec:	34129073          	csrrw	x0,mepc,x5
 10000f0:	f1402573          	csrrs	x10,mhartid,x0
 10000f4:	30200073          	mret
 10000f8:	80000537          	lui	x10,0x80000
 10000fc:	00002597          	auipc	x11,0x2
 1000100:	f0458593          	addi	x11,x11,-252 # 1002000 <begin_signature>
 1000104:	81b1                	c.srli	x11,0xc
 1000106:	8dc9                	c.or	x11,x10
 1000108:	18059073          	csrrw	x0,satp,x11
 100010c:	12000073          	sfence.vma	x0,x0
 1000110:	000215b7          	lui	x11,0x21
 1000114:	80058593          	addi	x11,x11,-2048 # 20800 <_start-0xfdf800>
 1000118:	3005a073          	csrrs	x0,mstatus,x11
 100011c:	4189                	c.li	x3,2
 100011e:	4385                	c.li	x7,1
 1000120:	80002517          	auipc	x10,0x80002
 1000124:	ee752423          	sw	x7,-280(x10) # 81002008 <_end+0x7ffffff8>
 1000128:	418d                	c.li	x3,3
 100012a:	000415b7          	lui	x11,0x41
 100012e:	80058593          	addi	x11,x11,-2048 # 40800 <_start-0xfbf800>
 1000132:	3005a073          	csrrs	x0,mstatus,x11
 1000136:	80002297          	auipc	x5,0x80002
 100013a:	ed22a283          	lw	x5,-302(x5) # 81002008 <_end+0x7ffffff8>
 100013e:	0e029563          	bne	x5,x0,1000228 <die>
 1000142:	80002517          	auipc	x10,0x80002
 1000146:	ec752323          	sw	x7,-314(x10) # 81002008 <_end+0x7ffffff8>
 100014a:	80002297          	auipc	x5,0x80002
 100014e:	ebe2a283          	lw	x5,-322(x5) # 81002008 <_end+0x7ffffff8>
 1000152:	0c729b63          	bne	x5,x7,1000228 <die>
 1000156:	000202b7          	lui	x5,0x20
 100015a:	3002b073          	csrrc	x0,mstatus,x5
 100015e:	00002297          	auipc	x5,0x2
 1000162:	ea22a283          	lw	x5,-350(x5) # 1002000 <begin_signature>
 1000166:	0c000513          	addi	x10,x0,192
 100016a:	00a2f2b3          	and	x5,x5,x10
 100016e:	0aa29d63          	bne	x5,x10,1000228 <die>
 1000172:	000202b7          	lui	x5,0x20
 1000176:	3002a073          	csrrs	x0,mstatus,x5
 100017a:	4191                	c.li	x3,4
 100017c:	80002517          	auipc	x10,0x80002
 1000180:	e8452503          	lw	x10,-380(x10) # 81002000 <_end+0x7ffffff0>
 1000184:	40056513          	ori	x10,x10,1024
 1000188:	80002297          	auipc	x5,0x80002
 100018c:	e6a2ac23          	sw	x10,-392(x5) # 81002000 <_end+0x7ffffff0>
 1000190:	12000073          	sfence.vma	x0,x0
 1000194:	80002297          	auipc	x5,0x80002
 1000198:	e6a2a623          	sw	x10,-404(x5) # 81002000 <_end+0x7ffffff0>
 100019c:	a071                	c.j	1000228 <die>
 100019e:	0ff0000f          	fence	iorw,iorw
 10001a2:	4185                	c.li	x3,1
 10001a4:	00000073          	ecall
 10001a8:	00301b63          	bne	x0,x3,10001be <pass>

010001ac <fail>:
 10001ac:	0ff0000f          	fence	iorw,iorw
 10001b0:	00018063          	beq	x3,x0,10001b0 <fail+0x4>
 10001b4:	0186                	c.slli	x3,0x1
 10001b6:	0011e193          	ori	x3,x3,1
 10001ba:	00000073          	ecall

010001be <pass>:
 10001be:	0ff0000f          	fence	iorw,iorw
 10001c2:	4185                	c.li	x3,1
 10001c4:	00000073          	ecall

010001c8 <mtvec_handler>:
 10001c8:	342022f3          	csrrs	x5,mcause,x0
 10001cc:	12c5                	c.addi	x5,-15
 10001ce:	04029d63          	bne	x5,x0,1000228 <die>
 10001d2:	4309                	c.li	x6,2
 10001d4:	02619163          	bne	x3,x6,10001f6 <skip+0xe>
 10001d8:	00002297          	auipc	x5,0x2
 10001dc:	e282a283          	lw	x5,-472(x5) # 1002000 <begin_signature>
 10001e0:	0802f313          	andi	x6,x5,128
 10001e4:	04031263          	bne	x6,x0,1000228 <die>

010001e8 <skip>:
 10001e8:	341022f3          	csrrs	x5,mepc,x0
 10001ec:	0291                	c.addi	x5,4
 10001ee:	34129073          	csrrw	x0,mepc,x5
 10001f2:	30200073          	mret
 10001f6:	430d                	c.li	x6,3
 10001f8:	02619463          	bne	x3,x6,1000220 <skip+0x38>
 10001fc:	00002297          	auipc	x5,0x2
 1000200:	e042a283          	lw	x5,-508(x5) # 1002000 <begin_signature>
 1000204:	0802f313          	andi	x6,x5,128
 1000208:	02031063          	bne	x6,x0,1000228 <die>
 100020c:	0802e293          	ori	x5,x5,128
 1000210:	00002317          	auipc	x6,0x2
 1000214:	de532823          	sw	x5,-528(x6) # 1002000 <begin_signature>
 1000218:	12000073          	sfence.vma	x0,x0
 100021c:	30200073          	mret
 1000220:	4311                	c.li	x6,4
 1000222:	00619363          	bne	x3,x6,1000228 <die>
 1000226:	bf61                	c.j	10001be <pass>

01000228 <die>:
 1000228:	0ff0000f          	fence	iorw,iorw
 100022c:	00018063          	beq	x3,x0,100022c <die+0x4>
 1000230:	0186                	c.slli	x3,0x1
 1000232:	0011e193          	ori	x3,x3,1
 1000236:	00000073          	ecall
 100023a:	0000                	c.unimp
	...

Disassembly of section .tohost:

01001000 <tohost>:
	...

01001040 <fromhost>:
	...

Disassembly of section .data:

01002000 <begin_signature>:
 1002000:	005f 2000 0000      	0x2000005f
	...

01002008 <dummy>:
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

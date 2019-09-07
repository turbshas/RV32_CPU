
rv32mi/ma_addr.elf:     file format elf32-littleriscv


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
 100001e:	286f0f13          	addi	x30,x30,646 # 10002a0 <mtvec_handler>
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
 1000068:	fff28293          	addi	x5,x5,-1 # 7fffffff <_end+0x7effdeef>
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
 10000f8:	00002417          	auipc	x8,0x2
 10000fc:	f0840413          	addi	x8,x8,-248 # 1002000 <begin_signature>
 1000100:	00400493          	addi	x9,x0,4
 1000104:	00200193          	addi	x3,x0,2
 1000108:	00000397          	auipc	x7,0x0
 100010c:	01c38393          	addi	x7,x7,28 # 1000124 <reset_vector+0xe4>
 1000110:	00140313          	addi	x6,x8,1
 1000114:	00141303          	lh	x6,1(x8)
 1000118:	ffffc3b7          	lui	x7,0xffffc
 100011c:	bcc38393          	addi	x7,x7,-1076 # ffffbbcc <_end+0xfeff9abc>
 1000120:	14731e63          	bne	x6,x7,100027c <fail>
 1000124:	00300193          	addi	x3,x0,3
 1000128:	00000397          	auipc	x7,0x0
 100012c:	01c38393          	addi	x7,x7,28 # 1000144 <reset_vector+0x104>
 1000130:	00140313          	addi	x6,x8,1
 1000134:	00145303          	lhu	x6,1(x8)
 1000138:	0000c3b7          	lui	x7,0xc
 100013c:	bcc38393          	addi	x7,x7,-1076 # bbcc <_start-0xff4434>
 1000140:	12731e63          	bne	x6,x7,100027c <fail>
 1000144:	00400193          	addi	x3,x0,4
 1000148:	00000397          	auipc	x7,0x0
 100014c:	01c38393          	addi	x7,x7,28 # 1000164 <reset_vector+0x124>
 1000150:	00140313          	addi	x6,x8,1
 1000154:	00142303          	lw	x6,1(x8)
 1000158:	99aac3b7          	lui	x7,0x99aac
 100015c:	bcc38393          	addi	x7,x7,-1076 # 99aabbcc <_end+0x98aa9abc>
 1000160:	10731e63          	bne	x6,x7,100027c <fail>
 1000164:	00500193          	addi	x3,x0,5
 1000168:	00000397          	auipc	x7,0x0
 100016c:	01c38393          	addi	x7,x7,28 # 1000184 <reset_vector+0x144>
 1000170:	00240313          	addi	x6,x8,2
 1000174:	00242303          	lw	x6,2(x8)
 1000178:	8899b3b7          	lui	x7,0x8899b
 100017c:	abb38393          	addi	x7,x7,-1349 # 8899aabb <_end+0x879989ab>
 1000180:	0e731e63          	bne	x6,x7,100027c <fail>
 1000184:	00600193          	addi	x3,x0,6
 1000188:	00000397          	auipc	x7,0x0
 100018c:	01c38393          	addi	x7,x7,28 # 10001a4 <reset_vector+0x164>
 1000190:	00340313          	addi	x6,x8,3
 1000194:	00342303          	lw	x6,3(x8)
 1000198:	7788a3b7          	lui	x7,0x7788a
 100019c:	9aa38393          	addi	x7,x7,-1622 # 778899aa <_end+0x7688789a>
 10001a0:	0c731e63          	bne	x6,x7,100027c <fail>
 10001a4:	00600493          	addi	x9,x0,6
 10001a8:	01600193          	addi	x3,x0,22
 10001ac:	00000397          	auipc	x7,0x0
 10001b0:	03038393          	addi	x7,x7,48 # 10001dc <reset_vector+0x19c>
 10001b4:	00140313          	addi	x6,x8,1
 10001b8:	000410a3          	sh	x0,1(x8)
 10001bc:	00040303          	lb	x6,0(x8)
 10001c0:	0a030e63          	beq	x6,x0,100027c <fail>
 10001c4:	00340303          	lb	x6,3(x8)
 10001c8:	0a030a63          	beq	x6,x0,100027c <fail>
 10001cc:	00140303          	lb	x6,1(x8)
 10001d0:	0a031663          	bne	x6,x0,100027c <fail>
 10001d4:	00240303          	lb	x6,2(x8)
 10001d8:	0a031263          	bne	x6,x0,100027c <fail>
 10001dc:	01700193          	addi	x3,x0,23
 10001e0:	00000397          	auipc	x7,0x0
 10001e4:	03038393          	addi	x7,x7,48 # 1000210 <reset_vector+0x1d0>
 10001e8:	00540313          	addi	x6,x8,5
 10001ec:	000422a3          	sw	x0,5(x8)
 10001f0:	00440303          	lb	x6,4(x8)
 10001f4:	08030463          	beq	x6,x0,100027c <fail>
 10001f8:	00940303          	lb	x6,9(x8)
 10001fc:	08030063          	beq	x6,x0,100027c <fail>
 1000200:	00540303          	lb	x6,5(x8)
 1000204:	06031c63          	bne	x6,x0,100027c <fail>
 1000208:	00840303          	lb	x6,8(x8)
 100020c:	06031863          	bne	x6,x0,100027c <fail>
 1000210:	01800193          	addi	x3,x0,24
 1000214:	00000397          	auipc	x7,0x0
 1000218:	03038393          	addi	x7,x7,48 # 1000244 <reset_vector+0x204>
 100021c:	00a40313          	addi	x6,x8,10
 1000220:	00042523          	sw	x0,10(x8)
 1000224:	00940303          	lb	x6,9(x8)
 1000228:	04030a63          	beq	x6,x0,100027c <fail>
 100022c:	00e40303          	lb	x6,14(x8)
 1000230:	04030663          	beq	x6,x0,100027c <fail>
 1000234:	00a40303          	lb	x6,10(x8)
 1000238:	04031263          	bne	x6,x0,100027c <fail>
 100023c:	00d40303          	lb	x6,13(x8)
 1000240:	02031e63          	bne	x6,x0,100027c <fail>
 1000244:	01900193          	addi	x3,x0,25
 1000248:	00000397          	auipc	x7,0x0
 100024c:	03038393          	addi	x7,x7,48 # 1000278 <reset_vector+0x238>
 1000250:	00f40313          	addi	x6,x8,15
 1000254:	000427a3          	sw	x0,15(x8)
 1000258:	00e40303          	lb	x6,14(x8)
 100025c:	02030063          	beq	x6,x0,100027c <fail>
 1000260:	01340303          	lb	x6,19(x8)
 1000264:	00030c63          	beq	x6,x0,100027c <fail>
 1000268:	00f40303          	lb	x6,15(x8)
 100026c:	00031863          	bne	x6,x0,100027c <fail>
 1000270:	01240303          	lb	x6,18(x8)
 1000274:	00031463          	bne	x6,x0,100027c <fail>
 1000278:	00301c63          	bne	x0,x3,1000290 <pass>

0100027c <fail>:
 100027c:	0ff0000f          	fence	iorw,iorw
 1000280:	00018063          	beq	x3,x0,1000280 <fail+0x4>
 1000284:	00119193          	slli	x3,x3,0x1
 1000288:	0011e193          	ori	x3,x3,1
 100028c:	00000073          	ecall

01000290 <pass>:
 1000290:	0ff0000f          	fence	iorw,iorw
 1000294:	00100193          	addi	x3,x0,1
 1000298:	00000073          	ecall
 100029c:	00000013          	addi	x0,x0,0

010002a0 <mtvec_handler>:
 10002a0:	342022f3          	csrrs	x5,mcause,x0
 10002a4:	fc929ce3          	bne	x5,x9,100027c <fail>
 10002a8:	343022f3          	csrrs	x5,mtval,x0
 10002ac:	fc6298e3          	bne	x5,x6,100027c <fail>
 10002b0:	00028283          	lb	x5,0(x5)
 10002b4:	fc0284e3          	beq	x5,x0,100027c <fail>
 10002b8:	34139073          	csrrw	x0,mepc,x7
 10002bc:	30200073          	mret
 10002c0:	c0001073          	unimp
	...

Disassembly of section .tohost:

01001000 <tohost>:
	...

01001040 <fromhost>:
	...

Disassembly of section .data:

01002000 <begin_signature>:
 1002000:	ccdd                	c.beqz	x9,10020be <begin_signature+0xbe>
 1002002:	8899aabb          	0x8899aabb
 1002006:	44556677          	0x44556677
 100200a:	ee112233          	0xee112233
 100200e:	eeff                	0xeeff
 1002010:	5050                	c.lw	x12,36(x8)
 1002012:	5050                	c.lw	x12,36(x8)
 1002014:	5050                	c.lw	x12,36(x8)
 1002016:	5050                	c.lw	x12,36(x8)
 1002018:	5050                	c.lw	x12,36(x8)
 100201a:	5050                	c.lw	x12,36(x8)
 100201c:	5050                	c.lw	x12,36(x8)
 100201e:	5050                	c.lw	x12,36(x8)
 1002020:	5050                	c.lw	x12,36(x8)
 1002022:	5050                	c.lw	x12,36(x8)
 1002024:	5050                	c.lw	x12,36(x8)
 1002026:	5050                	c.lw	x12,36(x8)
 1002028:	5050                	c.lw	x12,36(x8)
 100202a:	5050                	c.lw	x12,36(x8)
 100202c:	5050                	c.lw	x12,36(x8)
 100202e:	5050                	c.lw	x12,36(x8)
 1002030:	5050                	c.lw	x12,36(x8)
 1002032:	5050                	c.lw	x12,36(x8)
 1002034:	5050                	c.lw	x12,36(x8)
 1002036:	5050                	c.lw	x12,36(x8)
 1002038:	5050                	c.lw	x12,36(x8)
 100203a:	5050                	c.lw	x12,36(x8)
 100203c:	5050                	c.lw	x12,36(x8)
 100203e:	5050                	c.lw	x12,36(x8)
 1002040:	5050                	c.lw	x12,36(x8)
 1002042:	5050                	c.lw	x12,36(x8)
 1002044:	5050                	c.lw	x12,36(x8)
 1002046:	5050                	c.lw	x12,36(x8)
 1002048:	5050                	c.lw	x12,36(x8)
 100204a:	5050                	c.lw	x12,36(x8)
 100204c:	5050                	c.lw	x12,36(x8)
 100204e:	5050                	c.lw	x12,36(x8)
 1002050:	5050                	c.lw	x12,36(x8)
 1002052:	5050                	c.lw	x12,36(x8)
 1002054:	5050                	c.lw	x12,36(x8)
 1002056:	5050                	c.lw	x12,36(x8)
 1002058:	5050                	c.lw	x12,36(x8)
 100205a:	5050                	c.lw	x12,36(x8)
 100205c:	5050                	c.lw	x12,36(x8)
 100205e:	5050                	c.lw	x12,36(x8)
 1002060:	5050                	c.lw	x12,36(x8)
 1002062:	5050                	c.lw	x12,36(x8)
 1002064:	5050                	c.lw	x12,36(x8)
 1002066:	5050                	c.lw	x12,36(x8)
 1002068:	5050                	c.lw	x12,36(x8)
 100206a:	5050                	c.lw	x12,36(x8)
 100206c:	5050                	c.lw	x12,36(x8)
 100206e:	5050                	c.lw	x12,36(x8)
 1002070:	5050                	c.lw	x12,36(x8)
 1002072:	5050                	c.lw	x12,36(x8)
 1002074:	5050                	c.lw	x12,36(x8)
 1002076:	5050                	c.lw	x12,36(x8)
 1002078:	5050                	c.lw	x12,36(x8)
 100207a:	5050                	c.lw	x12,36(x8)
 100207c:	5050                	c.lw	x12,36(x8)
 100207e:	5050                	c.lw	x12,36(x8)
 1002080:	5050                	c.lw	x12,36(x8)
 1002082:	5050                	c.lw	x12,36(x8)
 1002084:	5050                	c.lw	x12,36(x8)
 1002086:	5050                	c.lw	x12,36(x8)
 1002088:	5050                	c.lw	x12,36(x8)
 100208a:	5050                	c.lw	x12,36(x8)
 100208c:	5050                	c.lw	x12,36(x8)
 100208e:	5050                	c.lw	x12,36(x8)
 1002090:	5050                	c.lw	x12,36(x8)
 1002092:	5050                	c.lw	x12,36(x8)
 1002094:	5050                	c.lw	x12,36(x8)
 1002096:	5050                	c.lw	x12,36(x8)
 1002098:	5050                	c.lw	x12,36(x8)
 100209a:	5050                	c.lw	x12,36(x8)
 100209c:	5050                	c.lw	x12,36(x8)
 100209e:	5050                	c.lw	x12,36(x8)
 10020a0:	5050                	c.lw	x12,36(x8)
 10020a2:	5050                	c.lw	x12,36(x8)
 10020a4:	5050                	c.lw	x12,36(x8)
 10020a6:	5050                	c.lw	x12,36(x8)
 10020a8:	5050                	c.lw	x12,36(x8)
 10020aa:	5050                	c.lw	x12,36(x8)
 10020ac:	5050                	c.lw	x12,36(x8)
 10020ae:	5050                	c.lw	x12,36(x8)
 10020b0:	5050                	c.lw	x12,36(x8)
 10020b2:	5050                	c.lw	x12,36(x8)
 10020b4:	5050                	c.lw	x12,36(x8)
 10020b6:	5050                	c.lw	x12,36(x8)
 10020b8:	5050                	c.lw	x12,36(x8)
 10020ba:	5050                	c.lw	x12,36(x8)
 10020bc:	5050                	c.lw	x12,36(x8)
 10020be:	5050                	c.lw	x12,36(x8)
 10020c0:	5050                	c.lw	x12,36(x8)
 10020c2:	5050                	c.lw	x12,36(x8)
 10020c4:	5050                	c.lw	x12,36(x8)
 10020c6:	5050                	c.lw	x12,36(x8)
 10020c8:	5050                	c.lw	x12,36(x8)
 10020ca:	5050                	c.lw	x12,36(x8)
 10020cc:	5050                	c.lw	x12,36(x8)
 10020ce:	5050                	c.lw	x12,36(x8)
 10020d0:	5050                	c.lw	x12,36(x8)
 10020d2:	5050                	c.lw	x12,36(x8)
 10020d4:	5050                	c.lw	x12,36(x8)
 10020d6:	5050                	c.lw	x12,36(x8)
 10020d8:	5050                	c.lw	x12,36(x8)
 10020da:	5050                	c.lw	x12,36(x8)
 10020dc:	5050                	c.lw	x12,36(x8)
 10020de:	5050                	c.lw	x12,36(x8)
 10020e0:	5050                	c.lw	x12,36(x8)
 10020e2:	5050                	c.lw	x12,36(x8)
 10020e4:	5050                	c.lw	x12,36(x8)
 10020e6:	5050                	c.lw	x12,36(x8)
 10020e8:	5050                	c.lw	x12,36(x8)
 10020ea:	5050                	c.lw	x12,36(x8)
 10020ec:	5050                	c.lw	x12,36(x8)
 10020ee:	5050                	c.lw	x12,36(x8)
 10020f0:	5050                	c.lw	x12,36(x8)
 10020f2:	5050                	c.lw	x12,36(x8)
 10020f4:	5050                	c.lw	x12,36(x8)
 10020f6:	5050                	c.lw	x12,36(x8)
 10020f8:	5050                	c.lw	x12,36(x8)
 10020fa:	5050                	c.lw	x12,36(x8)
 10020fc:	5050                	c.lw	x12,36(x8)
 10020fe:	5050                	c.lw	x12,36(x8)
 1002100:	5050                	c.lw	x12,36(x8)
 1002102:	5050                	c.lw	x12,36(x8)
 1002104:	5050                	c.lw	x12,36(x8)
 1002106:	5050                	c.lw	x12,36(x8)
 1002108:	5050                	c.lw	x12,36(x8)
 100210a:	5050                	c.lw	x12,36(x8)
 100210c:	5050                	c.lw	x12,36(x8)
 100210e:	0050                	c.addi4spn	x12,x2,4

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	3241                	c.jal	fffff980 <_end+0xfeffd870>
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
  1a:	326d                	c.jal	fffff9c4 <_end+0xfeffd8b4>
  1c:	3070                	c.fld	f12,224(x8)
  1e:	615f 7032 5f30      	0x5f307032615f
  24:	3266                	c.fldsp	f4,120(x2)
  26:	3070                	c.fld	f12,224(x8)
  28:	645f 7032 5f30      	0x5f307032645f
  2e:	30703263          	0x30703263
	...

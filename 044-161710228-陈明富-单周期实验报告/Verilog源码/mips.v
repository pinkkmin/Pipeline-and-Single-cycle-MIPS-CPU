/////////////////////////////////////////////////////////////////////////
// 单位: 南京航空航天大学-计算机科学与技术学院
// 作者:陈明富
//
// Create Date:   2019/7/4
// Design Name:   单周期COU
// Module Name: mips.v
/////////////////////////////////////////////////////////////////////////
module mips(clk, rst) ;
input clk ; // clock
input rst ;// reset

//PC
wire PCWre;
wire[31:2] PC,NPC;
//RF
wire RegWr,RegDst,ShfOp,BitOp;
wire[31:0] busW;
wire[31:0]  busA,busB,ALUA,ALUB;

//ALU
wire ALUsrc,Zero,ExtOp,SF,OF,CF,cout,cin; //选择立即数或busB(Rt)
wire[4:0]ALUOp; 
wire DMop,Bitop;
wire[31:0] Result;
wire[31:0] Dataout;
//DM
wire MemWr, MemtoReg;
wire Branch,Jump;

wire [31:0] dout;
wire [5:0]  op,func;
wire [4:0]  rs,rt,rd,rw,shf,Rt;
wire [15:0] imm16;
wire [25:0] target;
wire[31:0] imm32,shf32;

PC pc(clk,rst,PCWre,NPC,PC);
im_4k im(PC,dout);
NPC npc(PC,Zero,Branch,Jump,target,imm16,NPC);

assign op = dout[31:26];
assign func = dout[5:0];
assign rs = dout[25:21];
assign rt = dout[20:16];
assign rd = dout[15:11];
assign shf = dout[10:6];//逻辑左右移，算术右移的shf
assign imm16 = dout[15:0];
assign target = dout[25:0];

SignExtend5 ex5(ExtOp,shf,shf32); //逻辑左右移和算术右移时，5位的shf扩展为32位，
SignExtend16 ex(ExtOp,imm16,imm32); //16位立即数的扩展
Ctrl Ctrl(op,func,rt,Zero,PCWre,ALUsrc,RegWr,RegDst,MemtoReg,MemWr,ExtOp,cin,Branch,Jump,ALUOp,DMop,Bitop,ShfOp);
Mux2_5 mux5(RegDst,rt,rd,rw);//选择写的寄存器
RF rf(clk,RegWr,rw,rs,rt,busW ,busA,busB);
Mux2_32 mux32(ALUsrc,busB,imm32,ALUB); //选择ALU输入端
Mux2_32 muxshfA(ShfOp,busA,shf32,ALUA); //shfop标志在此，正常指令选择busA，特殊的逻辑左右移选择传送至ALU输入端
Alu  alu(ALUA,ALUB,ALUOp,cin,Result,cout,OF,SF,Zero,CF);
dm_4k dm( Result,DMop,BitOp,busB, MemWr, clk,Dataout ) ;
Mux2_32 mux(MemtoReg,Result,Dataout,busW);
endmodule

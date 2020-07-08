/////////////////////////////////////////////////////////////////////////
// 单位: 南京航空航天大学-计算机科学与技术学院
// 作者:陈明富
//
// Create Date:   2019/7/4
// Design Name:   单周期COU
// Module Name: NPC.v
/////////////////////////////////////////////////////////////////////////
module NPC(PC,Zero,Branch,Jump,target,imm16,Npc);
input        Zero;
input        Branch;
input        Jump;
input [31:2] PC;
input [15:0] imm16;
input [25:0] target;
output[31:2] Npc;
wire  [31:0] imm32;
wire  [31:2] JNPC;
wire  [31:2] BNPC;
wire  [31:2] NNPC;

SignExtend extnpc(1,imm16,imm32);
assign BNPC = PC+1+imm32[29:0];
assign JNPC = {PC[31:28],target};
assign NNPC =  PC + 1;
assign Npc  = Jump?JNPC:((Branch&Zero)?BNPC:NNPC);
endmodule



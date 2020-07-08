/////////////////////////////////////////////////////////////////////////
// 单位: 南京航空航天大学-计算机科学与技术学院
// 作者:陈明富
//
// Create Date:   2019/7/4
// Design Name:   单周期COU
// Module Name: PC.v
/////////////////////////////////////////////////////////////////////////
module PC(CLK,Reset,PCWre,NPC,PC);
    input CLK;                // 时钟
    input Reset;              // 重置信号
    input PCWre;              // PC是否更改，如果为0，PC不更改
    input [31:2] NPC;         // PC指令地址
    output reg[31:2] PC ;         
	initial begin
		PC <= 30'b0000_0000_0000_0000_0011_0000_0000_000;
	end
	
	always@(posedge CLK or posedge Reset)
	 begin
		if (Reset == 1)  PC <= 30'b0000_0000_0000_0000_0011_0000_0000_00;  
		else 
		 begin
			if (PCWre)  PC <= NPC;
			else  PC <= PC;
		 end
	 end
endmodule
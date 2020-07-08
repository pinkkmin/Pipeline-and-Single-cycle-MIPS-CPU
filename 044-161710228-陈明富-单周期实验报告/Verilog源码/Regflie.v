/////////////////////////////////////////////////////////////////////////
// 单位: 南京航空航天大学-计算机科学与技术学院
// 作者:陈明富
//
// Create Date:   2019/7/4
// Design Name:   单周期COU
// Module Name: regfile.v
/////////////////////////////////////////////////////////////////////////
module RF(clk,WEn,RW,RA,RB,busW,busA,busB);
input clk,WEn;
input[4:0] RW,RA,RB;
input[31:0] busW;
output[31:0] busA,busB;
reg[31:0]  regfile[0:31];
integer i;
	initial 
	 begin
		for(i = 0; i < 1631; i = i + 1)  regfile[i] <= 0;
	 end
assign busA = regfile[RA];
assign busB = regfile[RB] ;
always@(posedge clk )
 if(WEn) regfile[RW] <= busW;
endmodule

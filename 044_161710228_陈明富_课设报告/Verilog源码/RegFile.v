module RF(clk,WEn,RW,RA,RB,busW,busA,busB);
input clk,WEn;
input[4:0] RW,RA,RB;
input[31:0] busW;
output [31:0]  busA,busB;
reg[31:0]  regfile[0:31];
integer i;
	initial 
	 begin
		for(i = 0; i < 31; i = i + 1)  regfile[i] <= 0;
	 end
///时钟下降沿到来写
////先写后读
always@(clk )
  begin
     if(WEn) 
	 regfile[RW] <= busW;
    end
  assign busA = regfile[RA];
  assign  busB = regfile[RB] ;
endmodule
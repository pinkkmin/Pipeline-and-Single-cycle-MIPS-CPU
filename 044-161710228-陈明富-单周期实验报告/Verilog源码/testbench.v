/////////////////////////////////////////////////////////////////////////
// 单位: 南京航空航天大学-计算机科学与技术学院
// 作者:陈明富
//
// Create Date:   2019/7/4
// Design Name:   单周期COU
// Module Name: testbench.v
/////////////////////////////////////////////////////////////////////////
module testbench();
reg CLK;
reg Reset;
mips mip(CLK,Reset);
initial begin
		// Initialize Inputs
		CLK = 0;
		Reset = 1;
		#50; // 刚开始设置pc为0
         CLK = !CLK;  // 下降沿，使PC先清零
        Reset = 0;  // 清除保持信号
      forever #50
		 begin // 产生时钟信号，周期为50s
         CLK = !CLK;
         end
        end
endmodule

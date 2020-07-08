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

module PC(CLK,reset,bubble,NPC,PC);
    input CLK;                // 时钟
    input reset;              // 重置信号
    input bubble;             // 阻塞信号
    input [31:2] NPC;         // PC指令地址
    output reg[31:2] PC ;         
	initial begin
		PC <= 32'h0000_3000;
	end
	
	always@(posedge CLK)
	 begin
		if (reset == 1)  PC <= 32'h0000_3000;
		else 
		 begin
			if (bubble)  PC <= PC;  //阻塞PC地址保持不变
			else  PC <= NPC;
		 end
	 end
endmodule

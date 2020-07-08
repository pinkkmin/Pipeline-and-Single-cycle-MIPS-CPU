/* 课本P211
需要实现的三个操作：
1.将ID/EX寄存器的控制信号清零
2.保持IF/ID寄存器的的值不变，在下一个时钟到来重新进行译码
3.保持PC的值不变，使得Load后面的第二条指令在下一时钟周期重新取指令
*/
//冒险产生的结果
//保持PC不变 pc_stall = 1
//清空ID/EX IDEX_flush = 1
//保持IFID不变 IFID_stall = 1
module Load_use(IDEX_MemRead,IFID_rt,IFID_rs,IDEX_rt,pc_stall,IFID_stall,IDEX_flush);
input IDEX_MemRead;
input [4:0]IFID_rt,IFID_rs,IDEX_rt;
output reg pc_stall;
output reg IFID_stall;
output reg IDEX_flush;

always @(1) 
begin
	   if((IDEX_MemRead==1&&(IDEX_rt==IFID_rs||IDEX_rt==IFID_rt)))
	     begin
            pc_stall= 1;
	        IFID_stall = 1;
	        IDEX_flush = 1;
	     end
	   else
	    begin
           pc_stall= 0;
	       IFID_stall = 0;
	       IDEX_flush = 0;
		end
end
endmodule
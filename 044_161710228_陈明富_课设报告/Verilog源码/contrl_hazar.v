//处理分支跳转指令
/*Branch & Jump
bne  beq
bgez bgtz blez bltz
J
*/
module Ctrl_Hazar(clk,Sign,Jump,pc_stall,IFID_flush);
input   clk;
input   Sign; ///Branch 地址跳转条件
input   Jump;
output  reg pc_stall;//清空信号
output  reg IFID_flush;

initial begin 
        pc_stall = 0; 
        IFID_flush = 0;
        end 

always @(1) 
begin
      //jump flush
	   if(Jump==1||Sign==1)   //或者Branch满足跳转
	       begin 
             pc_stall = 1;  
             IFID_flush = 1;/// IFID——flush 
           end
        else 
        begin 
        pc_stall = 0; 
        IFID_flush = 0;
        end 
end
endmodule
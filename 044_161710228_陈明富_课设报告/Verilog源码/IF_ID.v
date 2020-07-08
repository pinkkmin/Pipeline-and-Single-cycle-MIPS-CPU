module IFID (clk,flush,stall,pc_in ,inst_in, pc_out,inst_out);
input         clk;
input         flush;//清空
input         stall;
input  [31:0] pc_in; // 当前取指令地址
input   [31:0] inst_in;//
output reg [31:0] pc_out;  //下一条指令地址
output reg[31:0] inst_out;//
   
reg [31:0]pc;
reg [31:0] inst;
 always @(posedge clk ) 
    begin
     if(flush==1)
       begin 
           pc <=0;
          inst <= 0;
       end
      else if(stall==1)
        begin
           inst_out <= inst;
           pc_out<= pc;
         end
      else
        begin
           pc = pc_in;
           inst = inst_in;
           inst_out <= inst_in;
           pc_out <= pc_in;
        end 
   end 
endmodule
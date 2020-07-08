//转发主要解决
//采用助教文档中的案例
//从Reg寄存器中读取数据，数据还未被写入，即读取的是旧值
module DataHazard(Mem_RegWr, Wr_RegWr,MemtoReg,Mem_Rw, Ex_Rs, Ex_Rt, Wr_Rw,
                  Ex_ALUSrc, Ex_imm32, Ex_busA, Ex_busB, Mem_Result,Wr_Result, Wr_din,
                  A, B);
input         Mem_RegWr, Wr_RegWr,MemtoReg, Ex_ALUSrc;
input  [4:0]  Mem_Rw, Ex_Rs, Ex_Rt, Wr_Rw;
input [31:0]  Ex_imm32; // 立即数
input [31:0]  Ex_busA;  
input [31:0]  Ex_busB;
input [31:0]  Mem_Result,Wr_Result; 
input [31:0]  Wr_din;
output [31:0] A, B; //ALU的A和B输入端口
wire          C1A, C1B, C2A, C2B,B2;
wire  [31:0]  busB;
reg    [1:0]  ALUSrcA, ALUSrcB;
initial 
begin
    ALUSrcA = 0;
    ALUSrcB = 0;
end
assign C1A = Mem_RegWr&&(Mem_Rw != 0)&&(Mem_Rw == Ex_Rs)||Wr_RegWr&&(Mem_Rw != 0)&&(Mem_Rw == Ex_Rs);  //选择Result
assign C1B = Wr_RegWr&&(Mem_Rw != 0)&&(Mem_Rw == Ex_Rt)|| Mem_RegWr&&(Mem_Rw != 0)&&(Mem_Rw == Ex_Rt); // 选择Result
/*注意到此处助教给出代码的不足
C1B判定条件
原： Wr_RegWr&&(Mem_Rw != 0)&&(Mem_Rw == Ex_Rt)
修改后：Wr_RegWr&&(Mem_Rw != 0)&&(Mem_Rw == Ex_Rt)|| Mem_RegWr&&(Mem_Rw != 0)&&(Mem_Rw == Ex_Rt)
*/
assign C2A = MemtoReg&&(Wr_Rw != 0)&&(Mem_Rw != Ex_Rs)&&(Wr_Rw == Ex_Rs); //选择DM_out
assign C2B = MemtoReg&&(Wr_Rw != 0)&&(Mem_Rw != Ex_Rt)&&(Wr_Rw == Ex_Rt); //选择DM_out
assign  B2 = Wr_RegWr&&(Wr_Rw==Ex_Rt);  
always@(C1A or C2A)
begin
   if (C1A !=1 && C2A != 1) ALUSrcA <= 2'b00;
   if (C1A == 1) ALUSrcA <= 2'b01;
   if (C2A == 1) ALUSrcA <= 2'b10; 
end
always@(C1B or C2B)
begin
    if (C1B != 1 && C2B != 1) ALUSrcB <= 2'b00;
    if (C1B == 1) ALUSrcB <= 2'b01;
    if (C2B == 1) ALUSrcB <= 2'b10;
end
assign A = (ALUSrcA == 2'b00) ? Ex_busA :(ALUSrcA == 2'b01) ? Mem_Result :(ALUSrcA == 2'b10) ? Wr_din : 0 ;
/*ALU输入A端：
 00 正常情况，选择Ex_busA，不发生数据冒险
 01 选择 Mem_Result
 10 选择Wr_din 即从Dm中读取出的数据，这时候应该 MemtoReg = 1
*/
assign busB = B2 ?Wr_Result: Ex_busB;
assign B = Ex_ALUSrc ? Ex_imm32 :((ALUSrcB == 2'b00) ? busB:((ALUSrcB == 2'b01) ? Mem_Result :((ALUSrcB == 2'b10) ?  Wr_din : 0)));
endmodule

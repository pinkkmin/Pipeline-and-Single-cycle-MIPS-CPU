
/////////////////////////////////////////////////////////////////////////
// 单位: 南京航空航天大学-计算机科学与技术学院
// 作者:陈明富
//
// Create Date:   2019/7/4
// Design Name:   单周期COU
// Module Name: ALU.v
/////////////////////////////////////////////////////////////////////////


module Alu(A,B,ALUop,cin,Result,cout,OF,SF,ZF,CF);
input[31:0] A,B;
input[4:0] ALUop;
input cin;
output[31:0] Result;
reg[31:0] Result;
reg[30:0] sum_1;
reg Cn_1;
output reg  cout,OF,SF,ZF,CF;
always@(ALUop or A or B)
begin
  case (ALUop)
   5'b00000: {cout,Result} = A+B+cin;                         // addu 1
   5'b00001: Result =  $signed(A) < 32'b0 ? 1:0;              // bgez 2 大于或等于0跳转(小于，zero标志为1)
   5'b00010: {cout,Result }= A-B-cin;                         // sub,subu,beq 3
   5'b00011: Result =  $signed(A)>0 ? 0:1;                    // bgtz  4大于0跳转 
   5'b00100: Result = ($unsigned(A)<$unsigned(B))?1:0;        // sltu 5
   5'b00101: Result = ($signed(A)<$signed(B))?1:0;            // slt  6
   5'b00110: Result = A&B;                                    // and  7
   5'b00111: Result = ~(A|B);                                 // nor  8
   5'b01000: Result = A|B;                                    // or   9
   5'b01001: Result = A^B;                                    // xor  10
   5'b01010: Result = B<<A;                                   // sll 和 sllv  11
   5'b01100: Result = $signed(B)>>A;                          // sra和srav,srl 12
   5'b01110: Result = $unsigned(B)>>A;                        // srlv 13
   5'b01101: Result =  $signed(A) > 0 ? 1:0;                  // blez 14 小于或等于0跳转
   5'b01111: Result =  $signed(A)<0 ? 0:1;                    // bltz 15 小于0跳转   
   5'b01011: Result = B<<32'b0000_0000_0000_0000_0000_0000_0001_0000;// lui  16 
   5'b11111: Result =  A!= B ? 0:1;                           // bne  17 
  endcase                       
{Cn_1,sum_1} = A[30:0] + B[30:0];
OF = cout^Cn_1;
CF = cout^cin;
SF = Result[31];
ZF =(Result)?0:1 ;
end
endmodule


module Alu(A,B,ALUop,shf,Result,Zero);
input[31:0]  A,B;
input[4:0]   ALUop;
input [4:0]  shf; //移位
output[31:0] Result;
reg[31:0]    Result;
output reg   Zero; //0标识
initial
begin
 Zero = 0;
end
always@(ALUop or A or B)
begin
  case (ALUop)
   5'b00000: Result = A+B;                                    // addu 
   5'b00001: Result =  $signed(A) < 32'b0 ? 1:0;              // bgez 大于或等于0跳转(小于，zero标志为1)
   5'b00010: Result= A-B;                                     // sub,subu,beq 
   5'b00011: Result =  $signed(A)>0 ? 0:1;                    // bgtz  大于0跳转 
   5'b00100: Result = ($unsigned(A)<$unsigned(B))?1:0;        // sltu 
   5'b00101: Result = ($signed(A)<$signed(B))?1:0;            // slt  
   5'b00110: Result = A&B;                                    // and  
   5'b00111: Result = ~(A|B);                                 // nor  
   5'b01000: Result = A|B;                                    // or   
   5'b01001: Result = A^B;                                    // xor  
   5'b01010: Result = B<<shf;                                 // sll 
   5'b01011: Result = B<<A;                                   // sllv  
   5'b01100: Result = $signed(B)>>shf;                        // sra,srl 
   5'b01101: Result = $signed(B)>>A;                          // srav
   5'b01110: Result = $unsigned(B)>>A;                        // srlv 
   5'b01111: Result =  $signed(A) > 0 ? 1:0;                  // blez  小于或等于0跳转
   5'b10000: Result =  $signed(A)<0 ? 0:1;                    // bltz 小于0跳转   
   5'b10001: Result = B<<5'b10000;                            // lui 左移16位
   5'b10010: Result =  A!= B ? 0:1;                           // bne  
   5'b10010: Result =  A;                                     // jalr,jr 
  endcase                       
Zero =(Result)?0:1 ;
end
endmodule

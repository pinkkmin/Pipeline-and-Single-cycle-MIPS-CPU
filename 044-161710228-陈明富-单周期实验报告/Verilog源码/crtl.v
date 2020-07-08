/////////////////////////////////////////////////////////////////////////
// 单位: 南京航空航天大学-计算机科学与技术学院
// 作者:陈明富
//
// Create Date:   2019/7/4
// Design Name:   单周期COU
// Module Name: ctrl.v
/////////////////////////////////////////////////////////////////////////
module Ctrl(
    input [5:0] op,  
    input [5:0] func,   
    input [4:0] rt,  //用于区别 bltz与bgez
    input zero,     //ALU的0判断    
  
    output reg PCWre,     //PC地址更改使能 
    output reg ALUSrc,    //ALU选择    
    output reg RegWr,     //Regfile写使能
    output reg RegDst,    //Regfile写地址选择，rd or rt   
    output reg MemtoReg,  //写回结果内容选择  
    output reg MemWr,     //存储器写使能 
    output reg ExtOp,     //符号扩展
    output  reg cin,
    output reg Branch,  
    output reg Jump,                
    output reg [4:0] ALUOp, //ALU操作 
    output reg DMop,
    output reg Bitop,
    output reg ShfOp//逻辑左友移，算术右移的标识
); 
  always@(func or zero)
            begin
             case(func)
             6'b100001://addu  1    无符号加 已解决
              begin   
				     ALUOp = 5'b00000;
                 ShfOp = 0;
			     end
             6'b100000://add   2    加法 已解决
              begin     
				     ALUOp = 5'b00000;
                 ShfOp = 0;
			      end
             6'b100011://subu  3    无符号减法 已解决
              begin
                 ALUOp = 5'b00010;
                 ShfOp = 0;
              end
             6'b100010://sub   4    减法  已解决
               begin
                 ALUOp = 5'b00010;
                 ShfOp = 0;
               end
             6'b101011://sltu  5    无符号小于置位 已解决
               begin
                  ALUOp = 5'b00100;
                  ShfOp = 0;
               end
             6'b101010://slt   6    小于置位 已解决
               begin
                  ALUOp = 5'b00101;
                  ShfOp = 0;
               end
             6'b100100://and   7    按位与 已解决
               begin
                   ALUOp = 5'b00110;
                  ShfOp = 0;
               end
             6'b100111://nor   8    按位或非  已解决
               begin
                  ALUOp = 5'b00111;
                  ShfOp = 0;
               end
             6'b100101://or    9    按位或 已解决
             begin
             ALUOp =5'b01000;
                ShfOp = 0;
             end
             6'b100110://xor   10   按位异或  已解决
              begin
                    ALUOp =5'b01001;
                    ShfOp = 0;
               end
             6'b000000://sll   11   逻辑左移  已解决
               begin
                    ALUOp =5'b01010;
                    ShfOp = 1;
               end 
             6'b000010://srl   12   逻辑右移   已解决
               begin
                   ALUOp =5'b01100;
                   ShfOp = 1;
               end
             6'b000011://sra   13   算术右移  已解决
               begin
                  ALUOp =5'b01100;
                  ShfOp = 1;
                end
             6'b000100://sllv   14   变量逻辑左移  已解决
               begin
                   ALUOp =5'b01010;
                   ShfOp = 0;
                end
             6'b000110://srlv   15   变量逻辑右移  已解决
               begin
                  ALUOp =5'b01110;
                  ShfOp = 0;
               end
             6'b000111://srav   16   变量算术右移  已解决
               begin
                   ALUOp =5'b01100;
                   ShfOp = 0;
               end
            6'b001000://jr  17   跳转寄存器  已解决
               begin
                  // ALUOp =4'b1100;
                   ShfOp = 0;
               end
             6'b001001://jalr  18   跳转寄存器并链接  已解决
               begin
                   //ALUOp =4'b1100;
                   ShfOp = 0;
               end
           endcase
        end
always@(op or zero )
    begin  
      case(op) 
			// R型指令
	 6'b000000:
            begin
                PCWre = 1;
              	 ALUSrc = 0;
			       RegDst = 1 ; 
				    RegWr = 1;
				    MemWr = 0;
				    MemtoReg = 0;
                Branch = 0;
                Jump = 0;
            end
    6'b001000://addi 已解决
    begin
      RegWr = 1;
      PCWre = 1;
      RegDst = 0;
      ALUSrc = 1;
	   MemWr = 0;
	   MemtoReg = 0;
	   ExtOp = 1;
      cin = 0;
      ShfOp = 0;
      Jump = 0;
      Branch = 0;
	   ALUOp = 5'b00000;
    end
    6'b001001://addiu 已解决
    begin
      RegWr = 1;
      PCWre = 1;
      RegDst = 0; // rt
      ALUSrc = 1;
	   MemWr = 0;
	   MemtoReg = 0;
      ShfOp = 0;
	   ExtOp = 1;
      cin = 0;
      Jump = 0;
      Branch = 0;
	   ALUOp = 5'b00000;
    end
    6'b001100://andi  已解决
    begin
     PCWre = 1;
     RegWr = 1;
     RegDst = 0;
     ALUSrc = 1;
     MemWr = 0;
     MemtoReg = 0;
     ExtOp = 0;
     ShfOp = 0;
     cin = 0;
     Jump = 0;
     Branch = 0; 
     ALUOp = 5'b00110;//and
    end
    6'b001101://ori  已解决
     begin
     PCWre = 1;
     RegWr = 1;
     RegDst = 0;
     ALUSrc = 1;
     MemWr = 0;
     MemtoReg = 0;
     ExtOp = 0;
     ShfOp = 0;
     cin = 0;
     Jump = 0;
     Branch = 0;
     ALUOp = 5'b01000;//or
     end
     6'b001110://xori  已解决
     begin
     PCWre = 1;
     RegWr = 1;
     RegDst = 0;
     ALUSrc = 1;
     MemWr = 0;
     MemtoReg = 0;
     ExtOp = 0;
     ShfOp = 0;
     cin = 0;
     Jump = 0;
     Branch = 0;
     ALUOp = 5'b01001;//xor
     end
    6'b100011://lw  已解决
    begin
       RegWr = 1;
       PCWre = 1;
       RegDst = 0;
       ALUSrc = 1;
	    MemWr = 0;
       ShfOp = 0;
	    MemtoReg = 1;
	    ExtOp = 1;
       cin = 0;
       Jump = 0;
       Branch = 0;
	    ALUOp = 5'b00000;
       DMop  = 1;
    end
    6'b101011://sw  已解决
    begin
       RegWr = 0;
       PCWre = 1;
       ALUSrc = 1;
	    MemWr = 1;
	    ExtOp = 1;
       cin = 0;
       ShfOp = 0;
       Jump = 0;
       Branch = 0;
	    ALUOp = 5'b00000;
       DMop = 1;
    end
     6'b001111://lui  已解决
     begin
       PCWre = 1;
       RegWr = 1;
       RegDst = 0;
       ALUSrc = 1;
	    MemWr = 0;
       ShfOp = 0;
       MemtoReg = 0; 
	    ExtOp = 0;
       cin = 0;
       Jump = 0;
       Branch = 0;
       ALUOp = 5'b01011;
     end
     6'b100100://lbu
    begin
       PCWre = 1;
       RegWr = 1;
       RegDst = 0;
       ALUSrc = 1;
	    MemWr = 0;
       ShfOp = 0;
	    ExtOp = 1;
       cin = 0;
       Jump = 0;
       Branch = 0;
	    ALUOp = 5'b00000;
       DMop  = 0;
       Bitop = 0;
    end
    6'b100000://lb
    begin
       PCWre = 1;
       RegWr = 1;
       RegDst = 0;
       ShfOp = 0;
       ALUSrc = 1;
	    MemWr = 0;
	    ExtOp = 1;
       cin = 0;
       Jump = 0;
       Branch = 0;
	    ALUOp = 5'b00000;
       DMop  = 0;
       Bitop = 1;
    end
    6'b101000://sb
    begin
       RegWr = 0;
       PCWre = 1;
       ALUSrc = 1;
	    MemWr = 1;
       ShfOp = 0;
	    ExtOp = 1;
       cin = 0;
       Jump = 0;
       Branch = 0;
	    ALUOp = 5'b00000;
       DMop = 0;
    end
    6'b001010://slti 已解决
      begin
        PCWre = 1;
        RegWr = 1;
        RegDst = 0;
        ExtOp = 1;
        ShfOp = 0;
        MemWr = 0;
        MemtoReg = 0;
        ALUSrc = 1;
        cin = 0;
        Jump = 0;
        Branch = 0;
        ALUOp = 5'b00101;
      end
      6'b001011://sltiu  已解决
      begin
        PCWre = 1;
        RegWr = 1;
        RegDst = 0;
        ExtOp = 1;
        ShfOp = 0;
        MemWr = 0;
        MemtoReg = 0;
        ALUSrc = 1;
        cin = 0;
        Jump = 0;
        Branch = 0;
        ALUOp = 5'b00100;
      end
    6'b000001://bgez区别  已解决
    if(rt==5'b00001)
    begin
    PCWre = 1;
    RegWr = 0;
    ALUSrc = 0;
    MemWr = 0;
    ShfOp = 0;
    ALUOp = 5'b00001;
    Branch = 1;
    cin = 0;
    Jump = 0;
    end
    else //bltz区别  已解决
    begin
    PCWre = 1;
    RegWr = 0;
    ALUSrc = 0;
    MemWr = 0;
    Branch = 1;
    ShfOp = 0;
    cin = 0;
    ALUOp = 5'b01111;
    Jump = 0; 
    end
    6'b000111://bgtz 已解决
    begin
    PCWre = 1;
    RegWr = 0;
    ALUSrc = 0;
    MemWr = 0;
    ShfOp = 0;
    Branch = 1;
    cin = 0;
    ALUOp = 5'b00011;
    Jump = 0;
    end
     6'b000110://blez 已解决
    begin
    PCWre = 1;
    RegWr = 0;
    ALUSrc = 0;
    MemWr = 0;
    ShfOp = 0;
    Branch = 1;
    cin = 0;
    ALUOp = 5'b01101;
    Jump = 0;
    end
    6'b000100://beq  已解决
    begin
       RegWr = 0;
       PCWre = 1;
       RegDst = 0;
       ALUSrc = 0;
	    MemWr = 0;
       Branch = 1;
       ShfOp = 0;
       cin = 0;
       Jump = 0;
	    ALUOp = 5'b00010;
    end
       6'b000101:   // bne 已解决
       begin
       RegWr = 0;
       PCWre = 1;
       RegDst = 0;
       ALUSrc = 0;
	    MemWr = 0;
       Branch = 1;
       ShfOp = 0;
       cin = 0;
       Jump = 0;
	    ALUOp = 5'b11111;
       end
     6'b000010://j  已解决
    begin
       RegWr = 0;
       PCWre = 1;
       ALUSrc = 0;
	    MemWr = 0;
       Branch = 0;
       ShfOp = 0;
       cin = 0; 
       Jump = 1;
    end
      endcase
	end
endmodule
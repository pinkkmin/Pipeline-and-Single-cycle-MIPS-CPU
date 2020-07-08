`include "define_op.v"
module Ctrl(op,func,rt,ALUSrc,RegWr,RegDst,MemtoReg,MemWr,MemRead,Extop,Branch,Jump,Bitop,ALUop);
    input [5:0] op;  
    input [5:0] func;   
    input [4:0] rt;  //用于区别 bltz与bgez 
  
    output reg ALUSrc;    //ALU选择    
    output reg RegWr;    //Regfile写使能
    output reg RegDst;    //Regfile写地址选择，rd or rt   
    output reg MemtoReg; //写回结果内容选择  
    output reg MemWr;   //存储器写使能 
    output reg MemRead;
    output reg Extop;    //符号扩展
    output reg Branch;  
    output reg Jump;        
    output reg Bitop;    //DM的字节   
    output reg [4:0] ALUop; //ALU操作 
initial
begin Branch = 0;  
      Jump  = 0 ;
      Bitop  =0;
end
always@(op or func )
begin    
      Branch = 0;  
      Jump  = 0 ;
      Bitop  =0;
      MemRead = 0;
	 case(op)
		  `RTYPE: //R型指令 000000
		   begin
      ALUSrc = 0;
			RegDst = 1 ; 
			MemWr = 0;
			MemtoReg = 0;
            Branch = 0;
            Jump = 0;
            Bitop = 0;
		    case(func)
              `ADD_func:   //6'b100000
                  begin
                  RegWr = 1;
                  ALUop = 5'b00000;
                  end
              `ADDU_func :   //6'b100001
                  begin
                  RegWr = 1;
                  ALUop = 5'b00000;
                  end
              `SUB_func  :   //6'b100010
                  begin
                  RegWr = 1;
                  ALUop = 5'b00010;
                  end
              `SUBU_func :   //6'b100011
                  begin
                  RegWr = 1;
                  ALUop = 5'b00010;
                  end
              `AND_func  :   //6'b100100
                  begin
                  RegWr = 1;
                  ALUop = 5'b00110;
                  end
              `NOR_func  :   //6'b100111
                  begin
                  RegWr = 1;
                  ALUop = 5'b00111;
                  end
              `OR_func   :   //6'b100101
                  begin
                  RegWr = 1;
                  ALUop = 5'b01000;
                  end
              `XOR_func  :   //6'b100110
                  begin
                  RegWr = 1;
                  ALUop = 5'b01001;
                  end
              `SLT_func  :   //6'b101010
                  begin
                  RegWr = 1;
                  ALUop = 5'b00101;
                  end
              `SLTU_func :  //6'b101011
                  begin
                  RegWr = 1;
                  ALUop = 5'b00100;
                  end
              `SLL_func  :  //6'b000000
                  begin
                  RegWr = 1;
                  ALUop = 5'b01010;
                  end
              `SRL_func  :   //6'b000010
                  begin
                  RegWr = 1;
                  ALUop = 5'b01100;
                  end
              `SRA_func  :   //6'b000011
                  begin
                  RegWr = 1;
                  ALUop = 5'b01100;
                  end
              `SLLV_func :   //6'b000100
                  begin
                  RegWr = 1;
                  ALUop = 5'b01011;
                  end
              `SRLV_func :   //6'b000110
                  begin
                  RegWr = 1;
                  ALUop = 5'b01110;
                  end
              `SRAV_func :  //6'b000111  
                  begin
                  RegWr = 1;
                  ALUop = 5'b01101;
                  end    
             // `JR_func   :   //6'b001000
             // `JALR_func :   //6'b001001 
             default:;
        endcase
		    end
          `ADDI ://addi 6'b001000
            begin
            RegWr = 1;
            RegDst = 0;
            ALUSrc = 1;
	        MemWr = 0;
	        MemtoReg = 0;
	        Extop = 1;
            Jump = 0;
            Branch = 0;
	        ALUop = 5'b00000;
            end

          `ADDIU://addiu  6'b001001
            begin
            RegWr = 1;
            RegDst = 0; // rt
            ALUSrc = 1;
	          MemWr = 0;
	          MemtoReg = 0;
	          Extop = 1;
            Jump = 0;
            Branch = 0;
	          ALUop = 5'b00000;
            end
          
          `ANDI://andi 6'b001100
            begin
            RegWr = 1;
            RegDst = 0;
            ALUSrc = 1;
            MemWr = 0;
            MemtoReg = 0;
            Extop = 0;
            Jump = 0;
            Branch = 0; 
            ALUop = 5'b00110;//and
            end

          `ORI://ori  6'b001101 
            begin
            RegWr = 1;
            RegDst = 0;
            ALUSrc = 1;
            MemWr = 0;
            MemtoReg = 0;
            Extop = 0;
            Jump = 0;
            Branch = 0;
            ALUop = 5'b01000;//or
            end
            
          `XORI://xori 6'b001110
            begin
            RegWr = 1;
            RegDst = 0;
            ALUSrc = 1;
            MemWr = 0;
            MemtoReg = 0;
            Extop = 0;
            Jump = 0;
            Branch = 0;
            ALUop = 5'b01001;//xor
            end

          `LW ://lw  6'b100011
            begin
            RegWr = 1;
            RegDst = 0;
            ALUSrc = 1;
            MemWr = 0;
            MemRead = 1;
            MemtoReg = 1;
            Extop = 1;
            Jump = 0;
            Branch = 0;
            ALUop = 5'b00000;
            Bitop  = 0;
            end

          `SW://sw 6'b101011
            begin
            RegWr = 0;
            ALUSrc = 1;
            MemWr = 1;
            MemtoReg = 0;
            Extop = 1;
            Jump = 0;
            Branch = 0;
            ALUop = 5'b00000;
            Bitop = 0;
            end

          `LUI://lui  6'b001111
            begin
            RegWr = 1;
            RegDst = 0;
            ALUSrc = 1;
            MemWr = 0;
             MemRead = 1;
            MemtoReg = 0; 
            Extop = 0;
            Jump = 0;
            Branch = 0;
            ALUop = 5'b10001;
            end        
      
          `LBU://lbu 6'b100100
            begin
            RegWr = 1;
            RegDst = 0;
            ALUSrc = 1;
            MemWr = 0;
             MemRead = 1;
            MemtoReg = 1; 
            Extop = 0;
            Jump = 0;
            Branch = 0;
            ALUop = 5'b00000;
            Bitop = 1;
            end

          `LB://lb 6'b100000
            begin
            RegWr = 1;
            RegDst = 0;
            ALUSrc = 1;
            MemWr = 0;
            MemtoReg = 1; 
            Extop = 0;
            Jump = 0;
            Branch = 0;
            ALUop = 5'b00000;
            Bitop = 1;
            end

          `SB://sb  6'b101000
            begin
            RegWr = 0;
            ALUSrc = 1;
            MemWr = 1;
            Extop = 1;
            Jump = 0;
            Branch = 0;
            ALUop = 5'b00000;
            Bitop = 1;
            end

          `SLTI://slti 6'b001010
            begin
            RegWr = 1;
            RegDst = 0;
            Extop = 1;
            MemWr = 0;
            MemtoReg = 0;
            ALUSrc = 1;
            Jump = 0;
            Branch = 0;
            ALUop = 5'b00101;
            end

         `SLTIU://sltiu 6'b001011
            begin
            RegWr = 1;
            RegDst = 0;
            Extop = 1;
            MemWr = 0;
            MemtoReg = 0;
            ALUSrc = 1;
            Jump = 0;
            Branch = 0;
            ALUop = 5'b00100;
            end
          6'b000001://bgez区别  
            if(rt==`BGEZ_Rt)
            begin
            RegWr = 0;
            ALUSrc = 0;
            MemWr = 0;
            ALUop = 5'b00001;
            Branch = 1;
            Jump = 0;
            end
            
            else //bltz区别  
            begin
            RegWr = 0;
            ALUSrc = 0;
            MemWr = 0;
            Branch = 1;
            ALUop = 5'b10000;
            Jump = 0; 
            end

         `BGTZ://bgtz 6'b000111
            begin
            RegWr = 0;
            ALUSrc = 0;
            MemWr = 0;
            Branch = 1;
            ALUop = 5'b00011;
            Jump = 0;
            end

          `BLEZ://blez  6'b000110
            begin
            RegWr = 0;
            ALUSrc = 0;
            MemWr = 0;
            Branch = 1;
            ALUop = 5'b01111;
            Jump = 0;
            end
        
          `BEQ://beq  6'b000100
            begin
            RegWr = 0;
            RegDst = 0;
            ALUSrc = 0;
            MemWr = 0;
            Branch = 1;
            Jump = 0;
            ALUop = 5'b00010;
            end

          `BNE:   // bne 6'b000101
            begin
            RegWr = 0;
            RegDst = 0;
            ALUSrc = 0;
            MemWr = 0;
            Branch = 1;
            Jump = 0;
            ALUop = 5'b10010;
            end

          `J://j   6'b000010
            begin
            RegWr = 0;
            ALUSrc = 0;
            MemWr = 0;
            Branch = 0;
            Jump = 1;
            end

    default:;  
    endcase  
end


endmodule
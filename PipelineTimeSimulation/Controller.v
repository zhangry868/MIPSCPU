module Controller(
input[5:0] Op,
input[4:0] Rs,
input[4:0] Rt,
input[4:0] Rd,
input[4:0] Shamt,
input[5:0] Func,
//------------------------
output reg RegDt0,
output reg ID_RsRead,
output reg ID_RtRead,
output reg[1:0] Ex_top,
//------------------------Order up to down
output reg BranchSel,  //?
output reg OverflowEn,
output reg[2:0] Condition,
output reg Branch,
output reg[2:0] PC_write,
output reg[3:0] Mem_Write_Byte_en,    
output reg[3:0] Rd_Write_Byte_en,  
output reg MemWBSrc,
output reg Jump,
output reg ALUShiftSel,
output reg[2:0] MemDataSrc,
output reg ALUSrcA,
output reg ALUSrcB,
output reg[3:0] ALUOp,
output reg[1:0] RegDst,
output reg ShiftAmountSrc,
output reg[1:0] Shift_Op
);
always @(*) begin
	case(Op)
		6'b000000:begin
			RegDt0 = 1'b1;
			ID_RtRead = 1'b1;
			BranchSel = 1'b0;
			Condition = 3'bxxx;
			Branch = 1'b0;
			PC_write = Op[2:0];
			Mem_Write_Byte_en = 4'b0000;
			Rd_Write_Byte_en = 4'b1111;
			MemWBSrc = 1'b0;
			Jump = 1'b0;
			MemDataSrc = 3'bxxx;
			ALUSrcA = 1'b0;
			ALUSrcB = 1'b0;
			RegDst = 2'b00;
			case(Func)
				6'b100000: begin                                 //add-1      
					ID_RsRead = 1'b1;
					Ex_top = 2'bxx ;
               OverflowEn = 1'b1;
					ALUShiftSel = 1;
					ALUOp = 4'b1110;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
				end
				6'b100010: begin                                 //sub-4
					ID_RsRead = 1'b1;
					Ex_top = 2'bxx ;
               OverflowEn = 1'b1; 
					ALUShiftSel = 1;
					ALUOp = 4'b1111;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
				end
				6'b100011: begin                                 //subu-5
					ID_RsRead = 1'b1;
					Ex_top = 2'b00;
               OverflowEn = 1'b0;
					ALUShiftSel = 1;
					ALUOp = 4'b0001;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
				end
				6'b100110: begin                                 //xor - 7
					ID_RsRead = 1'b1;
					Ex_top = 2'bxx;
               OverflowEn = 1'b0; 
					ALUShiftSel = 1;
					ALUOp = 4'b1001;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
				end
				6'b101011: begin                                 //sltu-13
					ID_RsRead = 1'b1;
					Ex_top = 2'bxx;
               OverflowEn = 1'b0;  
					ALUShiftSel = 1;
					ALUOp = 4'b0111;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
				end
				6'b000111: begin                                 //srav-11
					ID_RsRead = 1'b1;
					Ex_top = 2'bxx;
               OverflowEn = 1'b0;
					ALUShiftSel = 0;
					ALUOp = 4'bxxxx;
					ShiftAmountSrc = 1;
					Shift_Op = 2'b10;
				end
				6'b000010: begin                                 //rotr-12
					ID_RsRead = 1'b0;
					Ex_top = 2'bxx;
               OverflowEn = 1'b0; 
					ALUShiftSel = 0;
					ALUOp = 4'bxxxx;
					ShiftAmountSrc = 0;
					Shift_Op = 2'b11;
				end
				default:
				begin
					RegDt0 = 0;
					ID_RsRead = 1'b0;
					ID_RtRead = 1'b0;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'b000; 
					Branch = 1'b0;
					PC_write = 3'b0;//Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b0000;  
					MemWBSrc = 0;
					Jump = 1'b0;
					ALUShiftSel = 1'b0;
					MemDataSrc = 2'b10;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b0;
					ALUOp = 4'b0000;
					RegDst = 2'b00;
					ShiftAmountSrc = 1'b0;
					Shift_Op = 2'b00;
				end
			endcase
		end
		6'b000010:begin                                        //j-15
					RegDt0 = 1;
					ID_RsRead = 1'b0;
					ID_RtRead = 1'b0;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b0000;  
					MemWBSrc = 0;
					Jump = 1'b1;
					ALUShiftSel = 1'b1;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'bx;
					ALUSrcB = 1'bx;
					ALUOp = 4'bxxxx;
					RegDst = 2'bxx;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
		end
		6'b000001:begin                                       
			case(Rt)
				5'b10001: begin                                  //bgezal - 16
					RegDt0 = 0;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b0;
					Ex_top = 2'b00;
					BranchSel= 1'b1; 
               OverflowEn = 1'b0;
					Condition = 3'b011; 
					Branch = 1'b1;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b1111;  
					MemWBSrc = 0;
					Jump = 1'b0;
					ALUShiftSel = 1'bx;
					MemDataSrc = 2'b10;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b0; //attention
					ALUOp = 4'b0001;
					RegDst = 2'b10;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;					
				end
				5'b00001: begin                                //bgez - 22
					RegDt0 = 0;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b0;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'b011; 
					Branch = 1'b1;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b0000;  
					MemWBSrc = 0;
					Jump = 1'b0;
					ALUShiftSel = 1'bx;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b0;
					ALUOp = 4'b0001;
					RegDst = 2'bxx;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;	
				end
				5'b00000:begin                                            //bltz
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b1;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'b110; 
					Branch = 1'b1;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b0000;  
					MemWBSrc = 0;
					Jump = 1'b0;
					ALUShiftSel = 1'bx;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b0;
					ALUOp = 4'b0001;
					RegDst = 2'bxx;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;			
					 end
				default:
				begin
					RegDt0 = 0;
					ID_RsRead = 1'b0;
					ID_RtRead = 1'b0;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'b000; 
					Branch = 1'b0;
					PC_write = 3'b0;//Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b0000;  
					MemWBSrc = 0;
					Jump = 1'b0;
					ALUShiftSel = 1'b0;
					MemDataSrc = 2'b10;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b0;
					ALUOp = 4'b0000;
					RegDst = 2'b00;
					ShiftAmountSrc = 1'b0;
					Shift_Op = 2'b00;
				end
			endcase
		end
		6'b000100:begin                                            //beq
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b1;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'b001; 
					Branch = 1'b1;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b0000;  
					MemWBSrc = 0;
					Jump = 1'b0;
					ALUShiftSel = 1'bx;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b0;
					ALUOp = 4'b0001;
					RegDst = 2'bxx;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;			
					 end
		6'b000101:begin                                            //bne
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b1;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'b010; 
					Branch = 1'b1;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b0000;  
					MemWBSrc = 0;
					Jump = 1'b0;
					ALUShiftSel = 1'bx;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b0;
					ALUOp = 4'b0001;
					RegDst = 2'bxx;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;			
					 end
		6'b000111:begin                                            //bgtz
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b1;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'b100; 
					Branch = 1'b1;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b0000;  
					MemWBSrc = 0;
					Jump = 1'b0;
					ALUShiftSel = 1'bx;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b0;
					ALUOp = 4'b0001;
					RegDst = 2'bxx;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;			
					 end
		6'b000110:begin                                            //blez
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b1;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'b101; 
					Branch = 1'b1;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b0000;  
					MemWBSrc = 0;
					Jump = 1'b0;
					ALUShiftSel = 1'bx;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b0;
					ALUOp = 4'b0001;
					RegDst = 2'bxx;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;			
					 end

		6'b001000:begin                                        //addi-2
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b0;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b1;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b1111;  
					MemWBSrc = 0;
					Jump = 1'b0;
					ALUShiftSel = 1;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b1;
					ALUOp = 4'b1110;
					RegDst = 2'b01;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
		end
		6'b001001:begin                                        //addiu-3
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b0;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b1111;  
					MemWBSrc = 0;
					Jump = 1'b0;
					ALUShiftSel = 1;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b1;
					ALUOp = 4'b0000;
					RegDst = 2'b01;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
		end
		6'b001010:begin                                        //slti-14
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b0;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b1111;  
					MemWBSrc = 0;
					Jump = 1'b0;
					ALUShiftSel = 1;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b1;
					ALUOp = 4'b0101;
					RegDst = 2'b01;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
		end
		6'b001110:begin                                        //xori-8
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b0;
					Ex_top = 2'b01;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b1111;  
					MemWBSrc = 0;
					Jump = 1'b0;
					ALUShiftSel = 1;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b1;
					ALUOp = 4'b1001;
					RegDst = 2'b01;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
		end
		6'b001111:begin                                        //lui-17
					RegDt0 = 1;
					ID_RsRead = 1'b0;
					ID_RtRead = 1'b0;
					Ex_top = 2'b10;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b1111;  
					MemWBSrc = 0;
					Jump = 1'b0;
					ALUShiftSel = 1;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b1;
					ALUSrcB = 1'b1;
					ALUOp = 4'b0000;
					RegDst = 2'b01;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
		end
		6'b011100:begin
			case(Func)
				6'b100000:begin                                  //clz-10
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b0;
					Ex_top = 2'bxx;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b1111;  
					MemWBSrc = 0;
					Jump = 1'b0;
					ALUShiftSel = 1;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b0;
					ALUOp = 4'b0010;
					RegDst = 2'b00;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
				end
				6'b100001:begin                                  //clo-9
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b0;
					Ex_top = 2'bxx;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b1111;  
					MemWBSrc = 0;
					Jump = 1'b0;
					ALUShiftSel = 1;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b0;
					ALUOp = 4'b0011;
					RegDst = 2'b00;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
				end
				default:
				begin
					RegDt0 = 0;
					ID_RsRead = 1'b0;
					ID_RtRead = 1'b0;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'b000; 
					Branch = 1'b0;
					PC_write = 3'b0;//Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b0000;  
					MemWBSrc = 0;
					Jump = 1'b0;
					ALUShiftSel = 1'b0;
					MemDataSrc = 2'b10;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b0;
					ALUOp = 4'b0000;
					RegDst = 2'b00;
					ShiftAmountSrc = 1'b0;
					Shift_Op = 2'b00;
				end
			endcase
		end
		6'b011111:begin                                        //seb-6
					RegDt0 = 1;
					ID_RsRead = 1'b0;
					ID_RtRead = 1'b1;
					Ex_top = 2'bxx;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b1111;  
					MemWBSrc = 0;
					Jump = 1'b0;
					ALUShiftSel = 1;
					MemDataSrc = 3'bxxx; 	
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b0;
					ALUOp = 4'b1010;
					RegDst = 2'b00;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
		end
		6'b100000:begin                                                //lb -27
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b0;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b1111;  
					MemWBSrc = 1;
					Jump = 1'b0;
					ALUShiftSel = 1'b1;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b1;
					ALUOp = 4'b0000;
					RegDst = 2'b01;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;		
		end
		6'b100100:begin                                                //lbu -28
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b0;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b0001;  
					MemWBSrc = 1;
					Jump = 1'b0;
					ALUShiftSel = 1'b1;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b1;
					ALUOp = 4'b0000;
					RegDst = 2'b01;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;		
		end
		6'b100001:begin                                                //lh -29
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b0;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b1111;  
					MemWBSrc = 1;
					Jump = 1'b0;
					ALUShiftSel = 1'b1;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b1;
					ALUOp = 4'b0000;
					RegDst = 2'b01;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;		
		end
		6'b100101:begin                                                //lhu -30
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b0;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b0011;  
					MemWBSrc = 1;
					Jump = 1'b0;
					ALUShiftSel = 1'b1;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b1;
					ALUOp = 4'b0000;
					RegDst = 2'b01;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;		
		end
		6'b100010,6'b100110:begin                                      //lwl,lwr - 18 ,22
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b0;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b1111;  
					MemWBSrc = 1;
					Jump = 1'b0;
					ALUShiftSel = 1'b1;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b1;
					ALUOp = 4'b0000;
					RegDst = 2'b01;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
		end
		6'b100011:begin                                      //lw - 19
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b0;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b0000;    
					Rd_Write_Byte_en = 4'b1111;  
					MemWBSrc = 1;
					Jump = 1'b0;
					ALUShiftSel = 1'b1;
					MemDataSrc = 3'bxxx;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b1;
					ALUOp = 4'b0000;
					RegDst = 2'b01;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
		end
		6'b101000:begin                                      //sb - 25
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b1;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b1111;    
					Rd_Write_Byte_en = 4'b0000;  
					MemWBSrc = 1'b0;
					Jump = 1'b0;
					ALUShiftSel = 1'b1;
					MemDataSrc = 3'b001;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b1;
					ALUOp = 4'b0000;
					RegDst = 2'bxx;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
		end
		6'b101001:begin                                      //sh - 26
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b1;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b1111;    
					Rd_Write_Byte_en = 4'b0000;  
					MemWBSrc = 1'b0;
					Jump = 1'b0;
					ALUShiftSel = 1'b1;
					MemDataSrc = 3'b001;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b1;
					ALUOp = 4'b0000;
					RegDst = 2'bxx;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
		end
		6'b101011:begin                                      //sw - 20
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b1;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b1111;    
					Rd_Write_Byte_en = 4'b0000;  
					MemWBSrc = 1'b0;
					Jump = 1'b0;
					ALUShiftSel = 1'b1;
					MemDataSrc = 3'b001;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b1;
					ALUOp = 4'b0000;
					RegDst = 2'bxx;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
		end
		6'b101110,6'b101010:begin                                      //swr,swl - 21,23
					RegDt0 = 1;
					ID_RsRead = 1'b1;
					ID_RtRead = 1'b1;
					Ex_top = 2'b00;
					BranchSel= 1'b0; 
               OverflowEn = 1'b0;
					Condition = 3'bxxx; 
					Branch = 1'b0;
					PC_write = Op[2:0];
					Mem_Write_Byte_en = 4'b1111;    
					Rd_Write_Byte_en = 4'b0000;  
					MemWBSrc = 1'b0;
					Jump = 1'b0;
					ALUShiftSel = 1'b1;
					MemDataSrc = 3'b001;
					ALUSrcA = 1'b0;
					ALUSrcB = 1'b1;
					ALUOp = 4'b0000;
					RegDst = 2'bxx;
					ShiftAmountSrc = 1'bx;
					Shift_Op = 2'bxx;
		end
		default:
		begin
			RegDt0 = 0;
			ID_RsRead = 1'b0;
			ID_RtRead = 1'b0;
			Ex_top = 2'b00;
			BranchSel= 1'b0; 
         OverflowEn = 1'b0;
			Condition = 3'b000; 
			Branch = 1'b0;
			PC_write = 3'b0;//Op[2:0];
			Mem_Write_Byte_en = 4'b0000;    
			Rd_Write_Byte_en = 4'b0000;  
			MemWBSrc = 0;
			Jump = 1'b0;
			ALUShiftSel = 1'b0;
			MemDataSrc = 2'b10;
			ALUSrcA = 1'b0;
			ALUSrcB = 1'b0;
			ALUOp = 4'b0000;
			RegDst = 2'b00;
			ShiftAmountSrc = 1'b0;
			Shift_Op = 2'b00;
		end
	endcase
end
endmodule

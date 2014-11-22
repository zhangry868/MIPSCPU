module ALU_Controller(ALU_op,ALU_ctr);
input [3:0] ALU_op;
output [2:0] ALU_ctr;

assign ALU_ctr[2] = ((!ALU_op[3])&(!ALU_op[1]))|(!ALU_op[3]& ALU_op[2]& ALU_op[0])|(ALU_op[3]&ALU_op[1]); 
assign ALU_ctr[1] = (!ALU_op[3]&!ALU_op[2]&!ALU_op[1])|(ALU_op[3]&!ALU_op[2]&!ALU_op[0])|(ALU_op[2]&ALU_op[1]&!ALU_op[0])|(ALU_op[3]&ALU_op[1]);
assign ALU_ctr[0] = (!ALU_op[2]&!ALU_op[1])|(!ALU_op[3]&ALU_op[2]&ALU_op[0])|(ALU_op[3]&ALU_op[2]&ALU_op[1]);

endmodule

module Adder(A_in,B_in,Cin,Zero,Carry,Overflow,Negative,Output);
input [31:0] A_in,B_in;
output [31:0] Output;
input Cin;
output Zero,Carry,Overflow,Negative;

assign {Carry,Output} = A_in + B_in + Cin;
assign Zero = (Output == 32'b0)? 1'b1 : 1'b0;
assign Overflow = (!(A_in[31]^B_in[31])&(B_in[31]^Output[31]));
assign Negative = Output[31];

endmodule

module MUX8_1_ALU(Sel,S0,S1,S2,S3,S4,S5,S6,S7,ALU_out);

input [2:0] Sel;
input [31:0] S0,S1,S2,S3,S4,S5,S6,S7;
output [31:0]ALU_out;

assign ALU_out = (Sel[2])? (Sel[1]?(Sel[0]?S7:S6) : (Sel[0]?S5:S4))  :  (Sel[1]?(Sel[0]?S3:S2) : (Sel[0]?S1:S0));

endmodule

module JudgeBit(NumIn,Num);
input [31:0] NumIn;
output reg[31:0] Num;
integer i = 0;
always@(NumIn)//????????????
begin  
    Num = 32; 
    for(i = 31;i >= 0;i = i-1) 
       if(NumIn[i] == 1'b1 && Num == 32) 
            Num = 31 - i; 
end

endmodule



module ALU(
input [31:0] A_in,B_in,
input [3:0] ALU_op,
output Zero,Less,Overflow_out,
output [31:0] ALU_out
);

wire [31:0] AndOut,OrOut,XorOut,NorOut;
wire [31:0] SEX;
wire [31:0] XorOut_Count;
wire Carry,Overflow,Negative;
wire [31:0] Output,Cmp;
wire [31:0] NumBit;
wire Cin;
wire [2:0] ALU_ctr;

ALU_Controller ALU_Con(ALU_op,ALU_ctr);
MUX8_1_ALU MUX(ALU_ctr,NumBit,XorOut,OrOut,NorOut,AndOut,Cmp,SEX,Output,ALU_out);
JudgeBit Judge(XorOut_Count,NumBit);
Adder adder(A_in,B_in^{32{ALU_op[0]}},Cin,Zero,Carry,Overflow,Negative,Output);

//assign NumBit = 32'b0;

assign Cin = ALU_op[0];
assign AndOut = A_in & B_in;
assign OrOut = A_in | B_in;
assign XorOut = A_in ^ B_in;
assign NorOut = !OrOut; 
assign SEX = (ALU_op[0])?({{16{B_in[7]}},B_in[15:0]}):({{24{B_in[7]}},B_in[7:0]});

assign XorOut_Count = {32{ALU_op[0]}}^A_in[31:0];
assign Cmp = Less ? 32'hffffffff : 32'b0;


assign Less = ((!ALU_op[3])&ALU_op[2]&ALU_op[1]&ALU_op[0])?(!Carry):(Overflow^Negative);
assign Overflow_out = (ALU_op[1]&ALU_op[2]&ALU_op[3])? Overflow:1'b0;
//Zero is assigned!

endmodule


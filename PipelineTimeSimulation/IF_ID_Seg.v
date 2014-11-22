module IF_ID_Seg(
input Clk,
input stall,
input flush,

input [31:0]PC_Add,IR_out,

output reg[31:0] PC_Add_out,
output reg[5:0] Op,
output reg[4:0] Rs,Rt,Rd,Shamt,
output reg[5:0] Func
);

initial PC_Add_out =  32'b0;

always@(posedge Clk)
begin
if(flush)
begin
	Op <= 6'b0;
	Rs <= 5'b0;
	Rt <= 5'b0;
	Rd <= 5'b0;
	Shamt <= 5'b0;
	Func <= 6'b0;
	PC_Add_out <= 32'b0;
end

else if(~stall)
begin
	Op <= IR_out[31:26];
	Rs <= IR_out[25:21];
	Rt <= IR_out[20:16];
	Rd <= IR_out[15:11];
	Shamt <= IR_out[10:6];
	Func <= IR_out[5:0];
	PC_Add_out <= PC_Add;
end
end
endmodule 
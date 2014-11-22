module EX_MEM_Seg(
input Clk,
input stall,
input flush,

input [31:0] Branch_addr,PC_add,
input [2:0] Condition,
input Branch,
input [2:0]PC_write,
input [3:0]Mem_Byte_Write,Rd_Write_Byte_en,
input MemWBSrc,OverflowEn,
input [31:0] MemData,WBData,
input Less,Zero,Overflow,
input [4:0]Rd,


output reg [31:0] Branch_addr_out,PC_add_out,
output reg [2:0] Condition_out,
output reg Branch_out,
output reg [2:0]PC_write_out,
output reg [3:0]Mem_Byte_Write_out,Rd_Write_Byte_en_out,
output reg MemWBSrc_out,OverflowEn_out,
output reg [31:0] MemData_out,WBData_out,
output reg Less_out,Zero_out,Overflow_out,
output reg [4:0]Rd_out
);

always@(posedge Clk)
begin
if(flush)
begin
	OverflowEn_out <= 1'b0;
	Branch_addr_out <= 32'b0;
	PC_add_out <= 32'b0;
	Condition_out <= 3'b0;
	Branch_out <= 1'b0;
	PC_write_out =3'b0;
	Mem_Byte_Write_out <= 4'b0;
	Rd_Write_Byte_en_out <= 4'b0;
	MemWBSrc_out <= 1'b0;
	MemData_out <= 32'h0;
	WBData_out <= 32'b0;
	Less_out <= 1'b0;
	Zero_out <= 1'b0;
	Overflow_out  <= 1'b0;
	Rd_out <= 5'b0;
end
else if(~stall)
begin
	OverflowEn_out <= OverflowEn;
	Branch_addr_out <= Branch_addr;
	PC_add_out <= PC_add;
	Condition_out <= Condition;
	Branch_out <= Branch;
	PC_write_out = PC_write;
	Mem_Byte_Write_out <= Mem_Byte_Write;
	Rd_Write_Byte_en_out <= Rd_Write_Byte_en;
	MemWBSrc_out <= MemWBSrc;
	MemData_out <= MemData;
	WBData_out <= WBData;
	Less_out <= Less;
	Zero_out <= Zero;
	Overflow_out  <= Overflow;
	Rd_out <= Rd;
end
end
endmodule

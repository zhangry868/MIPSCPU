module MEM_WB_Seg(
input Clk,
input stall,
input flush,
input [31:0] MemData,
input [31:0] WBData,
input MemWBSrc,
input [3:0] Rd_Write_Byte_en,
input [4:0] Rd,

output reg [31:0] MemData_out,
output reg [31:0] WBData_out,
output reg MemWBSrc_out,
output reg [3:0] Rd_Write_Byte_en_out,
output reg [4:0] Rd_out
);

always@(posedge Clk)
begin

if(flush)
begin
	MemData_out <= 32'b0;
	WBData_out <= 32'b0;
	MemWBSrc_out <= 1'b0;
	Rd_Write_Byte_en_out <= 4'b0;
	Rd_out <= 5'b0;
end
else if(~stall)
begin
	MemData_out <= MemData;
	WBData_out <= WBData;
	MemWBSrc_out <= MemWBSrc;
	Rd_Write_Byte_en_out <= Rd_Write_Byte_en;
	Rd_out <= Rd;
end

end

endmodule

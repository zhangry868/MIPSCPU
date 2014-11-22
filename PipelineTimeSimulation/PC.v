module PC(
input Clk,
input [31:0] PC_in,
output reg [31:0] PC_out);

initial
begin
	PC_out = 32'b0;
end

always@(negedge Clk)
begin
	PC_out <= PC_in;
end
endmodule
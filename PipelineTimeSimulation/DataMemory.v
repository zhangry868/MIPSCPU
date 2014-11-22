module Register_ShiftOutput(
input [31:0] Rt_out,
input [1:0] Mem_addr_in,
input [31:26] IR,
output [31:0] Mem_data_shift
);

wire [2:0] Rt_out_shift_ctr;
wire [31:0] Rt_out_l,Rt_out_r,Rt_out_shift;

assign Rt_out_shift_ctr[2] = (IR[31])&(!IR[30])&(IR[29])&(((!IR[28])&(IR[27])) | ((IR[27])&(!IR[26])) );
assign Rt_out_shift_ctr[1] = (IR[31])&(!IR[30])&(IR[29])&(((!IR[28])&(!IR[27])&(IR[26])) | ((IR[28])&(IR[27])&(!IR[26])));//xor better
assign Rt_out_shift_ctr[0] = (IR[31])&(!IR[30])&(IR[29])&(!IR[28])&(IR[27])&(!IR[26]);

MUX4_1 mux4_1_0(Mem_addr_in[1:0],Rt_out[31:24],8'b0,8'b0,8'b0,Rt_out_l[31:24]);
MUX4_1 mux4_1_1(Mem_addr_in[1:0],Rt_out[23:16],Rt_out[31:24],8'b0,8'b0,Rt_out_l[23:16]);
MUX4_1 mux4_1_2(Mem_addr_in[1:0],Rt_out[15:8],Rt_out[23:16],Rt_out[31:24],8'b0,Rt_out_l[15:8]);
MUX4_1 mux4_1_3(Mem_addr_in[1:0],Rt_out[7:0],Rt_out[15:8],Rt_out[23:16],Rt_out[31:24],Rt_out_l[7:0]);
MUX4_1 mux4_1_4(Mem_addr_in[1:0],Rt_out[7:0],Rt_out[15:8],Rt_out[23:16],Rt_out[31:24],Rt_out_r[31:24]);
MUX4_1 mux4_1_5(Mem_addr_in[1:0],8'b0,Rt_out[7:0],Rt_out[15:8],Rt_out[23:16],Rt_out_r[23:16]);
MUX4_1 mux4_1_6(Mem_addr_in[1:0],8'b0,8'b0,Rt_out[7:0],Rt_out[15:8],Rt_out_r[15:8]);
MUX4_1 mux4_1_7(Mem_addr_in[1:0],8'b0,8'b0,8'b0,Rt_out[7:0],Rt_out_r[7:0]);

MUX8_1 mux8_1_0(Rt_out_shift_ctr[2:0],Rt_out[7:0],8'b0,Rt_out[15:8],8'b0,Rt_out_l[31:24],Rt_out_l[31:24],Rt_out_r[31:24],8'b0,Mem_data_shift[31:24]);
MUX8_1 mux8_1_1(Rt_out_shift_ctr[2:0],Rt_out[7:0],8'b0,Rt_out[7:0],8'b0,Rt_out_l[23:16],Rt_out_l[23:16],Rt_out_r[23:16],8'b0,Mem_data_shift[23:16]);
MUX8_1 mux8_1_2(Rt_out_shift_ctr[2:0],Rt_out[7:0],8'b0,Rt_out[15:8],8'b0,Rt_out_l[15:8],Rt_out_l[15:8],Rt_out_r[15:8],8'b0,Mem_data_shift[15:8]);
MUX8_1 mux8_1_3(Rt_out_shift_ctr[2:0],Rt_out[7:0],8'b0,Rt_out[7:0],8'b0,Rt_out_l[7:0],Rt_out_l[7:0],Rt_out_r[7:0],8'b0,Mem_data_shift[7:0]);

endmodule

module DataMemory 
#(parameter DATA_WIDTH = 32, parameter ADDR_WIDTH = 32)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addr,
	input [3:0] we, 
	input clk,
	output [(DATA_WIDTH-1):0] q
);
	//wire [31:0] RegShift;
	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**(ADDR_WIDTH - 22) - 1:0];

	// Variable to hold the registered read address
	reg [ADDR_WIDTH-1:0] addr_reg;
	initial ram[64] = 32'hf0f0f0f0;
	//Register_ShiftOutput regshift(data,addr[1:0],{3'b100,PC_Write[2:0]},RegShift);
	//assign RegShift = data;
	always @ (negedge clk)
	begin
	case(we)
	 4'b0001: ram[addr[9:2]][7:0] <= data[7:0];
	 4'b0010: ram[addr[9:2]][15:8] <= data[15:8];
	 4'b0011: ram[addr[9:2]][15:0] <= data[15:0];
	 4'b0100: ram[addr[9:2]][23:16] <= data[23:16];
	 4'b0101: begin ram[addr[9:2]][23:16] <= data[23:16]; ram[addr[9:2]][7:0] <= data[7:0];end
	 4'b0110: ram[addr[9:2]][23:8] <= data[23:8];
	 4'b0111: ram[addr[9:2]][23:0] <= data[23:0];
	 4'b1000: ram[addr[9:2]][31:24] <= data[31:24];
	 4'b1001: begin ram[addr[9:2]][31:24] <= data[31:24]; ram[addr[9:2]][7:0] <= data[7:0];end
	 4'b1010: begin ram[addr[9:2]][31:24] <= data[31:24]; ram[addr[9:2]][15:8] <= data[15:8];end
	 4'b1011: begin ram[addr[9:2]][31:24] <= data[31:24]; ram[addr[9:2]][15:0] <= data[15:0];end
	 4'b1100: ram[addr[9:2]][31:16] <= data[31:16];
	 4'b1101: begin ram[addr[9:2]][31:16] <= data[31:16]; ram[addr[9:2]][7:0] <= data[7:0];end
	 4'b1110: ram[addr[9:2]][31:8] <= data[31:8];
	 4'b1111: ram[addr[9:2]] <= data; 
	 default:;
	 endcase
	end
	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign q = ram[addr[9:2]];

endmodule

/*
module DataMemory 
#(parameter DATA_WIDTH = 32, parameter ADDR_WIDTH = 32)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addr,
	input [3:0] we, 
	input clk,
	output [(DATA_WIDTH-1):0] q
);

MemorySingle DataMemory1(data[7:0],addr,we[0],clk,q[7:0]);
MemorySingle DataMemory2(data[15:8],addr,we[1],clk,q[15:8]);
MemorySingle DataMemory3(data[23:16],addr,we[2],clk,q[23:16]);
MemorySingle DataMemory4(data[31:24],addr,we[3],clk,q[31:24]);

endmodule

module MemorySingle
#(parameter DATA_WIDTH = 8, parameter ADDR_WIDTH = 32)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addr,
	input  we, 
	input clk,
	output [(DATA_WIDTH-1):0] q
);
reg [DATA_WIDTH-1:0] ram[2**(ADDR_WIDTH - 22) - 1:0];

always @(negedge clk)
begin
	 if(we)
			ram[addr[9:2]][7:0] <= data[7:0];
end

assign q = ram[addr[9:2]];

endmodule
*/

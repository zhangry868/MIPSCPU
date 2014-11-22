module MUX8_1(Sel,S0,S1,S2,S3,S4,S5,S6,S7,out);

input [2:0] Sel;
input [7:0] S0,S1,S2,S3,S4,S5,S6,S7;
output [7:0]out;

assign out = (Sel[2])? (Sel[1]?(Sel[0]?S7:S6) : (Sel[0]?S5:S4))  :  (Sel[1]?(Sel[0]?S3:S2) : (Sel[0]?S1:S0));

endmodule

module MUX4_1(Sel,S0,S1,S2,S3,out);

input [1:0] Sel;
input [7:0] S0,S1,S2,S3;
output [7:0]out;

assign out = (Sel[1]?(Sel[0]?S3:S2) : (Sel[0]?S1:S0));

endmodule

module Memory_ShiftOutput(
input [31:0] Mem_data_out,
input [1:0] Mem_addr_in,
input [31:26] IR,
output [31:0] Mem_data_shift
);

wire [2:0] MEM_data_shift_ctr;
wire [31:0]Mem_d_l,Mem_d_r;

assign MEM_data_shift_ctr[2] = (IR[31])&(!IR[30])&(!IR[29])&(((!IR[28])&(IR[27])) | ((IR[27])&(!IR[26])) );
assign MEM_data_shift_ctr[1] = (IR[31])&(!IR[30])&(!IR[29])&(((!IR[27])&(IR[26])) | ((IR[28])&(IR[27])&(!IR[26])));
assign MEM_data_shift_ctr[0] = (IR[31])&(!IR[30])&(!IR[29])&(((IR[28])&(!IR[27])) | ((!IR[28])&(IR[27])&(!IR[26])));

MUX4_1 mux4_1_10(Mem_addr_in[1:0],Mem_data_out[31:24],Mem_data_out[23:16],Mem_data_out[15:8],Mem_data_out[7:0],Mem_d_l[31:24]);
MUX4_1 mux4_1_11(Mem_addr_in[1:0],Mem_data_out[23:16],Mem_data_out[15:8],Mem_data_out[7:0],8'b0,Mem_d_l[23:16]);
MUX4_1 mux4_1_12(Mem_addr_in[1:0],Mem_data_out[15:8],Mem_data_out[7:0],8'b0,8'b0,Mem_d_l[15:8]);
MUX4_1 mux4_1_13(Mem_addr_in[1:0],Mem_data_out[7:0],8'b0,8'b0,8'b0,Mem_d_l[7:0]);
MUX4_1 mux4_1_14(Mem_addr_in[1:0],8'b0,8'b0,8'b0,Mem_data_out[31:24],Mem_d_r[31:24]);
MUX4_1 mux4_1_15(Mem_addr_in[1:0],8'b0,8'b0,Mem_data_out[31:24],Mem_data_out[23:16],Mem_d_r[23:16]);
MUX4_1 mux4_1_16(Mem_addr_in[1:0],8'b0,Mem_data_out[31:24],Mem_data_out[23:16],Mem_data_out[15:8],Mem_d_r[15:8]);
MUX4_1 mux4_1_17(Mem_addr_in[1:0],Mem_data_out[31:24],Mem_data_out[23:16],Mem_data_out[15:8],Mem_data_out[7:0],Mem_d_r[7:0]);

MUX8_1 mux8_1_10(MEM_data_shift_ctr[2:0],{8{Mem_d_l[31]}},8'b0,{8{Mem_d_l[31]}},8'b0,Mem_d_l[31:24],Mem_d_l[31:24],Mem_d_r[31:24],8'b0,Mem_data_shift[31:24]);
MUX8_1 mux8_1_11(MEM_data_shift_ctr[2:0],{8{Mem_d_l[31]}},8'b0,{8{Mem_d_l[31]}},8'b0,Mem_d_l[23:16],Mem_d_l[23:16],Mem_d_r[23:16],8'b0,Mem_data_shift[23:16]);
MUX8_1 mux8_1_12(MEM_data_shift_ctr[2:0],{8{Mem_d_l[31]}},8'b0,Mem_d_l[31:24],Mem_d_l[31:24],Mem_d_l[15:8],Mem_d_l[15:8],Mem_d_r[15:8],8'b0,Mem_data_shift[15:8]);
MUX8_1 mux8_1_13(MEM_data_shift_ctr[2:0],Mem_d_l[31:24],Mem_d_l[31:24],Mem_d_l[23:16],Mem_d_l[23:16],Mem_d_l[7:0],Mem_d_l[7:0],Mem_d_r[7:0],8'b0,Mem_data_shift[7:0]);

endmodule
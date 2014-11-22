module Mux4_1(
input [31:0] Data0,Data1,Data2,Data3,
input [1:0] Sel,
output [31:0]Data
);

assign Data = (Sel[1] == 1'b0)?((Sel[0] == 1'b0)?(Data0):(Data1)):((Sel[0] == 1'b0)?(Data2):(Data3));

endmodule


module MIPS_Shifter(
input[31:0]  Data_in,
input [4:0] Count,
input [1:0] Sel,
output [31:0]Data_out
);

wire[31:0] ShiftData0,ShiftData1,ShiftData2,ShiftData3;
wire[1:0] Select;
wire HighBit;

assign HighBit = (Sel[1] == 1'b1)?(Data_in[31]):(1'b0);
assign Select[1] = Sel[1]|Sel[0];
assign Select[0] = ~(Sel[1]^Sel[0]);

Mux4_1 Mux1(Data_in,{Data_in[30:0],1'b0},{HighBit,Data_in[31:1]},{Data_in[0],Data_in[31:1]},{Select[1]&Count[0],Select[0]&Count[0]},ShiftData0);
Mux4_1 Mux2(ShiftData0,{ShiftData0[29:0],2'b0},{HighBit,HighBit,ShiftData0[31:2]},{ShiftData0[1:0],ShiftData0[31:2]},{Select[1]&Count[1],Select[0]&Count[1]},ShiftData1);
Mux4_1 Mux3(ShiftData1,{ShiftData1[27:0],4'b0},{{4{HighBit}},ShiftData1[31:4]},{ShiftData1[3:0],ShiftData1[31:4]},{Select[1]&Count[2],Select[0]&Count[2]},ShiftData2);
Mux4_1 Mux4(ShiftData2,{ShiftData2[23:0],8'b0},{{8{HighBit}},ShiftData2[31:8]},{ShiftData2[7:0],ShiftData2[31:8]},{Select[1]&Count[3],Select[0]&Count[3]},ShiftData3);
Mux4_1 Mux5(ShiftData3,{ShiftData3[15:0],16'b0},{{16{HighBit}},ShiftData3[31:16]},{ShiftData3[15:0],ShiftData3[31:16]},{Select[1]&Count[4],Select[0]&Count[4]},Data_out);
endmodule


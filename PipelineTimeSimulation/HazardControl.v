module Mux4_1_3(
input  [2:0]Data0,Data1,Data2,Data3,
input [1:0] Sel,
output [2:0]Data
);

assign Data = (Sel[1] == 1'b0)?((Sel[0] == 1'b0)?(Data0):(Data1)):((Sel[0] == 1'b0)?(Data2):(Data3));

endmodule

module HazardControl(
input EX_MEM_Branch,
input Jump,
input MemWBSrc,//LoadUse From Control ID_EX
input RsRead,RtRead,//Use Reg From Control IF_ID
input[4:0] Rs_From_IF_ID,Rt_From_IF_ID,
input[4:0] Rt_From_ID_EX,
output IF_ID_stall,ID_EX_stall,EX_MEM_stall,MEM_WB_stall,
output  IF_ID_flush,ID_EX_flush,EX_MEM_flush,MEM_WB_flush,
output [2:0]PCSrc
);
wire LoadUse;
assign LoadUse = ((RsRead === 1'b1 && Rt_From_ID_EX === Rs_From_IF_ID )||(RtRead === 1'b1 && Rt_From_ID_EX === Rt_From_IF_ID)) && (MemWBSrc === 1'b1);

Mux4_1_3 mux_PCSrc(3'b000,3'b010,3'b001,3'b010,{(Jump === 1'b1),(EX_MEM_Branch === 1'b1)},PCSrc);
assign IF_ID_stall = (LoadUse)?1'b1:1'b0;
assign ID_EX_stall = 1'b0;
assign EX_MEM_stall = 1'b0;
assign MEM_WB_stall = 1'b0;
assign IF_ID_flush = 1'b0;
assign ID_EX_flush = ((Jump === 1'b1)|(EX_MEM_Branch === 1'b1)|LoadUse)?1'b1:1'b0;
assign EX_MEM_flush = (EX_MEM_Branch === 1'b1)?1'b1:1'b0;
assign MEM_WB_flush = 1'b0;

endmodule
//1539704193
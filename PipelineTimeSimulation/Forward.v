module Forward(
input [1:0]RegDst,
input[4:0] Rt_From_ID_EX,
input[4:0] Rs_From_ID_EX,
input[4:0] Rd_From_EX_MEM,
input[3:0] RegWrite_From_EX_MEM,
input[4:0] Rd_From_MEM_WB,
input[3:0] RegWrite_From_MEM_WB,

output [1:0] Rs_EX_Forward,Rt_EX_Forward,
//LoudUse_Forward
input[4:0] Rt_From_IF_ID,
input[4:0] Rs_From_IF_ID,
input[1:0] RegRead,
output Rs_LoudUse_Forward,Rt_LoudUse_Forward
);

assign Rs_EX_Forward = ((RegDst[1] === 1'b1)&&((Rs_From_ID_EX === Rd_From_EX_MEM) && (RegWrite_From_EX_MEM !== 4'b0000)))?(2'b01):((RegDst[1] === 1'b1) && (Rs_From_ID_EX === Rd_From_MEM_WB) && (RegWrite_From_MEM_WB !== 4'b0000)?2'b10:2'b00);
assign Rt_EX_Forward = ((RegDst[0] === 1'b1)&&((Rt_From_ID_EX === Rd_From_EX_MEM) && (RegWrite_From_EX_MEM !== 4'b0000)))?(2'b01):((RegDst[0] === 1'b1) && (Rt_From_ID_EX === Rd_From_MEM_WB) && (RegWrite_From_MEM_WB !== 4'b0000)?2'b10:2'b00);
assign Rs_LoudUse_Forward = (RegRead[0] & Rs_From_IF_ID === Rd_From_MEM_WB && RegWrite_From_MEM_WB !== 4'b0)?1'b1:1'b0;
assign Rt_LoudUse_Forward = (RegRead[1] & Rt_From_IF_ID === Rd_From_MEM_WB && RegWrite_From_MEM_WB !== 4'b0)?1'b1:1'b0;
//RegRead[0] & RegRead[1] & 

endmodule

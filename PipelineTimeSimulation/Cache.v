module Cache
#(parameter DATA_WIDTH = 32, parameter ADDR_WIDTH = 32,parameter Cache_Size = 16,parameter Cache_Size_log = 4,  
parameter Block_Size = 2,parameter Block_Size_log = 1)
(
input [(DATA_WIDTH-1):0] data,
input [(ADDR_WIDTH-1):0] addr,
input [3:0] we, 
input Clk,
output [(DATA_WIDTH-1):0] data_out,
output reg hit,
output [(DATA_WIDTH*Block_Size-1):0] ReadRam,
output writeback,
output[7:0] readramn,
output reg[7:0] writeramn
);
// Declare the RAM variable  ram just use 9:2   10bit
reg [DATA_WIDTH-1:0] ram[2**(ADDR_WIDTH - 22) - 1:0];
reg up1,up2,up;
initial 
begin 
ram[64] = 32'hf0f0f0f0; 
end

//assume Memory block size is 32bit rather than 8bit ,addr low 2 bit is 00
//31      7 6     3 2      2 1     0
//+--------+-------+--------+------+
//|  tag   | block | offset |  00  |
//+--------+-------+--------+------+
//    25       4       1        2

reg [(DATA_WIDTH*Block_Size-1):0] cache[Cache_Size-1:0];
reg [Cache_Size-1:0] valid;
reg [Cache_Size-1:0] dirty;
reg [(ADDR_WIDTH-Block_Size_log-Cache_Size_log-1-2):0] tag[Cache_Size-1:0];

//valid initial to 0
integer i;
initial begin
	for (i=0;i<Cache_Size;i=i+1) begin
		valid[i] = 0;
		tag[i] = 0;
	end
	up1 = 0;
	up2 = 0;
end

wire[(Cache_Size_log-1):0] block;  //3:0  4bit
assign block = addr[31:2+Block_Size_log]%Cache_Size; 
wire[(Block_Size_log-1):0] offset;
assign offset = addr[(Block_Size_log-1+2):2];
//wire[(DATA_WIDTH*Block_Size-1):0] ReadRam;
assign readramn = {addr[9:2+Block_Size_log],1'b0};
assign ReadRam = {ram[readramn+1'b1],ram[readramn]}; 
/*//------------------------------------------------------------------------------------
assign hit = valid[block] == 1 && tag[block] == addr[(ADDR_WIDTH-1):Block_Size_log+2+Cache_Size_log];
wire writeback;
assign writeback = (hit == 0 && valid[block] === 1 && dirty[block] ===1);
//------------------------------------------------------------------------------------*/

//assign writeramn = (tag[block][2:0]<<5)+(block<<1)+1'b0;
assign writeback = (hit == 0 && valid[block] === 1 && dirty[block] ===1);
always @(posedge Clk) begin
	up1 = !up1;
	hit = ((valid[block] == 1) && (tag[block] == addr[(ADDR_WIDTH-1):Block_Size_log+2+Cache_Size_log]));
	writeramn = (tag[block][2:0]<<5)+(block<<1)+1'b0;
	if(writeback) begin
		//ram[writeramn] = 32'h87654321;//cache[block][31:0];
		ram[writeramn] <= cache[block][31:0];
		ram[writeramn+1] <= cache[block][63:32];
	end
end

always @(negedge Clk) begin up2=!up2;
case(offset)
	1'b0:case(hit)
	1'b1:case(we)
	 4'b0001: cache[block][7:0] <= data[7:0];
	 4'b0010: cache[block][15:8] <= data[15:8];
	 4'b0011: cache[block][15:0] <= data[15:0];
	 4'b0100: cache[block][23:16] <= data[23:16];
	 4'b0101: begin cache[block][23:16] <= data[23:16]; cache[block][7:0] <= data[7:0];end
	 4'b0110: cache[block][23:8] <= data[23:8];
	 4'b0111: cache[block][23:0] <= data[23:0];
	 4'b1000: cache[block][31:24] <= data[31:24];
	 4'b1001: begin cache[block][31:24] <= data[31:24]; cache[block][7:0] <= data[7:0];end
	 4'b1010: begin cache[block][31:24] <= data[31:24]; cache[block][15:8] <= data[15:8];end
	 4'b1011: begin cache[block][31:24] <= data[31:24]; cache[block][15:0] <= data[15:0];end
	 4'b1100: cache[block][31:16] <= data[31:16];
	 4'b1101: begin cache[block][31:16] <= data[31:16]; cache[block][7:0] <= data[7:0];end
	 4'b1110: cache[block][31:8] <= data[31:8];
	 4'b1111: cache[block][31:0] <= data; 
	 default:;
	endcase
	1'b0:case(we)
	 4'b0000: cache[block] <= ReadRam;
	 4'b0001: cache[block] <= {ReadRam[63:8],data[7:0]};
	 4'b0010: cache[block] <= {ReadRam[63:16],data[15:8],ReadRam[7:0]};
	 4'b0011: cache[block] <= {ReadRam[63:16],data[15:0]};
	 4'b0100: cache[block] <= {ReadRam[63:24],data[23:16],ReadRam[15:0]};
	 4'b0101: cache[block] <= {ReadRam[63:24],data[23:16],ReadRam[15:8],data[7:0]};
	 4'b0110: cache[block] <= {ReadRam[63:24],data[23:8],ReadRam[7:0]};
	 4'b0111: cache[block] <= {ReadRam[63:24],data[23:0]};
	 4'b1000: cache[block] <= {ReadRam[63:32],data[31:24],ReadRam[23:0]};
	 4'b1001: cache[block] <= {ReadRam[63:32],data[31:24],ReadRam[23:8],data[7:0]};
	 4'b1010: cache[block] <= {ReadRam[63:32],data[31:24],ReadRam[23:16],data[15:8]};
	 4'b1011: cache[block] <= {ReadRam[63:32],data[31:24],ReadRam[23:16],data[15:0]};
	 4'b1100: cache[block] <= {ReadRam[63:32],data[31:16],ReadRam[15:0]};
	 4'b1101: cache[block] <= {ReadRam[63:32],data[31:16],ReadRam[15:8],data[7:0]};
	 4'b1110: cache[block] <= {ReadRam[63:32],data[31:8],ReadRam[7:0]};
	 4'b1111: cache[block] <= {ReadRam[63:32],data}; 
	 default:;
	endcase
	endcase
	1'b1:case(hit)
	1'b1:case(we)
	 4'b0001: cache[block][32+7:32] <= data[7:0];
	 4'b0010: cache[block][32+15:32+8] <= data[15:8];
	 4'b0011: cache[block][32+15:32] <= data[15:0];
	 4'b0100: cache[block][32+23:32+16] <= data[23:16];
	 4'b0101: begin cache[block][32+23:32+16] <= data[23:16]; cache[block][32+7:32] <= data[7:0];end
	 4'b0110: cache[block][32+23:32+8] <= data[23:8];
	 4'b0111: cache[block][32+23:32] <= data[23:0];
	 4'b1000: cache[block][32+31:32+24] <= data[31:24];
	 4'b1001: begin cache[block][32+31:32+24] <= data[31:24]; cache[block][32+7:32] <= data[7:0];end
	 4'b1010: begin cache[block][32+31:32+24] <= data[31:24]; cache[block][32+15:32+8] <= data[15:8];end
	 4'b1011: begin cache[block][32+31:32+24] <= data[31:24]; cache[block][32+15:32] <= data[15:0];end
	 4'b1100: cache[block][32+31:32+16] <= data[31:16];
	 4'b1101: begin cache[block][32+31:32+16] <= data[31:16]; cache[block][32+7:32] <= data[7:0];end
	 4'b1110: cache[block][32+31:32+8] <= data[31:8];
	 4'b1111: cache[block][63:32] <= data; 
	 default:;
	endcase
	1'b0:case(we)
	 4'b0000: cache[block] <= ReadRam;
	 4'b0001: cache[block] <= {ReadRam[63:40],data[7:0],ReadRam[31:0]};
	 4'b0010: cache[block] <= {ReadRam[63:48],data[15:8],ReadRam[39:0]};
	 4'b0011: cache[block] <= {ReadRam[63:48],data[15:0],ReadRam[31:0]};
	 4'b0100: cache[block] <= {ReadRam[63:56],data[23:16],ReadRam[47:0]};
	 4'b0101: cache[block] <= {ReadRam[63:56],data[23:16],ReadRam[48:40],data[7:0],ReadRam[31:0]};
	 4'b0110: cache[block] <= {ReadRam[63:56],data[23:8],ReadRam[39:32],ReadRam[31:0]};
	 4'b0111: cache[block] <= {ReadRam[63:56],data[23:0],ReadRam[31:0]};
	 4'b1000: cache[block] <= {data[31:24],ReadRam[55:0]};
	 4'b1001: cache[block] <= {data[31:24],ReadRam[55:40],data[7:0],ReadRam[31:0]};
	 4'b1010: cache[block] <= {data[31:24],ReadRam[55:48],data[15:8],ReadRam[39:0]};
	 4'b1011: cache[block] <= {data[31:24],ReadRam[55:48],data[15:0],ReadRam[31:0]};
	 4'b1100: cache[block] <= {data[31:16],ReadRam[47:0]};
	 4'b1101: cache[block] <= {data[31:16],ReadRam[47:40],data[7:0],ReadRam[31:0]};
	 4'b1110: cache[block] <= {data[31:8],ReadRam[39:0]};
	 4'b1111: cache[block] <= {data,ReadRam[31:0]}; 
	 default:;
	endcase
	endcase
endcase
	valid[block] <= 1'b1;
	tag[block] <= addr[(ADDR_WIDTH-1):Block_Size_log+2+Cache_Size_log];
	dirty[block] <= (we == 4'b0000)?0:1;
end

always@(up1 or up2) begin
	up = up1 ^ up2;
end
assign data_out = (up == 0)?(offset == 0)?cache[block][31:0]:cache[block][63:32]:(offset == 0)?ReadRam[31:0]:ReadRam[63:32];

endmodule
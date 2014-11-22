library verilog;
use verilog.vl_types.all;
entity pipeline is
    generic(
        ins_we          : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi0)
    );
    port(
        Clk             : in     vl_logic;
        PC_in           : out    vl_logic_vector(31 downto 0);
        PC_out          : out    vl_logic_vector(31 downto 0);
        PCSrc           : out    vl_logic_vector(2 downto 0);
        flash_ID        : out    vl_logic;
        flash_EX        : out    vl_logic;
        OperandA_ID     : out    vl_logic_vector(31 downto 0);
        OperandB_ID     : out    vl_logic_vector(31 downto 0);
        Rs_ID           : out    vl_logic_vector(4 downto 0);
        Rt_ID           : out    vl_logic_vector(4 downto 0);
        Rd_ID           : out    vl_logic_vector(4 downto 0);
        Rd_EX           : out    vl_logic_vector(4 downto 0);
        Rd_Mem          : out    vl_logic_vector(4 downto 0);
        Immediate32_ID  : out    vl_logic_vector(31 downto 0);
        MemDataSrc_ID   : out    vl_logic_vector(2 downto 0);
        ALUSrcA_ID      : out    vl_logic;
        ALUSrcB_ID      : out    vl_logic;
        Jump_ID         : out    vl_logic;
        ALUOp_ID        : out    vl_logic_vector(3 downto 0);
        Rd_Write_Byte_en_Mem: out    vl_logic_vector(3 downto 0);
        MemWriteEn      : out    vl_logic_vector(3 downto 0);
        RdWriteEn       : out    vl_logic_vector(3 downto 0);
        IR_IF           : out    vl_logic_vector(31 downto 0);
        Shifter_out     : out    vl_logic_vector(31 downto 0);
        Rd_in           : out    vl_logic_vector(31 downto 0);
        MemData_EX      : out    vl_logic_vector(31 downto 0);
        Data_out        : out    vl_logic_vector(31 downto 0);
        WBData_EX       : out    vl_logic_vector(31 downto 0);
        ShiftAmount     : out    vl_logic_vector(4 downto 0);
        Rs_EX_Forward   : out    vl_logic_vector(1 downto 0);
        Rt_EX_Forward   : out    vl_logic_vector(1 downto 0);
        Immediate32_IF  : out    vl_logic_vector(31 downto 0);
        ALU_OpA         : out    vl_logic_vector(31 downto 0);
        ALU_OpB         : out    vl_logic_vector(31 downto 0);
        ALU_out         : out    vl_logic_vector(31 downto 0);
        RegShift        : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ins_we : constant is 1;
end pipeline;

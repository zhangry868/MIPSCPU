library verilog;
use verilog.vl_types.all;
entity Controller is
    port(
        Op              : in     vl_logic_vector(5 downto 0);
        Rs              : in     vl_logic_vector(4 downto 0);
        Rt              : in     vl_logic_vector(4 downto 0);
        Rd              : in     vl_logic_vector(4 downto 0);
        Shamt           : in     vl_logic_vector(4 downto 0);
        Func            : in     vl_logic_vector(5 downto 0);
        RegDt0          : out    vl_logic;
        ID_RsRead       : out    vl_logic;
        ID_RtRead       : out    vl_logic;
        Ex_top          : out    vl_logic_vector(1 downto 0);
        BranchSel       : out    vl_logic;
        OverflowEn      : out    vl_logic;
        Condition       : out    vl_logic_vector(2 downto 0);
        Branch          : out    vl_logic;
        PC_write        : out    vl_logic_vector(2 downto 0);
        Mem_Write_Byte_en: out    vl_logic_vector(3 downto 0);
        Rd_Write_Byte_en: out    vl_logic_vector(3 downto 0);
        MemWBSrc        : out    vl_logic;
        Jump            : out    vl_logic;
        ALUShiftSel     : out    vl_logic;
        MemDataSrc      : out    vl_logic_vector(2 downto 0);
        ALUSrcA         : out    vl_logic;
        ALUSrcB         : out    vl_logic;
        ALUOp           : out    vl_logic_vector(3 downto 0);
        RegDst          : out    vl_logic_vector(1 downto 0);
        ShiftAmountSrc  : out    vl_logic;
        Shift_Op        : out    vl_logic_vector(1 downto 0)
    );
end Controller;

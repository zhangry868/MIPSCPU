library verilog;
use verilog.vl_types.all;
entity EX_MEM_Seg is
    port(
        Clk             : in     vl_logic;
        stall           : in     vl_logic;
        flush           : in     vl_logic;
        Branch_addr     : in     vl_logic_vector(31 downto 0);
        PC_add          : in     vl_logic_vector(31 downto 0);
        Condition       : in     vl_logic_vector(2 downto 0);
        Branch          : in     vl_logic;
        PC_write        : in     vl_logic_vector(2 downto 0);
        Mem_Byte_Write  : in     vl_logic_vector(3 downto 0);
        Rd_Write_Byte_en: in     vl_logic_vector(3 downto 0);
        MemWBSrc        : in     vl_logic;
        OverflowEn      : in     vl_logic;
        MemData         : in     vl_logic_vector(31 downto 0);
        WBData          : in     vl_logic_vector(31 downto 0);
        Less            : in     vl_logic;
        Zero            : in     vl_logic;
        Overflow        : in     vl_logic;
        Rd              : in     vl_logic_vector(4 downto 0);
        Branch_addr_out : out    vl_logic_vector(31 downto 0);
        PC_add_out      : out    vl_logic_vector(31 downto 0);
        Condition_out   : out    vl_logic_vector(2 downto 0);
        Branch_out      : out    vl_logic;
        PC_write_out    : out    vl_logic_vector(2 downto 0);
        Mem_Byte_Write_out: out    vl_logic_vector(3 downto 0);
        Rd_Write_Byte_en_out: out    vl_logic_vector(3 downto 0);
        MemWBSrc_out    : out    vl_logic;
        OverflowEn_out  : out    vl_logic;
        MemData_out     : out    vl_logic_vector(31 downto 0);
        WBData_out      : out    vl_logic_vector(31 downto 0);
        Less_out        : out    vl_logic;
        Zero_out        : out    vl_logic;
        Overflow_out    : out    vl_logic;
        Rd_out          : out    vl_logic_vector(4 downto 0)
    );
end EX_MEM_Seg;

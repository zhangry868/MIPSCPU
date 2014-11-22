library verilog;
use verilog.vl_types.all;
entity MEM_WB_Seg is
    port(
        Clk             : in     vl_logic;
        stall           : in     vl_logic;
        flush           : in     vl_logic;
        MemData         : in     vl_logic_vector(31 downto 0);
        WBData          : in     vl_logic_vector(31 downto 0);
        MemWBSrc        : in     vl_logic;
        Rd_Write_Byte_en: in     vl_logic_vector(3 downto 0);
        Rd              : in     vl_logic_vector(4 downto 0);
        MemData_out     : out    vl_logic_vector(31 downto 0);
        WBData_out      : out    vl_logic_vector(31 downto 0);
        MemWBSrc_out    : out    vl_logic;
        Rd_Write_Byte_en_out: out    vl_logic_vector(3 downto 0);
        Rd_out          : out    vl_logic_vector(4 downto 0)
    );
end MEM_WB_Seg;

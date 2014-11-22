library verilog;
use verilog.vl_types.all;
entity Condition_Check is
    port(
        Condition       : in     vl_logic_vector(2 downto 0);
        PC_Write        : in     vl_logic_vector(2 downto 0);
        addr            : in     vl_logic_vector(1 downto 0);
        MemWBSrc        : in     vl_logic;
        OverflowEn      : in     vl_logic;
        Branch          : in     vl_logic;
        Overflow        : in     vl_logic;
        Mem_Byte_Write  : in     vl_logic_vector(3 downto 0);
        Rd_Write_Byte_en: in     vl_logic_vector(3 downto 0);
        Less            : in     vl_logic;
        Zero            : in     vl_logic;
        BranchValid     : out    vl_logic;
        RdWriteEn       : out    vl_logic_vector(3 downto 0);
        MemWriteEn      : out    vl_logic_vector(3 downto 0)
    );
end Condition_Check;

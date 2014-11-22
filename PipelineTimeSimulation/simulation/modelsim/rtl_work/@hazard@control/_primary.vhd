library verilog;
use verilog.vl_types.all;
entity HazardControl is
    port(
        EX_MEM_Branch   : in     vl_logic;
        Jump            : in     vl_logic;
        MemWBSrc        : in     vl_logic;
        RsRead          : in     vl_logic;
        RtRead          : in     vl_logic;
        Rs_From_IF_ID   : in     vl_logic_vector(4 downto 0);
        Rt_From_IF_ID   : in     vl_logic_vector(4 downto 0);
        Rt_From_ID_EX   : in     vl_logic_vector(4 downto 0);
        IF_ID_stall     : out    vl_logic;
        ID_EX_stall     : out    vl_logic;
        EX_MEM_stall    : out    vl_logic;
        MEM_WB_stall    : out    vl_logic;
        IF_ID_flush     : out    vl_logic;
        ID_EX_flush     : out    vl_logic;
        EX_MEM_flush    : out    vl_logic;
        MEM_WB_flush    : out    vl_logic;
        PCSrc           : out    vl_logic_vector(2 downto 0)
    );
end HazardControl;

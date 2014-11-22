library verilog;
use verilog.vl_types.all;
entity IF_ID_Seg is
    port(
        Clk             : in     vl_logic;
        stall           : in     vl_logic;
        flush           : in     vl_logic;
        PC_Add          : in     vl_logic_vector(31 downto 0);
        IR_out          : in     vl_logic_vector(31 downto 0);
        PC_Add_out      : out    vl_logic_vector(31 downto 0);
        Op              : out    vl_logic_vector(5 downto 0);
        Rs              : out    vl_logic_vector(4 downto 0);
        Rt              : out    vl_logic_vector(4 downto 0);
        Rd              : out    vl_logic_vector(4 downto 0);
        Shamt           : out    vl_logic_vector(4 downto 0);
        Func            : out    vl_logic_vector(5 downto 0)
    );
end IF_ID_Seg;

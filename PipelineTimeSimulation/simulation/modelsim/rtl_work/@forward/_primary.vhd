library verilog;
use verilog.vl_types.all;
entity Forward is
    port(
        RegDst          : in     vl_logic_vector(1 downto 0);
        Rt_From_ID_EX   : in     vl_logic_vector(4 downto 0);
        Rs_From_ID_EX   : in     vl_logic_vector(4 downto 0);
        Rd_From_EX_MEM  : in     vl_logic_vector(4 downto 0);
        RegWrite_From_EX_MEM: in     vl_logic_vector(3 downto 0);
        Rd_From_MEM_WB  : in     vl_logic_vector(4 downto 0);
        RegWrite_From_MEM_WB: in     vl_logic_vector(3 downto 0);
        Rs_EX_Forward   : out    vl_logic_vector(1 downto 0);
        Rt_EX_Forward   : out    vl_logic_vector(1 downto 0);
        Rt_From_IF_ID   : in     vl_logic_vector(4 downto 0);
        Rs_From_IF_ID   : in     vl_logic_vector(4 downto 0);
        RegRead         : in     vl_logic_vector(1 downto 0);
        Rs_LoudUse_Forward: out    vl_logic;
        Rt_LoudUse_Forward: out    vl_logic
    );
end Forward;

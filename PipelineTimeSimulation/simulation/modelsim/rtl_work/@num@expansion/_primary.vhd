library verilog;
use verilog.vl_types.all;
entity NumExpansion is
    port(
        Imm             : in     vl_logic_vector(15 downto 0);
        Ex_top          : in     vl_logic_vector(1 downto 0);
        Immediate32     : out    vl_logic_vector(31 downto 0)
    );
end NumExpansion;

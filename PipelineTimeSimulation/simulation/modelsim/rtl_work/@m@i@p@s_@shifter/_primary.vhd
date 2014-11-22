library verilog;
use verilog.vl_types.all;
entity MIPS_Shifter is
    port(
        Data_in         : in     vl_logic_vector(31 downto 0);
        Count           : in     vl_logic_vector(4 downto 0);
        Sel             : in     vl_logic_vector(1 downto 0);
        Data_out        : out    vl_logic_vector(31 downto 0)
    );
end MIPS_Shifter;

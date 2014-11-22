library verilog;
use verilog.vl_types.all;
entity MUX4_1 is
    port(
        Sel             : in     vl_logic_vector(1 downto 0);
        S0              : in     vl_logic_vector(7 downto 0);
        S1              : in     vl_logic_vector(7 downto 0);
        S2              : in     vl_logic_vector(7 downto 0);
        S3              : in     vl_logic_vector(7 downto 0);
        \out\           : out    vl_logic_vector(7 downto 0)
    );
end MUX4_1;

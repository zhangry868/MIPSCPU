library verilog;
use verilog.vl_types.all;
entity MUX8_1_Icontrol is
    port(
        Sel             : in     vl_logic_vector(2 downto 0);
        S0              : in     vl_logic;
        S1              : in     vl_logic;
        S2              : in     vl_logic;
        S3              : in     vl_logic;
        S4              : in     vl_logic;
        S5              : in     vl_logic;
        S6              : in     vl_logic;
        S7              : in     vl_logic;
        \out\           : out    vl_logic
    );
end MUX8_1_Icontrol;

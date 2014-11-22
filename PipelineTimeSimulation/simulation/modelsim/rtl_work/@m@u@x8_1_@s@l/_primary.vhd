library verilog;
use verilog.vl_types.all;
entity MUX8_1_SL is
    port(
        Sel             : in     vl_logic_vector(3 downto 0);
        Write_Byte_En   : in     vl_logic_vector(3 downto 0);
        S0              : in     vl_logic_vector(3 downto 0);
        S1              : in     vl_logic_vector(3 downto 0);
        S2              : in     vl_logic_vector(3 downto 0);
        S3              : in     vl_logic_vector(3 downto 0);
        S4              : in     vl_logic_vector(3 downto 0);
        S5              : in     vl_logic_vector(3 downto 0);
        S6              : in     vl_logic_vector(3 downto 0);
        S7              : in     vl_logic_vector(3 downto 0);
        \out\           : out    vl_logic_vector(3 downto 0)
    );
end MUX8_1_SL;

library verilog;
use verilog.vl_types.all;
entity Mux4_1 is
    port(
        Data0           : in     vl_logic_vector(31 downto 0);
        Data1           : in     vl_logic_vector(31 downto 0);
        Data2           : in     vl_logic_vector(31 downto 0);
        Data3           : in     vl_logic_vector(31 downto 0);
        Sel             : in     vl_logic_vector(1 downto 0);
        Data            : out    vl_logic_vector(31 downto 0)
    );
end Mux4_1;

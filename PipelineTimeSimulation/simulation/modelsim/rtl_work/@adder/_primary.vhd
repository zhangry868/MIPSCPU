library verilog;
use verilog.vl_types.all;
entity Adder is
    port(
        A_in            : in     vl_logic_vector(31 downto 0);
        B_in            : in     vl_logic_vector(31 downto 0);
        Cin             : in     vl_logic;
        Zero            : out    vl_logic;
        Carry           : out    vl_logic;
        Overflow        : out    vl_logic;
        Negative        : out    vl_logic;
        Output          : out    vl_logic_vector(31 downto 0)
    );
end Adder;

library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        A_in            : in     vl_logic_vector(31 downto 0);
        B_in            : in     vl_logic_vector(31 downto 0);
        ALU_op          : in     vl_logic_vector(3 downto 0);
        Zero            : out    vl_logic;
        Less            : out    vl_logic;
        Overflow_out    : out    vl_logic;
        ALU_out         : out    vl_logic_vector(31 downto 0)
    );
end ALU;

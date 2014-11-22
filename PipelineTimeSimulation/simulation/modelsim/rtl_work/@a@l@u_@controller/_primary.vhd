library verilog;
use verilog.vl_types.all;
entity ALU_Controller is
    port(
        ALU_op          : in     vl_logic_vector(3 downto 0);
        ALU_ctr         : out    vl_logic_vector(2 downto 0)
    );
end ALU_Controller;

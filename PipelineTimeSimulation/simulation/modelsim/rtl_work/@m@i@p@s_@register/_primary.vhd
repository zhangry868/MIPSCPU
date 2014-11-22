library verilog;
use verilog.vl_types.all;
entity MIPS_Register is
    port(
        Rs_addr         : in     vl_logic_vector(4 downto 0);
        Rt_addr         : in     vl_logic_vector(4 downto 0);
        Rd_addr         : in     vl_logic_vector(4 downto 0);
        Clk             : in     vl_logic;
        Rd_write_byte_en: in     vl_logic_vector(3 downto 0);
        Rd_in           : in     vl_logic_vector(31 downto 0);
        Rs_out          : out    vl_logic_vector(31 downto 0);
        Rt_out          : out    vl_logic_vector(31 downto 0)
    );
end MIPS_Register;

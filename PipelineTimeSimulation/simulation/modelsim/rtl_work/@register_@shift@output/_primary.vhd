library verilog;
use verilog.vl_types.all;
entity Register_ShiftOutput is
    port(
        Rt_out          : in     vl_logic_vector(31 downto 0);
        Mem_addr_in     : in     vl_logic_vector(1 downto 0);
        IR              : in     vl_logic_vector(31 downto 26);
        Mem_data_shift  : out    vl_logic_vector(31 downto 0)
    );
end Register_ShiftOutput;

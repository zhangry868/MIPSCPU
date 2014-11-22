library verilog;
use verilog.vl_types.all;
entity JudgeBit is
    port(
        NumIn           : in     vl_logic_vector(31 downto 0);
        Num             : out    vl_logic_vector(31 downto 0)
    );
end JudgeBit;

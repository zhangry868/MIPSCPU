# DESCRIPTION
A Pipelined CPU design, Quartus platform, Verilog HDL, Team Work

An implementation of a MIPS CPU written in Verilog.  This project is in
very early stages and currently only implements the most basic
functionality of a MIPS CPU.

 - 32-bit MIPS processor

 - implemented in Verilog

 - 5 stage pipeline

 - static branch not taken branch predictor

 - branch detection in decode (stage 2)

 - supports stalls to avoid read after write (RAW) and other hazards

 - can forward from memory (stage 4) and write back (stage 5)

# REQUIREMENTS

This project requires a Verilog simulator, such as Quartus.

# AUTHOR

Rui-Yi Zhang <zhangry868@126.com><br>
<http://github.com/zhangry868>
Dong Xu<br>
Qian-Ke Li<br>

# COPYRIGHT

Copyright &copy; 2014, Rui-Yi Zhang, Dong Xu, Qian-Ke Li.  All Rights Reserved.<br>
This project is free software and released under the [GNU General Public License][gpl].

 [gpl]: http://www.gnu.org/licenses/gpl.html

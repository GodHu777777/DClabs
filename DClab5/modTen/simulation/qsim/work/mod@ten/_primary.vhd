library verilog;
use verilog.vl_types.all;
entity modTen is
    port(
        Q3              : out    vl_logic;
        CP              : in     vl_logic;
        ClearAll        : in     vl_logic;
        Q0              : out    vl_logic;
        Q1              : out    vl_logic;
        Q2              : out    vl_logic
    );
end modTen;

module nand_gate_str (
    input  wire a,
    input  wire b,
    output wire y
);
    nand u1 (y, a, b);
endmodule

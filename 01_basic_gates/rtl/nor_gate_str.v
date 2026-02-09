module nor_gate_str (
    input  wire a,
    input  wire b,
    output wire y
);
    nor u1 (y, a, b);
endmodule

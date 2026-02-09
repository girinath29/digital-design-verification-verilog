module xnor_gate_str (
    input  wire a,
    input  wire b,
    output wire y
);
    xnor u1 (y, a, b);
endmodule

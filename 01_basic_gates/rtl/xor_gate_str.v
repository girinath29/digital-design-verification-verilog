module xor_gate_str (
    input  wire a,
    input  wire b,
    output wire y
);
    xor u1 (y, a, b);
endmodule

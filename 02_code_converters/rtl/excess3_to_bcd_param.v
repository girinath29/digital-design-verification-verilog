module excess3_to_bcd_param #(
    parameter integer DIGITS = 5
)(
    input  wire [DIGITS*4-1:0] ex3,
    output wire [DIGITS*4-1:0] bcd
);
    genvar d;
    generate
        for (d = 0; d < DIGITS; d = d + 1) begin : GEN_EX32BCD
            assign bcd[d*4 +: 4] = ex3[d*4 +: 4] - 4'd3;
        end
    endgenerate
endmodule

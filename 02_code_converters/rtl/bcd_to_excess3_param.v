module bcd_to_excess3_param #(
    parameter integer DIGITS = 5
)(
    input  wire [DIGITS*4-1:0] bcd,
    output wire [DIGITS*4-1:0] ex3
);
    genvar d;
    generate
        for (d = 0; d < DIGITS; d = d + 1) begin : GEN_BCD2EX3
            assign ex3[d*4 +: 4] = bcd[d*4 +: 4] + 4'd3;
        end
    endgenerate
endmodule

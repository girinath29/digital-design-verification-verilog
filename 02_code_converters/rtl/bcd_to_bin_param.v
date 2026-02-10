module bcd_to_bin_param #(
    parameter integer BIN_W  = 16,
    parameter integer DIGITS = 5
)(
    input  wire [DIGITS*4-1:0] bcd,
    output reg  [BIN_W-1:0]    bin
);
    integer d;
    reg [BIN_W-1:0] pow10;

    always @(*) begin
        bin   = {BIN_W{1'b0}};
        pow10 = {{(BIN_W-1){1'b0}}, 1'b1};

        for (d = 0; d < DIGITS; d = d + 1) begin
            bin   = bin + (bcd[d*4 +: 4] * pow10);
            pow10 = pow10 * 10;
        end
    end
endmodule

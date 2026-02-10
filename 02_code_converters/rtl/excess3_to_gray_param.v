module excess3_to_gray_param #(
    parameter integer BIN_W  = 16,
    parameter integer DIGITS = 5
)(
    input  wire [DIGITS*4-1:0] ex3,
    output wire [BIN_W-1:0]    gray
);
    wire [DIGITS*4-1:0] bcd;
    wire [BIN_W-1:0]    bin;

    excess3_to_bcd_param #(.DIGITS(DIGITS)) u1 (.ex3(ex3), .bcd(bcd));
    bcd_to_bin_param     #(.BIN_W(BIN_W), .DIGITS(DIGITS)) u2 (.bcd(bcd), .bin(bin));
    bin_to_gray_n        #(.N(BIN_W))      u3 (.bin(bin), .gray(gray));
endmodule

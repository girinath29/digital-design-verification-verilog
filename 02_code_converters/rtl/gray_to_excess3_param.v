module gray_to_excess3_param #(
    parameter integer BIN_W  = 16,
    parameter integer DIGITS = 5
)(
    input  wire [BIN_W-1:0]    gray,
    output wire [DIGITS*4-1:0] ex3
);
    wire [BIN_W-1:0]    bin;
    wire [DIGITS*4-1:0] bcd;

    gray_to_bin_n         #(.N(BIN_W))        u1 (.gray(gray), .bin(bin));
    bin_to_bcd_param     #(.BIN_W(BIN_W), .DIGITS(DIGITS)) u2 (.bin(bin), .bcd(bcd));
    bcd_to_excess3_param #(.DIGITS(DIGITS))  u3 (.bcd(bcd), .ex3(ex3));
endmodule

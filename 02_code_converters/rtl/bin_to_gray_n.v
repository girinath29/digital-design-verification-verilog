module bin_to_gray_n #(
    parameter integer N = 16
)(
    input  wire [N-1:0] bin,
    output wire [N-1:0] gray
);
    assign gray = (bin >> 1) ^ bin;
endmodule

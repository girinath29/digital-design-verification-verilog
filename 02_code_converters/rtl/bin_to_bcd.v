module bin_to_bcd_param #(
    parameter integer BIN_W  = 16,   // Binary width (e.g., 16 bits)
    parameter integer DIGITS = 5     // Number of BCD digits (e.g., 5 digits)
)(
    input  wire [BIN_W-1:0]    bin,
    output reg  [DIGITS*4-1:0] bcd
);
    integer i, d;
    reg [BIN_W + DIGITS*4 - 1 : 0] shift_reg;

    always @(*) begin
        shift_reg = { (BIN_W + DIGITS*4){1'b0} };
        shift_reg[BIN_W-1:0] = bin;

        // Double-Dabble (Shift-Add-3)
        for (i = 0; i < BIN_W; i = i + 1) begin
            for (d = 0; d < DIGITS; d = d + 1) begin
                if (shift_reg[BIN_W + d*4 +: 4] >= 5)
                    shift_reg[BIN_W + d*4 +: 4] =
                        shift_reg[BIN_W + d*4 +: 4] + 4'd3;
            end
            shift_reg = shift_reg << 1;
        end

        bcd = shift_reg[BIN_W + DIGITS*4 - 1 : BIN_W];
    end
endmodule

module not_gate_beh (
    input  wire a,
    output reg  y
);
    always @(*) begin
        y = ~a;
    end
endmodule

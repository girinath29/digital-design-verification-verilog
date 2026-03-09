//============================================================
// Module: alu
// Description:
//   Simple combinational ALU using Verilog
//
// Operations (op):
//   000 : ADD
//   001 : SUB
//   010 : AND
//   011 : OR
//   100 : XOR
//   101 : PASS A
//   110 : PASS B
//   111 : COMPARE (A > B)
//============================================================

module alu #(parameter W = 8)
(
    input  [W-1:0] a,
    input  [W-1:0] b,
    input  [2:0]   op,
    output reg [W-1:0] y,
    output reg gt
);

always @(*) begin
    y  = 0;
    gt = 0;

    case(op)

        3'b000: y = a + b;        // ADD

        3'b001: y = a - b;        // SUB

        3'b010: y = a & b;        // AND

        3'b011: y = a | b;        // OR

        3'b100: y = a ^ b;        // XOR

        3'b101: y = a;            // PASS A

        3'b110: y = b;            // PASS B

        3'b111: begin             // COMPARE
                    if(a > b)
                        gt = 1;
                    else
                        gt = 0;
                end

        default: begin
                    y  = 0;
                    gt = 0;
                 end

    endcase
end

endmodule

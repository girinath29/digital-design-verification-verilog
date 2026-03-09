`timescale 1ns/1ps

module tb_alu;

parameter W = 8;

reg  [W-1:0] a;
reg  [W-1:0] b;
reg  [2:0]   op;

wire [W-1:0] y;
wire gt;

integer i;

// DUT
alu #(W) dut (
    .a(a),
    .b(b),
    .op(op),
    .y(y),
    .gt(gt)
);

// Waveform dump
initial begin
    $dumpfile("waves_day3.vcd");
    $dumpvars(0, tb_alu);
end

// Self checking task
task check;
input [W-1:0] expected_y;
input expected_gt;
input [80:0] name;
begin
    if (y !== expected_y || gt !== expected_gt)
        $display("FAIL %s exp_y=%0d got_y=%0d exp_gt=%0b got_gt=%0b",
        name, expected_y, y, expected_gt, gt);
    else
        $display("PASS %s y=%0d gt=%0b", name, y, gt);
end
endtask

initial begin

    $display("----- DAY 3 ALU VERIFICATION -----");

    a = 10;
    b = 3;

    op = 3'b000; #5; check(13,0,"ADD");
    op = 3'b001; #5; check(7,0,"SUB");
    op = 3'b010; #5; check(10 & 3,0,"AND");
    op = 3'b011; #5; check(10 | 3,0,"OR");
    op = 3'b100; #5; check(10 ^ 3,0,"XOR");
    op = 3'b101; #5; check(10,0,"PASSA");
    op = 3'b110; #5; check(3,0,"PASSB");
    op = 3'b111; #5; check(0,(10>3),"CMP");

    // Random tests
    for(i=0;i<20;i=i+1)
    begin
        a = $random;
        b = $random;
        op = $random % 8;
        #5;

        case(op)
            0: check(a+b,0,"ADD");
            1: check(a-b,0,"SUB");
            2: check(a&b,0,"AND");
            3: check(a|b,0,"OR");
            4: check(a^b,0,"XOR");
            5: check(a,0,"PASSA");
            6: check(b,0,"PASSB");
            7: check(0,(a>b),"CMP");
        endcase
    end

    $display("----- TEST COMPLETE -----");

    $finish;

end

endmodule

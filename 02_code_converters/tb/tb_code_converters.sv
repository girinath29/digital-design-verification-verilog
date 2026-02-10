`timescale 1ns/1ps

module tb_code_converters;

    // -------- Parameters (match your RTL instantiations) --------
    localparam int BIN_W  = 16;  // supports up to 65535
    localparam int DIGITS = 5;   // 5-digit BCD

    // -------- DUT Signals --------
    logic [BIN_W-1:0]      bin_in;
    logic [BIN_W-1:0]      bin_back_from_gray;
    logic [BIN_W-1:0]      bin_back_from_bcd;

    logic [BIN_W-1:0]      gray_from_bin;
    logic [BIN_W-1:0]      gray_from_ex3;

    logic [DIGITS*4-1:0]   bcd_from_bin;
    logic [DIGITS*4-1:0]   bcd_from_ex3;
    logic [DIGITS*4-1:0]   bcd_back_from_ex3;

    logic [DIGITS*4-1:0]   ex3_from_bcd;
    logic [DIGITS*4-1:0]   ex3_from_gray;

    // -------- DUT Instantiations --------
    bin_to_bcd_param      #(.BIN_W(BIN_W), .DIGITS(DIGITS)) u_b2bcd (.bin(bin_in), .bcd(bcd_from_bin));
    bcd_to_bin_param      #(.BIN_W(BIN_W), .DIGITS(DIGITS)) u_bcd2b (.bcd(bcd_from_bin), .bin(bin_back_from_bcd));

    bin_to_gray_n         #(.N(BIN_W)) u_b2g (.bin(bin_in), .gray(gray_from_bin));
    gray_to_bin_n         #(.N(BIN_W)) u_g2b (.gray(gray_from_bin), .bin(bin_back_from_gray));

    bcd_to_excess3_param  #(.DIGITS(DIGITS)) u_bcd2ex3 (.bcd(bcd_from_bin), .ex3(ex3_from_bcd));
    excess3_to_bcd_param #(.DIGITS(DIGITS)) u_ex32bcd (.ex3(ex3_from_bcd), .bcd(bcd_back_from_ex3));

    excess3_to_gray_param #(.BIN_W(BIN_W), .DIGITS(DIGITS)) u_ex32g (.ex3(ex3_from_bcd), .gray(gray_from_ex3));
    gray_to_excess3_param #(.BIN_W(BIN_W), .DIGITS(DIGITS)) u_g2ex3 (.gray(gray_from_bin), .ex3(ex3_from_gray));

    // -------- Waveform Dump --------
    initial begin
        $dumpfile("waves_day2.vcd");
        $dumpvars(0, tb_code_converters);
    end

    // -------- Helper Task --------
    task automatic check_equal(input [BIN_W-1:0] exp, input [BIN_W-1:0] act, input string name);
        if (act !== exp)
            $display("❌ FAIL %-20s exp=%0d got=%0d", name, exp, act);
        else
            $display("✅ PASS %-20s val=%0d", name, act);
    endtask

    // -------- Tests --------
    initial begin
        $display("=== Day 2: Code Converters Verification Start ===");

        // Directed corner cases
        test_val(0);
        test_val(1);
        test_val(9);
        test_val(10);
        test_val(99);
        test_val(255);
        test_val(500);
        test_val(999);
        test_val(1023);
        test_val(65535);

        // Random tests
        repeat (20) begin
            test_val($urandom_range(0, (1<<BIN_W)-1));
        end

        $display("=== Day 2: All tests completed ===");
        $finish;
    end

    task automatic test_val(input [BIN_W-1:0] v);
        begin
            bin_in = v;
            #1;

            // Round-trip checks
            check_equal(v, bin_back_from_bcd,  "BIN->BCD->BIN");
            check_equal(v, bin_back_from_gray, "BIN->GRAY->BIN");

            // Cross-path sanity (ex3->bcd->bin)
            check_equal(v, bcd_to_bin_param_ref(bcd_back_from_ex3), "BIN->BCD->EX3->BCD->BIN");

            // Display a short trace for visibility
            $display("TRACE v=%0d | BCD=%h | EX3=%h | GRAY=%h", v, bcd_from_bin, ex3_from_bcd, gray_from_bin);
        end
    endtask

    // Reference function to convert BCD back to binary inside TB
    function automatic [BIN_W-1:0] bcd_to_bin_param_ref(input [DIGITS*4-1:0] bcd);
        integer d;
        reg [BIN_W-1:0] acc;
        reg [BIN_W-1:0] pow10;
        begin
            acc   = '0;
            pow10 = 1;
            for (d = 0; d < DIGITS; d = d + 1) begin
                acc   = acc + (bcd[d*4 +: 4] * pow10);
                pow10 = pow10 * 10;
            end
            bcd_to_bin_param_ref = acc;
        end
    endfunction

endmodule

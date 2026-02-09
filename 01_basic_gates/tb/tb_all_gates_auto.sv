`timescale 1ns/1ps

module tb_all_gates_auto;

    logic a, b;

    // Outputs from each DUT
    logic y_and_df, y_and_beh, y_and_str;
    logic y_or_df,  y_or_beh,  y_or_str;
    logic y_not_df, y_not_beh, y_not_str;
    logic y_nand_df,y_nand_beh,y_nand_str;
    logic y_nor_df, y_nor_beh, y_nor_str;
    logic y_xor_df, y_xor_beh, y_xor_str;
    logic y_xnor_df,y_xnor_beh,y_xnor_str;

    // AND
    and_gate_df  u_and_df  (.a(a), .b(b), .y(y_and_df));
    and_gate_beh u_and_beh (.a(a), .b(b), .y(y_and_beh));
    and_gate_str u_and_str (.a(a), .b(b), .y(y_and_str));

    // OR
    or_gate_df   u_or_df   (.a(a), .b(b), .y(y_or_df));
    or_gate_beh  u_or_beh  (.a(a), .b(b), .y(y_or_beh));
    or_gate_str  u_or_str  (.a(a), .b(b), .y(y_or_str));

    // NOT (b is don't care)
    not_gate_df  u_not_df  (.a(a), .y(y_not_df));
    not_gate_beh u_not_beh (.a(a), .y(y_not_beh));
    not_gate_str u_not_str (.a(a), .y(y_not_str));

    // NAND
    nand_gate_df  u_nand_df  (.a(a), .b(b), .y(y_nand_df));
    nand_gate_beh u_nand_beh (.a(a), .b(b), .y(y_nand_beh));
    nand_gate_str u_nand_str (.a(a), .b(b), .y(y_nand_str));

    // NOR
    nor_gate_df  u_nor_df  (.a(a), .b(b), .y(y_nor_df));
    nor_gate_beh u_nor_beh (.a(a), .b(b), .y(y_nor_beh));
    nor_gate_str u_nor_str (.a(a), .b(b), .y(y_nor_str));

    // XOR
    xor_gate_df  u_xor_df  (.a(a), .b(b), .y(y_xor_df));
    xor_gate_beh u_xor_beh (.a(a), .b(b), .y(y_xor_beh));
    xor_gate_str u_xor_str (.a(a), .b(b), .y(y_xor_str));

    // XNOR
    xnor_gate_df  u_xnor_df  (.a(a), .b(b), .y(y_xnor_df));
    xnor_gate_beh u_xnor_beh (.a(a), .b(b), .y(y_xnor_beh));
    xnor_gate_str u_xnor_str (.a(a), .b(b), .y(y_xnor_str));

    task automatic check(input string name, input logic exp, input logic act);
        if (act !== exp)
            $display("❌ ERROR %-10s : a=%0b b=%0b exp=%0b got=%0b", name, a, b, exp, act);
        else
            $display("✅ PASS  %-10s : a=%0b b=%0b y=%0b", name, a, b, act);
    endtask

    initial begin
        $display("Starting AUTO verification for ALL gates (all styles)...");

        for (int i = 0; i < 4; i++) begin
            {a, b} = i; #5;

            check("AND_DF",   (a & b),      y_and_df);
            check("AND_BEH",  (a & b),      y_and_beh);
            check("AND_STR",  (a & b),      y_and_str);

            check("OR_DF",    (a | b),      y_or_df);
            check("OR_BEH",   (a | b),      y_or_beh);
            check("OR_STR",   (a | b),      y_or_str);

            check("NOT_DF",   (~a),         y_not_df);
            check("NOT_BEH",  (~a),         y_not_beh);
            check("NOT_STR",  (~a),         y_not_str);

            check("NAND_DF",  (~(a & b)),   y_nand_df);
            check("NAND_BEH", (~(a & b)),   y_nand_beh);
            check("NAND_STR", (~(a & b)),   y_nand_str);

            check("NOR_DF",   (~(a | b)),   y_nor_df);
            check("NOR_BEH",  (~(a | b)),   y_nor_beh);
            check("NOR_STR",  (~(a | b)),   y_nor_str);

            check("XOR_DF",   (a ^ b),      y_xor_df);
            check("XOR_BEH",  (a ^ b),      y_xor_beh);
            check("XOR_STR",  (a ^ b),      y_xor_str);

            check("XNOR_DF",  (~(a ^ b)),   y_xnor_df);
            check("XNOR_BEH", (~(a ^ b)),   y_xnor_beh);
            check("XNOR_STR", (~(a ^ b)),   y_xnor_str);
        end

        $display("ALL gates verified successfully.");
        $finish;
    end

endmodule

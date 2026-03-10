`timescale 1ns/1ps

module tb_fifo;

parameter DATA_WIDTH = 8;
parameter DEPTH = 16;

reg clk;
reg rst;

reg wr_en;
reg rd_en;

reg  [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

wire full;
wire empty;

integer i;
integer errors;

// reference FIFO model
reg [DATA_WIDTH-1:0] ref_fifo [0:DEPTH-1];
integer wr_ptr_ref;
integer rd_ptr_ref;
integer count_ref;

// DUT
fifo #(DATA_WIDTH,DEPTH) dut
(
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
);

// clock generation
always #5 clk = ~clk;

// waveform dump
initial begin
    $dumpfile("waves_day4.vcd");
    $dumpvars(0,tb_fifo);
end

// reference model update
always @(posedge clk)
begin
    if(rst)
    begin
        wr_ptr_ref = 0;
        rd_ptr_ref = 0;
        count_ref  = 0;
    end
    else
    begin

        // WRITE reference
        if(wr_en && !full)
        begin
            ref_fifo[wr_ptr_ref] = data_in;
            wr_ptr_ref = (wr_ptr_ref + 1) % DEPTH;
            count_ref = count_ref + 1;
        end

        // READ reference
        if(rd_en && !empty)
        begin
            if(data_out !== ref_fifo[rd_ptr_ref])
            begin
                $display("ERROR at time %0t Expected=%0d Got=%0d",
                $time, ref_fifo[rd_ptr_ref], data_out);
                errors = errors + 1;
            end
            else
            begin
                $display("PASS time=%0t Data=%0d", $time, data_out);
            end

            rd_ptr_ref = (rd_ptr_ref + 1) % DEPTH;
            count_ref = count_ref - 1;
        end

    end
end


initial begin

    clk = 0;
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    data_in = 0;

    errors = 0;

    #20 rst = 0;

    $display("---- WRITE PHASE ----");

    // write random data
    for(i=0;i<12;i=i+1)
    begin
        @(posedge clk);
        wr_en = 1;
        rd_en = 0;
        data_in = $random;
    end

    @(posedge clk);
    wr_en = 0;

    $display("---- READ PHASE ----");

    // read data
    for(i=0;i<12;i=i+1)
    begin
        @(posedge clk);
        rd_en = 1;
    end

    @(posedge clk);
    rd_en = 0;

    if(errors == 0)
        $display("TEST PASSED");
    else
        $display("TEST FAILED Errors=%0d", errors);

    #20 $finish;

end

endmodule

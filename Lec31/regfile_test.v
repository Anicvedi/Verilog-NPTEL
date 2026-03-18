module regfile_test;

    reg  [4:0] sr1, sr2, dr;
    reg  [31:0] wrData;
    reg  write, reset, clk;
    wire [31:0] rdData1, rdData2;
    integer k;

    regbank_v4 DUT (
        .rdData1(rdData1),
        .rdData2(rdData2),
        .wrData(wrData),
        .sr1(sr1),
        .sr2(sr2),
        .dr(dr),
        .write(write),
        .reset(reset),
        .clk(clk)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("regfile.vcd");
        $dumpvars(0, regfile_test);

        // Reset
        reset = 1; write = 0;
        #10 reset = 0;

        // WRITE PHASE
        for (k = 0; k < 32; k = k + 1) begin
            dr = k;
            wrData = k * 10;
            write = 1;
            #10;
        end
        write = 0;

        // READ PHASE
        for (k = 0; k < 32; k = k + 2) begin
            sr1 = k;
            sr2 = k + 1;
            #5;
            $display("reg[%0d] = %0d , reg[%0d] = %0d",
                     sr1, rdData1, sr2, rdData2);
        end

        #50 $finish;
    end
endmodule

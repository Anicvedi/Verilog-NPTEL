`timescale 1ps/1ps
module tb();
    reg clk, rst_n, d;
    wire z;
    stickybit DUT(.clk(clk),.rst_n(rst_n),.d(d),.z(z));
    always #5 clk=~clk;
    initial begin
        $dumpfile("example.vcd");
        $dumpvars(0,tb);
        $monitor($time," Z = %b",z);
        clk = 0; rst_n = 0; d = 1;
        #7 rst_n = 1;
        @(negedge clk); d = 0;
        @(negedge clk); d = 0;
        @(negedge clk); d = 1;
        @(negedge clk); d = 0;
        @(negedge clk); d = 1;
        @(negedge clk); d = 0;
        @(negedge clk); d = 0; rst_n = 1;
        #3 rst_n = 0;
        @(negedge clk); d = 1;
        @(negedge clk); d = 0;
        #10 $finish;
    end
endmodule
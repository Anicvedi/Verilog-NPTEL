`timescale 1ps/1ps
module SD_test ();
    reg clk,rst_n,x;
    wire z;
    always #5 clk = ~clk;
    SD DUT(.clk(clk),.rst_n(rst_n),.x(x),.z(z));
    initial begin
        $dumpfile("example.vcd");
        $dumpvars(0,SD_test);
        $monitor($time," Z = %b", z);
        rst_n = 0; x=0; clk=0;
            #7 rst_n = 1;  // not on clock edge
        @(negedge clk); x = 1;
        @(negedge clk); x = 0;
        @(negedge clk); x = 1;
        @(negedge clk); x = 0;
        #10 $finish;
    end
endmodule
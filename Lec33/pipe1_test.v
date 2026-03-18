module pipe1_test;

    parameter N = 10;

    wire [N-1:0] F;
    reg  [N-1:0] A, B, C, D;
    reg clk;

    pipe_ex MYPIPE (F, A, B, C, D, clk);

    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
        #5   A = 10; B = 12; C = 6;  D = 3;
        #20  A = 10; B = 10; C = 5;  D = 3;
        #20  A = 20; B = 11; C = 1;  D = 4;
        #20  A = 15; B = 10; C = 8;  D = 2;
        #20  A = 8;  B = 15; C = 5;  D = 0;
        #20  A = 10; B = 20; C = 5;  D = 3;
        #20  A = 30; B = 1;  C = 2;  D = 4;
    end

    initial begin
        $dumpfile("pipe1.vcd");
        $dumpvars(0, pipe1_test);
        $monitor("Time=%0t F=%0d", $time, F);
        #300 $finish;
    end

endmodule

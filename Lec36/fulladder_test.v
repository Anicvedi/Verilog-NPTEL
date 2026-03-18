module fulladder_test;

    reg a, b, cin;
    wire sum, cout;
    integer k;

    fulladder FA (sum, cout, a, b, cin);

    initial begin
        for (k = 0; k < 8; k = k + 1) begin
            #5 {a, b, cin} = k;
            #1 $display(
                "Inputs: %b%b%b  Sum: %b  Carry: %b",
                a, b, cin, sum, cout
            );
        end
        $finish;
    end

endmodule

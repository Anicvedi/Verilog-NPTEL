module fa_sum (sum, a, b, cin);
    input a, b, cin;
    output sum;

    wire t1;

    myxor2 X1 (t1, a, b);
    myxor2 X2 (sum, t1, cin);

endmodule

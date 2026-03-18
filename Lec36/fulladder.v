module fulladder (sum, cout, a, b, cin);
    input a, b, cin;
    output sum, cout;

    fa_sum   SUM   (sum, a, b, cin);
    fa_carry CARRY (cout, a, b, cin);

endmodule

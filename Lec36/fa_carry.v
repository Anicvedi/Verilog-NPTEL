module fa_carry (cout, a, b, cin);
    input a, b, cin;
    output cout;

    wire t1, t2, t3, t4, t5;

    cmosnand N1 (t1, a, b);
    cmosnand N2 (t2, a, cin);
    cmosnand N3 (t3, b, cin);
    cmosnand N4 (t4, t1, t2);
    cmosnand N5 (t5, t4, t4);
    cmosnand N6 (cout, t5, t3);

endmodule

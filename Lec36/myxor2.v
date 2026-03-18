module myxor2 (out, a, b);
    input a, b;
    output out;

    wire t1, t2, t3, t4;

    // Inverters using NAND
    cmosnand N1 (t1, a, a);   // t1 = ~a
    cmosnand N2 (t2, b, b);   // t2 = ~b

    // a·~b and ~a·b
    cmosnand N3 (t3, a, t2);  // ~(a & ~b)
    cmosnand N4 (t4, b, t1);  // ~(~a & b)

    // Final XOR
    cmosnand N5 (out, t3, t4);

endmodule

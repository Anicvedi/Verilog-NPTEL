module half_adder_dataflow (S, C, A, B);
    input A, B;
    output S, C;

    assign S = A ^ B;  // XOR for sum
    assign C = A & B;  // AND for carry
endmodule

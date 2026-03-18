// 32 x 32 Register File with synchronous write and async read
module regbank_v4 (
    output [31:0] rdData1,
    output [31:0] rdData2,
    input  [31:0] wrData,
    input  [4:0]  sr1, sr2, dr,
    input  write,
    input  reset,
    input  clk
);

    reg [31:0] regfile [0:31];
    integer k;

    // Asynchronous read
    assign rdData1 = regfile[sr1];
    assign rdData2 = regfile[sr2];

    // Synchronous write + reset
    always @(posedge clk) begin
        if (reset) begin
            for (k = 0; k < 32; k = k + 1)
                regfile[k] <= 32'b0;
        end
        else if (write) begin
            regfile[dr] <= wrData;
        end
    end

endmodule

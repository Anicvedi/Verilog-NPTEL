`timescale 1ps/1ps
module SD (
    input clk, rst_n, x, output z
);
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    reg[1:0] state,next_state;

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n)
        begin
            state <= A;
        end
        else
        begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            A: begin
                if (x==0) begin
                    next_state = A;
                end
                else begin
                    next_state = B;
                end
            end 
            B: begin
                if (x==0) next_state = C;
                else next_state = B;
            end
            C: begin
                if(x==0) next_state = A;
                else next_state = D;
            end
            D: begin
                if (x==0) next_state = C;
                else next_state = B;
            end
            default: next_state = A;
        endcase
    end
    assign z = (state==D && x==0)?1:0;
endmodule
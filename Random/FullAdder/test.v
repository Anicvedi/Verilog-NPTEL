
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.02.2026 23:59:19
// Design Name: 
// Module Name: test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test();
reg A,B, Cin;
wire Sum,Cout;
FA DUT(.A(A),.B(B),.Cin(Cin),.Sum(Sum),.Cout(Cout));
initial
begin
    $dumpfile("example.vcd");
    $dumpvars(0,test);
    $monitor($time,"A=%b,B=%b,Cin=%b,Sum=%b,Cout=%b,",A,B,Cin,Sum,Cout);
    A=0; B=0; Cin = 0;
    #20 A=1;B=1;Cin=1;
    #20 A=1;B=1;Cin=1;
end
endmodule

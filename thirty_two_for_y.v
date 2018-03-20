`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:23:30 12/09/2017 
// Design Name: 
// Module Name:    thirty_two_for_y 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module thirty_two_for_y(
    input [31:0] A,B,
    input Cin,C,CE,
	 output [31:0] Sreg
    );
	 wire [3:0] c1;
	 
	 (*RLOC="X0Y0"*) eight_bit_adder_first a1(.A(A[7:0]),.B(B[7:0]),.Cin(Cin),.C(C),.CE(CE),.Cout(c1[0]),.Sreg(Sreg[7:0]));
	 (*RLOC="X0Y2"*) eight_bit_adder a2(.A(A[15:8]),.B(B[15:8]),.Cin(c1[0]),.CIN(Cin),.C(C),.CE(CE),.Cout(c1[1]),.Sreg(Sreg[15:8]));
	 (*RLOC="X0Y4"*) eight_bit_adder a3(.A(A[23:16]),.B(B[23:16]),.Cin(c1[1]),.CIN(Cin),.C(C),.CE(CE),.Cout(c1[2]),.Sreg(Sreg[23:16]));
	 (*RLOC="X0Y6"*) eight_bit_adder a4(.A(A[31:24]),.B(B[31:24]),.Cin(c1[2]),.CIN(Cin),.C(C),.CE(CE),.Cout(c1[3]),.Sreg(Sreg[31:24]));
	 
endmodule

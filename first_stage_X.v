`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:26:44 12/09/2017 
// Design Name: 
// Module Name:    first_stage_X 
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
module first_stage_X(
    input [31:0] pos,neg,
    input Z_31,C,CE,Z_30,Cin,
    /*output Cout,*/
	 output [31:0] Sreg
    );
	 wire [3:0] c1;
	 
	 (*RLOC="X0Y0"*) first_stage_X_first_eight X1a1(.pos(pos[7:0]),.neg(neg[7:0]),.Z_31(Z_31),.Z_30(Z_30),.Cin(Cin),.C(C),.CE(CE),.Cout(c1[0]),.Sreg(Sreg[7:0]));
	 (*RLOC="X0Y2"*) first_stage_X_eight X1a2(.pos(pos[15:8]),.neg(neg[15:8]),.Z_31(Z_31),.Z_30(Z_30),.Cin(c1[0]),.C(C),.CE(CE),.Cout(c1[1]),.Sreg(Sreg[15:8]));
	 (*RLOC="X0Y4"*) first_stage_X_eight X1a3(.pos(pos[23:16]),.neg(neg[23:16]),.Z_31(Z_31),.Z_30(Z_30),.Cin(c1[1]),.C(C),.CE(CE),.Cout(c1[2]),.Sreg(Sreg[23:16]));
	 (*RLOC="X0Y6"*) first_stage_X_eight X1a4(.pos(pos[31:24]),.neg(neg[31:24]),.Z_31(Z_31),.Z_30(Z_30),.Cin(c1[2]),.C(C),.CE(CE),.Cout(c1[3]),.Sreg(Sreg[31:24]));
	 
endmodule

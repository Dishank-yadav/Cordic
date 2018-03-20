`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:23:46 12/09/2017 
// Design Name: 
// Module Name:    eight_bit_xz 
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
module eight_bit_xz(
  input [7:0] A,B,
    input Cin,C,CE,CIN,
    output Cout,
	 output [7:0] Sreg
    );
	 wire [7:0] c1,s1,S;
	 assign Cout = c1[7];
	 wire sw;
	(*RLOC="X0Y0"*) (*BEL  =  "A6LUT"*) LUT6 #(.INIT(64'h6969696969696969)) LUT6_inst1 (.O(s1[0]),.I0(A[0]),.I1(B[0]),.I2(CIN),.I3(1'b0),.I4(1'b0),.I5(1'b0));
	(*RLOC="X0Y0"*) (*BEL  =  "B6LUT"*) LUT6 #(.INIT(64'h6969696969696969)) LUT6_inst2 (.O(s1[1]),.I0(A[1]),.I1(B[1]),.I2(CIN),.I3(1'b0),.I4(1'b0),.I5(1'b0));
	(*RLOC="X0Y0"*) (*BEL  =  "C6LUT"*) LUT6 #(.INIT(64'h6969696969696969)) LUT6_inst3 (.O(s1[2]),.I0(A[2]),.I1(B[2]),.I2(CIN),.I3(1'b0),.I4(1'b0),.I5(1'b0));
	(*RLOC="X0Y0"*) (*BEL  =  "D6LUT"*) LUT6 #(.INIT(64'h6969696969696969)) LUT6_inst4 (.O(s1[3]),.I0(A[3]),.I1(B[3]),.I2(CIN),.I3(1'b0),.I4(1'b0),.I5(1'b0));
	
	(*RLOC="X0Y0"*) CARRY4 CARRY4_inst1 (.CO(c1[3:0]),.O(S[3:0]),.CI(Cin),.CYINIT(),.DI(A[3:0]),.S(s1[3:0]));
	(*RLOC="X0Y0"*) (*BEL  =  "AFF"*) FDSE #(.INIT(1'b0)) out_reg1 (.Q(Sreg[0]),.C(C),.CE(CE),.S(1'b0),.D(S[0]));
	(*RLOC="X0Y0"*) (*BEL  =  "BFF"*) FDSE #(.INIT(1'b0)) out_reg2 (.Q(Sreg[1]),.C(C),.CE(CE),.S(1'b0),.D(S[1]));
	(*RLOC="X0Y0"*) (*BEL  =  "CFF"*) FDSE #(.INIT(1'b0)) out_reg3 (.Q(Sreg[2]),.C(C),.CE(CE),.S(1'b0),.D(S[2]));
	(*RLOC="X0Y0"*) (*BEL  =  "DFF"*) FDSE #(.INIT(1'b0)) out_reg4 (.Q(Sreg[3]),.C(C),.CE(CE),.S(1'b0),.D(S[3]));

	(*RLOC="X0Y1"*) (*BEL  =  "A6LUT"*) LUT6 #(.INIT(64'h6969696969696969)) LUT6_inst5 (.O(s1[4]),.I0(A[4]),.I1(B[4]),.I2(CIN),.I3(1'b0),.I4(1'b0),.I5(1'b0));
	(*RLOC="X0Y1"*) (*BEL  =  "B6LUT"*) LUT6 #(.INIT(64'h6969696969696969)) LUT6_inst6 (.O(s1[5]),.I0(A[5]),.I1(B[5]),.I2(CIN),.I3(1'b0),.I4(1'b0),.I5(1'b0));
	(*RLOC="X0Y1"*) (*BEL  =  "C6LUT"*) LUT6 #(.INIT(64'h6969696969696969)) LUT6_inst7 (.O(s1[6]),.I0(A[6]),.I1(B[6]),.I2(CIN),.I3(1'b0),.I4(1'b0),.I5(1'b0));
	(*RLOC="X0Y1"*) (*BEL  =  "D6LUT"*) LUT6 #(.INIT(64'h6969696969696969)) LUT6_inst8 (.O(s1[7]),.I0(A[7]),.I1(B[7]),.I2(CIN),.I3(1'b0),.I4(1'b0),.I5(1'b0));
   
	(*RLOC="X0Y1"*) CARRY4 CARRY4_inst2 (	.CO(c1[7:4]),.O(S[7:4]),.CI(c1[3]),.CYINIT(),.DI(A[7:4]),.S(s1[7:4]));
	(*RLOC="X0Y1"*) (*BEL  =  "AFF"*) FDSE #(.INIT(1'b0)) out_reg5 (.Q(Sreg[4]),.C(C),.CE(CE),.S(1'b0),.D(S[4]));
	(*RLOC="X0Y1"*) (*BEL  =  "BFF"*) FDSE #(.INIT(1'b0)) out_reg6 (.Q(Sreg[5]),.C(C),.CE(CE),.S(1'b0),.D(S[5]));
	(*RLOC="X0Y1"*) (*BEL  =  "CFF"*) FDSE #(.INIT(1'b0)) out_reg7 (.Q(Sreg[6]),.C(C),.CE(CE),.S(1'b0),.D(S[6]));
	(*RLOC="X0Y1"*) (*BEL  =  "DFF"*) FDSE #(.INIT(1'b0)) out_reg8 (.Q(Sreg[7]),.C(C),.CE(CE),.S(1'b0),.D(S[7]));
	
endmodule
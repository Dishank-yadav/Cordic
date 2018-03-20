`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:44:03 12/09/2017 
// Design Name: 
// Module Name:    first_stage_y_eight 
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
module first_stage_y_eight(
    input [7:0] pos,neg,
    input Z_30,Z_31,C,CE,Cin,
    output Cout,
	 output [7:0] Sreg
    );
	 wire [7:0] c1,s1,S;
	 assign Cout = c1[7];
	 wire sw;
	(*RLOC="X0Y0"*) (*BEL  =  "A6LUT"*) LUT6 #(.INIT(64'h99669966CACCCACC)) LUT6_inst1 (.O(s1[0]),.I0(neg[0]),.I1(pos[0]),.I2(Z_30),.I3(Z_31),.I4(1'b0),.I5(1'b0));
	(*RLOC="X0Y0"*) (*BEL  =  "B6LUT"*) LUT6 #(.INIT(64'h99669966CACCCACC)) LUT6_inst2 (.O(s1[1]),.I0(neg[1]),.I1(pos[1]),.I2(Z_30),.I3(Z_31),.I4(1'b0),.I5(1'b0));
	(*RLOC="X0Y0"*) (*BEL  =  "C6LUT"*) LUT6 #(.INIT(64'h99669966CACCCACC)) LUT6_inst3 (.O(s1[2]),.I0(neg[2]),.I1(pos[2]),.I2(Z_30),.I3(Z_31),.I4(1'b0),.I5(1'b0));
	(*RLOC="X0Y0"*) (*BEL  =  "D6LUT"*) LUT6 #(.INIT(64'h99669966CACCCACC)) LUT6_inst4 (.O(s1[3]),.I0(neg[3]),.I1(pos[3]),.I2(Z_30),.I3(Z_31),.I4(1'b0),.I5(1'b0));
	
	(*RLOC="X0Y0"*) CARRY4 CARRY4_inst1 (.CO(c1[3:0]),.O(S[3:0]),.CI(Cin),.CYINIT(),.DI(pos[3:0]),.S(s1[3:0]));
	(*RLOC="X0Y0"*) (*BEL  =  "AFF"*) FDSE #(.INIT(1'b0)) out_reg1 (.Q(Sreg[0]),.C(C),.CE(CE),.S(1'b0),.D(S[0]));
	(*RLOC="X0Y0"*) (*BEL  =  "BFF"*) FDSE #(.INIT(1'b0)) out_reg2 (.Q(Sreg[1]),.C(C),.CE(CE),.S(1'b0),.D(S[1]));
	(*RLOC="X0Y0"*) (*BEL  =  "CFF"*) FDSE #(.INIT(1'b0)) out_reg3 (.Q(Sreg[2]),.C(C),.CE(CE),.S(1'b0),.D(S[2]));
	(*RLOC="X0Y0"*) (*BEL  =  "DFF"*) FDSE #(.INIT(1'b0)) out_reg4 (.Q(Sreg[3]),.C(C),.CE(CE),.S(1'b0),.D(S[3]));

	(*RLOC="X0Y1"*) (*BEL  =  "A6LUT"*) LUT6 #(.INIT(64'h99669966CACCCACC)) LUT6_inst5 (.O(s1[4]),.I0(neg[4]),.I1(pos[4]),.I2(Z_30),.I3(Z_31),.I4(1'b0),.I5(1'b0));
	(*RLOC="X0Y1"*) (*BEL  =  "B6LUT"*) LUT6 #(.INIT(64'h99669966CACCCACC)) LUT6_inst6 (.O(s1[5]),.I0(neg[5]),.I1(pos[5]),.I2(Z_30),.I3(Z_31),.I4(1'b0),.I5(1'b0));
	(*RLOC="X0Y1"*) (*BEL  =  "C6LUT"*) LUT6 #(.INIT(64'h99669966CACCCACC)) LUT6_inst7 (.O(s1[6]),.I0(neg[6]),.I1(pos[6]),.I2(Z_30),.I3(Z_31),.I4(1'b0),.I5(1'b0));
	(*RLOC="X0Y1"*) (*BEL  =  "D6LUT"*) LUT6 #(.INIT(64'h99669966CACCCACC)) LUT6_inst8 (.O(s1[7]),.I0(neg[7]),.I1(pos[7]),.I2(Z_30),.I3(Z_31),.I4(1'b0),.I5(1'b0));
   
	(*RLOC="X0Y1"*) CARRY4 CARRY4_inst2 (	.CO(c1[7:4]),.O(S[7:4]),.CI(c1[3]),.CYINIT(),.DI(pos[7:4]),.S(s1[7:4]));
	(*RLOC="X0Y1"*) (*BEL  =  "AFF"*) FDSE #(.INIT(1'b0)) out_reg5 (.Q(Sreg[4]),.C(C),.CE(CE),.S(1'b0),.D(S[4]));
	(*RLOC="X0Y1"*) (*BEL  =  "BFF"*) FDSE #(.INIT(1'b0)) out_reg6 (.Q(Sreg[5]),.C(C),.CE(CE),.S(1'b0),.D(S[5]));
	(*RLOC="X0Y1"*) (*BEL  =  "CFF"*) FDSE #(.INIT(1'b0)) out_reg7 (.Q(Sreg[6]),.C(C),.CE(CE),.S(1'b0),.D(S[6]));
	(*RLOC="X0Y1"*) (*BEL  =  "DFF"*) FDSE #(.INIT(1'b0)) out_reg8 (.Q(Sreg[7]),.C(C),.CE(CE),.S(1'b0),.D(S[7]));
	
endmodule
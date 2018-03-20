`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:08:28 10/27/2017 
// Design Name: 
// Module Name:    Cordic_computation_adder 
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
module cord(
	 input [31:0] pos,neg,Z,
	 input C,CE,
	 output [31:0] cos,sine,
	 input z_msb_bar,
	 input Z_30_bit
    );
	 wire [31:0] OPX[28:0];
	 wire [31:0] OPY[28:0];
	 wire [31:0] OPZ[27:0];
	 //wire [31:0] cout;
	 // Note: The atan_table was chosen to be 31 bits wide giving resolution up to atan(2^-30)
   wire signed [31:0] atan_table [0:30];
   
   // upper 2 bits = 2'b00 which represents 0 - PI/2 range
   // upper 2 bits = 2'b01 which represents PI/2 to PI range
   // upper 2 bits = 2'b10 which represents PI to 3*PI/2 range (i.e. -PI/2 to -PI)
   // upper 2 bits = 2'b11 which represents 3*PI/2 to 2*PI range (i.e. 0 to -PI/2)
   // The upper 2 bits therefore tell us which quadrant we are in.
   assign atan_table[00] = 32'b00100000000000000000000000000000; // 45.000 degrees -> atan(2^0)
   assign atan_table[01] = 32'b00010010111001000000010100011101; // 26.565 degrees -> atan(2^-1)
   assign atan_table[02] = 32'b00001001111110110011100001011011; // 14.036 degrees -> atan(2^-2)
   assign atan_table[03] = 32'b00000101000100010001000111010100; // atan(2^-3)
   assign atan_table[04] = 32'b00000010100010110000110101000011;
   assign atan_table[05] = 32'b00000001010001011101011111100001;
   assign atan_table[06] = 32'b00000000101000101111011000011110;
   assign atan_table[07] = 32'b00000000010100010111110001010101;
   assign atan_table[08] = 32'b00000000001010001011111001010011;
   assign atan_table[09] = 32'b00000000000101000101111100101110;
   assign atan_table[10] = 32'b00000000000010100010111110011000;
   assign atan_table[11] = 32'b00000000000001010001011111001100;
   assign atan_table[12] = 32'b00000000000000101000101111100110;
   assign atan_table[13] = 32'b00000000000000010100010111110011;
   assign atan_table[14] = 32'b00000000000000001010001011111001;
   assign atan_table[15] = 32'b00000000000000000101000101111101;
   assign atan_table[16] = 32'b00000000000000000010100010111110;
   assign atan_table[17] = 32'b00000000000000000001010001011111;
   assign atan_table[18] = 32'b00000000000000000000101000101111;
   assign atan_table[19] = 32'b00000000000000000000010100011000;
   assign atan_table[20] = 32'b00000000000000000000001010001100;
   assign atan_table[21] = 32'b00000000000000000000000101000110;
   assign atan_table[22] = 32'b00000000000000000000000010100011;
   assign atan_table[23] = 32'b00000000000000000000000001010001;
   assign atan_table[24] = 32'b00000000000000000000000000101000;
   assign atan_table[25] = 32'b00000000000000000000000000010100;
   assign atan_table[26] = 32'b00000000000000000000000000001010;
   assign atan_table[27] = 32'b00000000000000000000000000000101;
   assign atan_table[28] = 32'b00000000000000000000000000000010;
   assign atan_table[29] = 32'b00000000000000000000000000000001; // atan(2^-29)
   assign atan_table[30] = 32'b00000000000000000000000000000000;
   
	 //first instance
   (*RLOC="X0Y0"*) thirty_two_for_Z   Z1 (.A(Z),.B(atan_table[00]),.Cin(Z[31]),.C(C),.CE(CE),.Sreg(OPZ[0]));
	(*RLOC="X0Y8"*) first_stage_X X1 (.pos(pos),.neg(neg),.Z_31(Z[31]),.Z_30(Z_30_bit),.Cin(z_msb_bar),.C(C),.CE(CE),.Sreg(OPX[0]));
	(*RLOC="X0Y16"*) first_stage_Y Y1 (.pos(pos),.neg(neg),.Z_31(Z[31]),.Z_30(Z_30_bit),.C(C),.CE(CE),.Sreg(OPY[0]));
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//thirty_two_for_Z   Z___[28:0] (.A(OPZ[28:0]),.B(atan_table[1:29]),.Cin(cout[28:0]),.C(C),.CE(CE),.Cout(cout[29:1]),.Sreg(OPZ[29:1]));
	/*thirty_two_bit_adder X2[28:0] (.A(OPX[28:0]),.B({OPY[0][31],OPY[0][31],OPY[0][29:0]}),.Cin(cout[0]),.C(C),.CE(CE),.Sreg(OPX[1]));
	thirty_two_bit_adder Y2[28:0] (.A(OPY[0]),.B({OPX[0][31],OPX[0][31],OPX[0][29:0]}),.Cin(OPZ[0][31]),.C(C),.CE(CE),.Sreg(OPY[1]));
	*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

	//second instance
	(*RLOC="X1Y0"*) thirty_two_for_Z     Z2 (.A(OPZ[0]),.B(atan_table[01]),.Cin(OPZ[0][31]),.C(C),.CE(CE),.Sreg(OPZ[1]));
	(*RLOC="X1Y8"*) thirty_two_for_x X2 (.A(OPX[0]),.B({OPY[0][31],OPY[0][31:1]}),.Cin(OPZ[0][31]),.C(C),.CE(CE),.Sreg(OPX[1]));
	(*RLOC="X1Y16"*) thirty_two_for_y Y2 (.A(OPY[0]),.B({OPX[0][31],OPX[0][31:1]}),.Cin(OPZ[0][31]),.C(C),.CE(CE),.Sreg(OPY[1]));
	
	//Third instance	
	(*RLOC="X2Y0"*) thirty_two_for_Z     Z3 (.A(OPZ[1]),.B(atan_table[02]),.Cin(OPZ[1][31]),.C(C),.CE(CE),.Sreg(OPZ[2]));
	(*RLOC="X2Y8"*) thirty_two_for_x X3 (.A(OPX[1]),.B({OPY[1][31],OPY[1][31],OPY[1][31:2]}),.Cin(OPZ[1][31]),.C(C),.CE(CE),.Sreg(OPX[2]));
	(*RLOC="X2Y16"*) thirty_two_for_y Y3 (.A(OPY[1]),.B({OPX[1][31],OPX[1][31],OPX[1][31:2]}),.Cin(OPZ[1][31]),.C(C),.CE(CE),.Sreg(OPY[2]));
	
   //4th instance
	(*RLOC="X3Y0"*) thirty_two_for_Z     Z4 (.A(OPZ[2]),.B(atan_table[03]),.Cin(OPZ[2][31]),.C(C),.CE(CE),.Sreg(OPZ[3]));
	(*RLOC="X3Y8"*) thirty_two_for_x X4 (.A(OPX[2]),.B({{3{OPY[2][31]}},OPY[2][31:3]}),.Cin(OPZ[2][31]),.C(C),.CE(CE),.Sreg(OPX[3]));
	(*RLOC="X3Y16"*) thirty_two_for_y Y4 (.A(OPY[2]),.B({{3{OPX[2][31]}},OPX[2][31:3]}),.Cin(OPZ[2][31]),.C(C),.CE(CE),.Sreg(OPY[3]));	
	
  
   //5th instance
	(*RLOC="X4Y0"*) thirty_two_for_Z     Z5 (.A(OPZ[3]),.B(atan_table[04]),.Cin(OPZ[3][31]),.C(C),.CE(CE),.Sreg(OPZ[4]));
	(*RLOC="X4Y8"*) thirty_two_for_x X5 (.A(OPX[3]),.B({{4{OPY[3][31]}},OPY[3][31:4]}),.Cin(OPZ[3][31]),.C(C),.CE(CE),.Sreg(OPX[4]));
	(*RLOC="X4Y16"*) thirty_two_for_y Y5 (.A(OPY[3]),.B({{4{OPX[3][31]}},OPX[3][31:4]}),.Cin(OPZ[3][31]),.C(C),.CE(CE),.Sreg(OPY[4]));	
	
  
   //6th instance
	(*RLOC="X5Y0"*) thirty_two_for_Z     Z6 (.A(OPZ[4]),.B(atan_table[05]),.Cin(OPZ[4][31]),.C(C),.CE(CE),.Sreg(OPZ[5]));
	(*RLOC="X5Y8"*) thirty_two_for_x X6 (.A(OPX[4]),.B({{5{OPY[4][31]}},OPY[4][31:5]}),.Cin(OPZ[4][31]),.C(C),.CE(CE),.Sreg(OPX[5]));
	(*RLOC="X5Y16"*) thirty_two_for_y Y6 (.A(OPY[4]),.B({{5{OPX[4][31]}},OPX[4][31:5]}),.Cin(OPZ[4][31]),.C(C),.CE(CE),.Sreg(OPY[5]));	
	
  
   //7th instance
	(*RLOC="X6Y0"*) thirty_two_for_Z     Z7 (.A(OPZ[5]),.B(atan_table[06]),.Cin(OPZ[5][31]),.C(C),.CE(CE),.Sreg(OPZ[6]));
	(*RLOC="X6Y8"*) thirty_two_for_x X7 (.A(OPX[5]),.B({{6{OPY[5][31]}},OPY[5][31:6]}),.Cin(OPZ[5][31]),.C(C),.CE(CE),.Sreg(OPX[6]));
	(*RLOC="X6Y16"*) thirty_two_for_y Y7 (.A(OPY[5]),.B({{6{OPX[5][31]}},OPX[5][31:6]}),.Cin(OPZ[5][31]),.C(C),.CE(CE),.Sreg(OPY[6]));	
	
  
   //8th instance
	(*RLOC="X7Y0"*) thirty_two_for_Z     Z8 (.A(OPZ[6]),.B(atan_table[07]),.Cin(OPZ[6][31]),.C(C),.CE(CE),.Sreg(OPZ[7]));
	(*RLOC="X7Y8"*) thirty_two_for_x X8 (.A(OPX[6]),.B({{7{OPY[6][31]}},OPY[6][31:7]}),.Cin(OPZ[6][31]),.C(C),.CE(CE),.Sreg(OPX[7]));
	(*RLOC="X7Y16"*) thirty_two_for_y Y8 (.A(OPY[6]),.B({{7{OPX[6][31]}},OPX[6][31:7]}),.Cin(OPZ[6][31]),.C(C),.CE(CE),.Sreg(OPY[7]));	

  
   //9th instance
	(*RLOC="X8Y0"*) thirty_two_for_Z     Z9 (.A(OPZ[7]),.B(atan_table[08]),.Cin(OPZ[7][31]),.C(C),.CE(CE),.Sreg(OPZ[8]));
	(*RLOC="X8Y8"*) thirty_two_for_x X9 (.A(OPX[7]),.B({{8{OPY[7][31]}},OPY[7][31:8]}),.Cin(OPZ[7][31]),.C(C),.CE(CE),.Sreg(OPX[8]));
	(*RLOC="X8Y16"*) thirty_two_for_y Y9 (.A(OPY[7]),.B({{8{OPX[7][31]}},OPX[7][31:8]}),.Cin(OPZ[7][31]),.C(C),.CE(CE),.Sreg(OPY[8]));	
	
  
   //10th instance
	(*RLOC="X9Y0"*) thirty_two_for_Z     Z10 (.A(OPZ[8]),.B(atan_table[09]),.Cin(OPZ[8][31]),.C(C),.CE(CE),.Sreg(OPZ[9]));
	(*RLOC="X9Y8"*) thirty_two_for_x X10 (.A(OPX[8]),.B({{9{OPY[8][31]}},OPY[8][31:9]}),.Cin(OPZ[8][31]),.C(C),.CE(CE),.Sreg(OPX[9]));
	(*RLOC="X9Y16"*) thirty_two_for_y Y10 (.A(OPY[8]),.B({{9{OPX[8][31]}},OPX[8][31:9]}),.Cin(OPZ[8][31]),.C(C),.CE(CE),.Sreg(OPY[9]));	
	
  
   //11th instance
	(*RLOC="X10Y0"*) thirty_two_for_Z     Z11 (.A(OPZ[9]),.B(atan_table[10]),.Cin(OPZ[9][31]),.C(C),.CE(CE),.Sreg(OPZ[10]));
	(*RLOC="X10Y8"*) thirty_two_for_x X11 (.A(OPX[9]),.B({{10{OPY[9][31]}},OPY[9][31:10]}),.Cin(OPZ[9][31]),.C(C),.CE(CE),.Sreg(OPX[10]));
	(*RLOC="X10Y16"*) thirty_two_for_y Y11 (.A(OPY[9]),.B({{10{OPX[9][31]}},OPX[9][31:10]}),.Cin(OPZ[9][31]),.C(C),.CE(CE),.Sreg(OPY[10]));	
	
  
   //12th instance
	(*RLOC="X11Y0"*) thirty_two_for_Z     Z12 (.A(OPZ[10]),.B(atan_table[11]),.Cin(OPZ[10][31]),.C(C),.CE(CE),.Sreg(OPZ[11]));
	(*RLOC="X11Y8"*) thirty_two_for_x X12 (.A(OPX[10]),.B({{11{OPY[10][31]}},OPY[10][31:11]}),.Cin(OPZ[10][31]),.C(C),.CE(CE),.Sreg(OPX[11]));
	(*RLOC="X11Y16"*) thirty_two_for_y Y12 (.A(OPY[10]),.B({{11{OPX[10][31]}},OPX[10][31:11]}),.Cin(OPZ[10][31]),.C(C),.CE(CE),.Sreg(OPY[11]));	
	
  
   //13th instance
	(*RLOC="X12Y0"*) thirty_two_for_Z     Z13 (.A(OPZ[11]),.B(atan_table[12]),.Cin(OPZ[11][31]),.C(C),.CE(CE),.Sreg(OPZ[12]));
	(*RLOC="X12Y8"*) thirty_two_for_x X13 (.A(OPX[11]),.B({{12{OPY[11][31]}},OPY[11][31:12]}),.Cin(OPZ[11][31]),.C(C),.CE(CE),.Sreg(OPX[12]));
	(*RLOC="X12Y16"*) thirty_two_for_y Y13 (.A(OPY[11]),.B({{12{OPX[11][31]}},OPX[11][31:12]}),.Cin(OPZ[11][31]),.C(C),.CE(CE),.Sreg(OPY[12]));	
	
  
   //14th instance
	(*RLOC="X13Y0"*) thirty_two_for_Z     Z14 (.A(OPZ[12]),.B(atan_table[13]),.Cin(OPZ[12][31]),.C(C),.CE(CE),.Sreg(OPZ[13]));
	(*RLOC="X13Y8"*) thirty_two_for_x X14 (.A(OPX[12]),.B({{13{OPY[12][31]}},OPY[12][31:13]}),.Cin(OPZ[12][31]),.C(C),.CE(CE),.Sreg(OPX[13]));
	(*RLOC="X13Y16"*) thirty_two_for_y Y14 (.A(OPY[12]),.B({{13{OPX[12][31]}},OPX[12][31:13]}),.Cin(OPZ[12][31]),.C(C),.CE(CE),.Sreg(OPY[13]));	
	
  
   //15th instance
	(*RLOC="X14Y0"*) thirty_two_for_Z     Z15 (.A(OPZ[13]),.B(atan_table[14]),.Cin(OPZ[13][31]),.C(C),.CE(CE),.Sreg(OPZ[14]));
	(*RLOC="X14Y8"*) thirty_two_for_x X15 (.A(OPX[13]),.B({{14{OPY[13][31]}},OPY[13][31:14]}),.Cin(OPZ[13][31]),.C(C),.CE(CE),.Sreg(OPX[14]));
	(*RLOC="X14Y16"*) thirty_two_for_y Y15 (.A(OPY[13]),.B({{14{OPX[13][31]}},OPX[13][31:14]}),.Cin(OPZ[13][31]),.C(C),.CE(CE),.Sreg(OPY[14]));	
	
  
   //16th instance
	(*RLOC="X15Y0"*) thirty_two_for_Z     Z16 (.A(OPZ[14]),.B(atan_table[15]),.Cin(OPZ[14][31]),.C(C),.CE(CE),.Sreg(OPZ[15]));
	(*RLOC="X15Y8"*) thirty_two_for_x X16 (.A(OPX[14]),.B({{15{OPY[14][31]}},OPY[14][31:15]}),.Cin(OPZ[14][31]),.C(C),.CE(CE),.Sreg(OPX[15]));
	(*RLOC="X15Y16"*) thirty_two_for_y Y16 (.A(OPY[14]),.B({{15{OPX[14][31]}},OPX[14][31:15]}),.Cin(OPZ[14][31]),.C(C),.CE(CE),.Sreg(OPY[15]));	
	
  
   //17th instance
	(*RLOC="X16Y0"*) thirty_two_for_Z     Z17 (.A(OPZ[15]),.B(atan_table[16]),.Cin(OPZ[15][31]),.C(C),.CE(CE),.Sreg(OPZ[16]));
	(*RLOC="X16Y8"*) thirty_two_for_x X17 (.A(OPX[15]),.B({{16{OPY[15][31]}},OPY[15][31:16]}),.Cin(OPZ[15][31]),.C(C),.CE(CE),.Sreg(OPX[16]));
	(*RLOC="X16Y16"*) thirty_two_for_y Y17 (.A(OPY[15]),.B({{16{OPX[15][31]}},OPX[15][31:16]}),.Cin(OPZ[15][31]),.C(C),.CE(CE),.Sreg(OPY[16]));	
	
  
   //18th instance
	(*RLOC="X17Y0"*) thirty_two_for_Z     Z18 (.A(OPZ[16]),.B(atan_table[17]),.Cin(OPZ[16][31]),.C(C),.CE(CE),.Sreg(OPZ[17]));
	(*RLOC="X17Y8"*) thirty_two_for_x X18 (.A(OPX[16]),.B({{17{OPY[16][31]}},OPY[16][31:17]}),.Cin(OPZ[16][31]),.C(C),.CE(CE),.Sreg(OPX[17]));
	(*RLOC="X17Y16"*) thirty_two_for_y Y18 (.A(OPY[16]),.B({{17{OPX[16][31]}},OPX[16][31:17]}),.Cin(OPZ[16][31]),.C(C),.CE(CE),.Sreg(OPY[17]));	
	
  
   //19th instance
	(*RLOC="X18Y0"*) thirty_two_for_Z     Z19 (.A(OPZ[17]),.B(atan_table[18]),.Cin(OPZ[17][31]),.C(C),.CE(CE),.Sreg(OPZ[18]));
	(*RLOC="X18Y8"*) thirty_two_for_x X19 (.A(OPX[17]),.B({{18{OPY[17][31]}},OPY[17][31:18]}),.Cin(OPZ[17][31]),.C(C),.CE(CE),.Sreg(OPX[18]));
	(*RLOC="X18Y16"*) thirty_two_for_y Y19 (.A(OPY[17]),.B({{18{OPX[17][31]}},OPX[17][31:18]}),.Cin(OPZ[17][31]),.C(C),.CE(CE),.Sreg(OPY[18]));	
	
  
   //20th instance
	(*RLOC="X19Y0"*) thirty_two_for_Z     Z20 (.A(OPZ[18]),.B(atan_table[19]),.Cin(OPZ[18][31]),.C(C),.CE(CE),.Sreg(OPZ[19]));
	(*RLOC="X19Y8"*) thirty_two_for_x X20 (.A(OPX[18]),.B({{19{OPY[18][31]}},OPY[18][31:19]}),.Cin(OPZ[18][31]),.C(C),.CE(CE),.Sreg(OPX[19]));
	(*RLOC="X19Y16"*) thirty_two_for_y Y20 (.A(OPY[18]),.B({{19{OPX[18][31]}},OPX[18][31:19]}),.Cin(OPZ[18][31]),.C(C),.CE(CE),.Sreg(OPY[19]));	
	
  
   //21th instance
	(*RLOC="X20Y0"*) thirty_two_for_Z     Z21 (.A(OPZ[19]),.B(atan_table[20]),.Cin(OPZ[19][31]),.C(C),.CE(CE),.Sreg(OPZ[20]));
	(*RLOC="X20Y8"*) thirty_two_for_x X21 (.A(OPX[19]),.B({{20{OPY[19][31]}},OPY[19][31:20]}),.Cin(OPZ[19][31]),.C(C),.CE(CE),.Sreg(OPX[20]));
	(*RLOC="X20Y16"*) thirty_two_for_y Y21 (.A(OPY[19]),.B({{20{OPX[19][31]}},OPX[19][31:20]}),.Cin(OPZ[19][31]),.C(C),.CE(CE),.Sreg(OPY[20]));	
	
  
   //22th instance
	(*RLOC="X21Y0"*) thirty_two_for_Z     Z22 (.A(OPZ[20]),.B(atan_table[21]),.Cin(OPZ[20][31]),.C(C),.CE(CE),.Sreg(OPZ[21]));
	(*RLOC="X21Y8"*) thirty_two_for_x X22 (.A(OPX[20]),.B({{21{OPY[20][31]}},OPY[20][31:21]}),.Cin(OPZ[20][31]),.C(C),.CE(CE),.Sreg(OPX[21]));
	(*RLOC="X21Y16"*) thirty_two_for_y Y22 (.A(OPY[20]),.B({{21{OPX[20][31]}},OPX[20][31:21]}),.Cin(OPZ[20][31]),.C(C),.CE(CE),.Sreg(OPY[21]));	
	
  
   //23th instance
	(*RLOC="X22Y0"*) thirty_two_for_Z     Z23 (.A(OPZ[21]),.B(atan_table[22]),.Cin(OPZ[21][31]),.C(C),.CE(CE),.Sreg(OPZ[22]));
	(*RLOC="X22Y8"*) thirty_two_for_x X23 (.A(OPX[21]),.B({{22{OPY[21][31]}},OPY[21][31:22]}),.Cin(OPZ[21][31]),.C(C),.CE(CE),.Sreg(OPX[22]));
	(*RLOC="X22Y16"*) thirty_two_for_y Y23 (.A(OPY[21]),.B({{22{OPX[21][31]}},OPX[21][31:22]}),.Cin(OPZ[21][31]),.C(C),.CE(CE),.Sreg(OPY[22]));	
	
  
   //24th instance
	(*RLOC="X23Y0"*) thirty_two_for_Z     Z24 (.A(OPZ[22]),.B(atan_table[23]),.Cin(OPZ[22][31]),.C(C),.CE(CE),.Sreg(OPZ[23]));
	(*RLOC="X23Y8"*) thirty_two_for_x X24 (.A(OPX[22]),.B({{23{OPY[22][31]}},OPY[22][31:23]}),.Cin(OPZ[22][31]),.C(C),.CE(CE),.Sreg(OPX[23]));
	(*RLOC="X23Y16"*) thirty_two_for_y Y24 (.A(OPY[22]),.B({{23{OPX[22][31]}},OPX[22][31:23]}),.Cin(OPZ[22][31]),.C(C),.CE(CE),.Sreg(OPY[23]));	
	
  
   //25th instance
	(*RLOC="X24Y0"*) thirty_two_for_Z     Z25 (.A(OPZ[23]),.B(atan_table[24]),.Cin(OPZ[23][31]),.C(C),.CE(CE),.Sreg(OPZ[24]));
	(*RLOC="X24Y8"*) thirty_two_for_x X25 (.A(OPX[23]),.B({{24{OPY[23][31]}},OPY[23][31:24]}),.Cin(OPZ[23][31]),.C(C),.CE(CE),.Sreg(OPX[24]));
	(*RLOC="X24Y16"*) thirty_two_for_y Y25 (.A(OPY[23]),.B({{24{OPX[23][31]}},OPX[23][31:24]}),.Cin(OPZ[23][31]),.C(C),.CE(CE),.Sreg(OPY[24]));	
	
  
   //26th instance
	(*RLOC="X25Y0"*) thirty_two_for_Z     Z26 (.A(OPZ[24]),.B(atan_table[25]),.Cin(OPZ[24][31]),.C(C),.CE(CE),.Sreg(OPZ[25]));
	(*RLOC="X25Y8"*) thirty_two_for_x X26 (.A(OPX[24]),.B({{25{OPY[24][31]}},OPY[24][31:25]}),.Cin(OPZ[24][31]),.C(C),.CE(CE),.Sreg(OPX[25]));
	(*RLOC="X25Y16"*) thirty_two_for_y Y26 (.A(OPY[24]),.B({{25{OPX[24][31]}},OPX[24][31:25]}),.Cin(OPZ[24][31]),.C(C),.CE(CE),.Sreg(OPY[25]));	
	
  
   //27th instance
	(*RLOC="X26Y0"*) thirty_two_for_Z     Z27 (.A(OPZ[25]),.B(atan_table[26]),.Cin(OPZ[25][31]),.C(C),.CE(CE),.Sreg(OPZ[26]));
	(*RLOC="X26Y8"*) thirty_two_for_x X27 (.A(OPX[25]),.B({{26{OPY[25][31]}},OPY[25][31:26]}),.Cin(OPZ[25][31]),.C(C),.CE(CE),.Sreg(OPX[26]));
	(*RLOC="X26Y16"*) thirty_two_for_y Y27 (.A(OPY[25]),.B({{26{OPX[25][31]}},OPX[25][31:26]}),.Cin(OPZ[25][31]),.C(C),.CE(CE),.Sreg(OPY[26]));	
	
  
   //28th instance
	(*RLOC="X27Y0"*) thirty_two_for_Z     Z28 (.A(OPZ[26]),.B(atan_table[27]),.Cin(OPZ[26][31]),.C(C),.CE(CE),.Sreg(OPZ[27]));
	(*RLOC="X27Y8"*) thirty_two_for_x X28 (.A(OPX[26]),.B({{27{OPY[26][31]}},OPY[26][31:27]}),.Cin(OPZ[26][31]),.C(C),.CE(CE),.Sreg(OPX[27]));
	(*RLOC="X27Y16"*) thirty_two_for_y Y28 (.A(OPY[26]),.B({{27{OPX[26][31]}},OPX[26][31:27]}),.Cin(OPZ[26][31]),.C(C),.CE(CE),.Sreg(OPY[27]));	
	
  
   //29th instance
	//(*RLOC="X28Y0"*) thirty_two_for_Z     Z29 (.A(OPZ[27]),.B(atan_table[28]),.Cin(OPZ[27][31]),.C(C),.CE(CE),.Sreg(OPZ[28]));
	(*RLOC="X28Y8"*) thirty_two_for_x X29 (.A(OPX[27]),.B({{28{OPY[27][31]}},OPY[27][31:28]}),.Cin(OPZ[27][31]),.C(C),.CE(CE),.Sreg(OPX[28]));
	(*RLOC="X28Y16"*) thirty_two_for_y Y29 (.A(OPY[27]),.B({{28{OPX[27][31]}},OPX[27][31:28]}),.Cin(OPZ[27][31]),.C(C),.CE(CE),.Sreg(OPY[28]));	
	
  
   //30th instance
	//(*RLOC="X29Y0"*) thirty_two_for_Z     Z30 (.A(OPZ[28]),.B(atan_table[29]),.Cin(OPZ[28][31]),.C(C),.CE(CE),.Sreg(OPZ[29]));
	//(*RLOC="X29Y8"*) thirty_two_for_x X30 (.A(OPX[28]),.B({{29{OPY[28][31]}},OPY[28][31:29]}),.Cin(OPZ[28][31]),.C(C),.CE(CE),.Sreg(OPX[29]));
	//(*RLOC="X29Y16"*) thirty_two_for_y Y30 (.A(OPY[28]),.B({{29{OPX[28][31]}},OPX[28][31:29]}),.Cin(OPZ[28][31]),.C(C),.CE(CE),.Sreg(OPY[29]));	
	
  assign sine = OPY[28];
  assign cos = OPX[28];
 

endmodule

`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:20:19 12/24/2017
// Design Name:   Cordic_computation_adder
// Module Name:   F:/fpga/cc/test_overall.v
// Project Name:  cc
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Cordic_computation_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_overall;

	// Inputs
	reg [31:0] X;
	reg [31:0] Y;
	reg [31:0] Z;
	reg C;
	reg CE;

	// Outputs
	wire [31:0] cos;
	wire [31:0] sine;

	// Instantiate the Unit Under Test (UUT)
	Cordic_computation_adder uut (
		.X(X), 
		.Y(Y), 
		.Z(Z), 
		.C(C), 
		.CE(CE), 
		.cos(cos), 
		.sine(sine)
	);

	initial begin
		// Initialize Inputs
		X = 16777216;
		Y = 16777216;
		Z = 0;
		C = 0;
		CE = 1;

		// Wait 100 ns for global reset to finish
		#100;
       Z = ;
      # 20;
       Z = 0;	
      # 20;
       Z =0;
      # 20;
       Z = 0;
      # 20;
       Z = 0;		 



		 
		// Add stimulus here

	end
	
	always 
	 begin
	   #5 C =!C;
	 end	
      
endmodule


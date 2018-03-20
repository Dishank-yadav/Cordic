`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:04:09 11/03/2017 
// Design Name: 
// Module Name:    post_proc 
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
module post_proc( sine,cos, sine_out, cos_out,C,CE   );

	input wire [31:0] sine,cos;
	output wire [31:0] sine_out, cos_out ;
	input wire C,CE;
	wire [31:0]  sine_a,sine_b,sine_c,sine_c_delayed,sine_d, cos_a,cos_b,cos_c,cos_c_delayed,cos_d ;


	(*RLOC="X0Y0"*) thirty_two_bit_adder post_sine_1 (.A({{1{sine[31]}},sine[31:1]}),.B({{3{sine[31]}},sine[31:3]}),.Cin(1'b0),.C(C),.CE(CE),.Sreg(sine_a));
	(*RLOC="X0Y8"*) thirty_two_bit_adder post_sine_2 (.A({{6{sine[31]}},sine[31:6]}),.B({{9{sine[31]}},sine[31:9]}),.Cin(1'b0),.C(C),.CE(CE),.Sreg(sine_b));
	(*RLOC="X0Y16"*) thirty_two_bit_adder post_sine_3 (.A({{12{sine[31]}},sine[31:12]}),.B({{14{sine[31]}},sine[31:14]}),.Cin(1'b1),.C(C),.CE(CE),.Sreg(sine_c));
	(*RLOC="X1Y0"*) thirty_two_bit_adder post_sine_4 (.A(sine_a),.B(sine_b),.Cin(1'b1),.C(C),.CE(CE),.Sreg(sine_d));
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   //(*RLOC="X0Y0"*) FDSE #(.INIT(1'b0)) sine_delay [31:0] (.Q(sine_c_delayed),.C(C),.CE(CE),.S(1'b0),.D(sine_c));
	
	     (*RLOC={"X1Y16" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) sine_delay_0 (.Q(sine_c_delayed[0]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[0]));
		  (*RLOC={"X1Y16" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) sine_delay_1 (.Q(sine_c_delayed[1]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[1]));
		  (*RLOC={"X1Y16" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) sine_delay_2 (.Q(sine_c_delayed[2]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[2]));
		  (*RLOC={"X1Y16" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) sine_delay_3 (.Q(sine_c_delayed[3]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[3]));
		  
		  (*RLOC={"X1Y17" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) sine_delay_4 (.Q(sine_c_delayed[4]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[4]));
		  (*RLOC={"X1Y17" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) sine_delay_5 (.Q(sine_c_delayed[5]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[5]));
		  (*RLOC={"X1Y17" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) sine_delay_6 (.Q(sine_c_delayed[6]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[6]));
		  (*RLOC={"X1Y17" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) sine_delay_7 (.Q(sine_c_delayed[7]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[7]));
		          
		  (*RLOC={"X1Y18" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) sine_delay_8 (.Q(sine_c_delayed[8]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[8]));
		  (*RLOC={"X1Y18" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) sine_delay_9 (.Q(sine_c_delayed[9]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[9]));
		  (*RLOC={"X1Y18" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) sine_delay_10 (.Q(sine_c_delayed[10]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[10]));
		  (*RLOC={"X1Y18" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) sine_delay_11 (.Q(sine_c_delayed[11]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[11]));

        (*RLOC={"X1Y19" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) sine_delay_12 (.Q(sine_c_delayed[12]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[12]));
		  (*RLOC={"X1Y19" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) sine_delay_13 (.Q(sine_c_delayed[13]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[13]));
		  (*RLOC={"X1Y19" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) sine_delay_14 (.Q(sine_c_delayed[14]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[14]));
		  (*RLOC={"X1Y19" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) sine_delay_15 (.Q(sine_c_delayed[15]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[15]));
        
		  (*RLOC={"X1Y20" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) sine_delay_16 (.Q(sine_c_delayed[16]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[16]));
		  (*RLOC={"X1Y20" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) sine_delay_17 (.Q(sine_c_delayed[17]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[17]));
		  (*RLOC={"X1Y20" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) sine_delay_18 (.Q(sine_c_delayed[18]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[18]));
		  (*RLOC={"X1Y20" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) sine_delay_19 (.Q(sine_c_delayed[19]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[19]));

        (*RLOC={"X1Y21" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) sine_delay_20 (.Q(sine_c_delayed[20]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[20]));
		  (*RLOC={"X1Y21" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) sine_delay_21 (.Q(sine_c_delayed[21]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[21]));
		  (*RLOC={"X1Y21" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) sine_delay_22 (.Q(sine_c_delayed[22]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[22]));
		  (*RLOC={"X1Y21" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) sine_delay_23 (.Q(sine_c_delayed[23]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[23]));
        
		  (*RLOC={"X1Y22" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) sine_delay_24 (.Q(sine_c_delayed[24]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[24]));
		  (*RLOC={"X1Y22" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) sine_delay_25 (.Q(sine_c_delayed[25]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[25]));
		  (*RLOC={"X1Y22" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) sine_delay_26 (.Q(sine_c_delayed[26]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[26]));
		  (*RLOC={"X1Y22" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) sine_delay_27 (.Q(sine_c_delayed[27]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[27]));

        (*RLOC={"X1Y23" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) sine_delay_28 (.Q(sine_c_delayed[28]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[28]));
		  (*RLOC={"X1Y23" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) sine_delay_29 (.Q(sine_c_delayed[29]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[29]));
        (*RLOC={"X1Y23" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) sine_delay_30 (.Q(sine_c_delayed[30]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[30]));
		  (*RLOC={"X1Y23" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) sine_delay_31 (.Q(sine_c_delayed[31]),.C(C),.CE(CE),.S(1'b0),.D(sine_c[31]));


	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	(*RLOC="X2Y0"*) thirty_two_bit_adder post_sine_5 (.A(sine_c_delayed),.B(sine_d),.Cin(1'b1),.C(C),.CE(CE),.Sreg(sine_out));
	
	
	
	
	(*RLOC="X0Y24"*) thirty_two_bit_adder post_cos_1 (.A({{1{cos[31]}},cos[31:1]}),.B({{3{cos[31]}},cos[31:3]}),.Cin(1'b0),.C(C),.CE(CE),.Sreg(cos_a));
	(*RLOC="X0Y32"*) thirty_two_bit_adder post_cos_2 (.A({{6{cos[31]}},cos[31:6]}),.B({{9{cos[31]}},cos[31:9]}),.Cin(1'b0),.C(C),.CE(CE),.Sreg(cos_b));
	(*RLOC="X0Y40"*) thirty_two_bit_adder post_cos_3 (.A({{12{cos[31]}},cos[31:12]}),.B({{14{cos[31]}},cos[31:14]}),.Cin(1'b1),.C(C),.CE(CE),.Sreg(cos_c));
	(*RLOC="X1Y24"*) thirty_two_bit_adder post_cos_4 (.A(cos_a),.B(cos_b),.Cin(1'b1),.C(C),.CE(CE),.Sreg(cos_d));
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   /////(*RLOC="X0Y0"*) FDSE #(.INIT(1'b0)) cos_delay [31:0] (.Q(cos_c_delayed),.C(C),.CE(CE),.S(1'b0),.D(cos_c));
	
	     (*RLOC={"X1Y40" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) cos_delay_0 (.Q(cos_c_delayed[0]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[0]));
		  (*RLOC={"X1Y40" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) cos_delay_1 (.Q(cos_c_delayed[1]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[1]));
		  (*RLOC={"X1Y40" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) cos_delay_2 (.Q(cos_c_delayed[2]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[2]));
		  (*RLOC={"X1Y40" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) cos_delay_3 (.Q(cos_c_delayed[3]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[3]));
		  
		  (*RLOC={"X1Y41" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) cos_delay_4 (.Q(cos_c_delayed[4]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[4]));
		  (*RLOC={"X1Y41" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) cos_delay_5 (.Q(cos_c_delayed[5]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[5]));
		  (*RLOC={"X1Y41" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) cos_delay_6 (.Q(cos_c_delayed[6]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[6]));
		  (*RLOC={"X1Y41" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) cos_delay_7 (.Q(cos_c_delayed[7]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[7]));
		          
		  (*RLOC={"X1Y42" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) cos_delay_8 (.Q(cos_c_delayed[8]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[8]));
		  (*RLOC={"X1Y42" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) cos_delay_9 (.Q(cos_c_delayed[9]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[9]));
		  (*RLOC={"X1Y42" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) cos_delay_10 (.Q(cos_c_delayed[10]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[10]));
		  (*RLOC={"X1Y42" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) cos_delay_11 (.Q(cos_c_delayed[11]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[11]));

        (*RLOC={"X1Y43" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) cos_delay_12 (.Q(cos_c_delayed[12]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[12]));
		  (*RLOC={"X1Y43" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) cos_delay_13 (.Q(cos_c_delayed[13]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[13]));
		  (*RLOC={"X1Y43" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) cos_delay_14 (.Q(cos_c_delayed[14]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[14]));
		  (*RLOC={"X1Y43" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) cos_delay_15 (.Q(cos_c_delayed[15]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[15]));
        
		  (*RLOC={"X1Y44" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) cos_delay_16 (.Q(cos_c_delayed[16]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[16]));
		  (*RLOC={"X1Y44" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) cos_delay_17 (.Q(cos_c_delayed[17]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[17]));
		  (*RLOC={"X1Y44" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) cos_delay_18 (.Q(cos_c_delayed[18]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[18]));
		  (*RLOC={"X1Y44" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) cos_delay_19 (.Q(cos_c_delayed[19]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[19]));

        (*RLOC={"X1Y45" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) cos_delay_20 (.Q(cos_c_delayed[20]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[20]));
		  (*RLOC={"X1Y45" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) cos_delay_21 (.Q(cos_c_delayed[21]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[21]));
		  (*RLOC={"X1Y45" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) cos_delay_22 (.Q(cos_c_delayed[22]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[22]));
		  (*RLOC={"X1Y45" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) cos_delay_23 (.Q(cos_c_delayed[23]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[23]));
        
		  (*RLOC={"X1Y46" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) cos_delay_24 (.Q(cos_c_delayed[24]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[24]));
		  (*RLOC={"X1Y46" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) cos_delay_25 (.Q(cos_c_delayed[25]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[25]));
		  (*RLOC={"X1Y46" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) cos_delay_26 (.Q(cos_c_delayed[26]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[26]));
		  (*RLOC={"X1Y46" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) cos_delay_27 (.Q(cos_c_delayed[27]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[27]));

        (*RLOC={"X1Y47" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) cos_delay_28 (.Q(cos_c_delayed[28]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[28]));
		  (*RLOC={"X1Y47" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) cos_delay_29 (.Q(cos_c_delayed[29]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[29]));
        (*RLOC={"X1Y47" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) cos_delay_30 (.Q(cos_c_delayed[30]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[30]));
		  (*RLOC={"X1Y47" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) cos_delay_31 (.Q(cos_c_delayed[31]),.C(C),.CE(CE),.S(1'b0),.D(cos_c[31]));

	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	(*RLOC="X2Y24"*) thirty_two_bit_adder post_cos_5 (.A(cos_c_delayed),.B(cos_d),.Cin(1'b1),.C(C),.CE(CE),.Sreg(cos_out));
	



endmodule

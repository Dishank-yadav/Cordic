`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:18:59 10/31/2017 
// Design Name: 
// Module Name:    twocomplement 
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
module pre_proc(Z,X,Y,_Z_,pos,neg,msb_not,C,CE,Z_30_bit);

input wire [31:0] Z,X,Y;
input wire C,CE;
output wire [31:0] _Z_,pos,neg;
output wire msb_not , Z_30_bit;

wire [31:0] pos_w,neg_w;
wire [31:0] carry_prop ;
wire [31:0] bar ;
wire carry__in ;

wire [31:0] Z0 ;
wire [31:0] Z1 ;



//          Input angle is a modulo of 2*PI scaled to fit in a 32bit register. The user must translate
//          this angle to a value from 0 - (2^32-1).  0 deg = 32'h0, 359.9999... = 32'hFF_FF_FF_FF
//          To translate from degrees to a 32 bit value, multiply 2^32 by the angle (in degrees),
//          then divide by 360

   // upper 2 bits = 2'b00 which represents 0 - PI/2 range
   // upper 2 bits = 2'b01 which represents PI/2 to PI range
   // upper 2 bits = 2'b10 which represents PI to 3*PI/2 range (i.e. -PI/2 to -PI)
   // upper 2 bits = 2'b11 which represents 3*PI/2 to 2*PI range (i.e. 0 to -PI/2)
   // The upper 2 bits therefore tell us which quadrant we are in.
	
	
/*
     z[31:30] = 2'b00 , 2'b11 => no pre-rotation needed for these quadrants
            X[0] = Xin
            Y[0] = Yin
            Z[0] = angle
         
         
        z[31:30] =  2'b01:
            X[0] = -Yin
            Y[0] = Xin
            Z[0] = {2'b00,angle[29:0]} // subtract pi/2 from angle for this quadrant
         
         z[31:30] =  2'b10:
            X[0] = Yin
            Y[0] = -Xin
            Z[0] = {2'b11,angle[29:0]} // add pi/2 to angle for this quadrant
 */ 


(*RLOC={"X-1Y0"}*) LUT6_2 #(.INIT(64'h3333333366666666)) carry_in_msb_not (.O6(msb_not),.O5(carry__in),.I0(Z[30]),.I1(Z[31]),.I2(1'b0),.I3(1'b0),.I4(1'b0),.I5(1'b1));

//  carry__in = z[30] ^ z[31] (if carry__in = 0 no change needed; if carry__in= 1 change needed )



   //assign Z0 [31:0] = {Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30]};
   //assign Z1 [31:0] = {Z[31],Z[31],Z[31],Z[31],Z[31],Z[31],Z[31],Z[31],Z[31],Z[31],Z[31],Z[31],Z[31],Z[31],Z[31],Z[31],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30],Z[30]};
   // (*RLOC={"X0Y0","X0Y0","X0Y0","X0Y0"  ,  "X0Y1","X0Y1","X0Y1","X0Y1"  ,  "X0Y2","X0Y2","X0Y2","X0Y2"  ,  "X0Y3","X0Y3","X0Y3","X0Y3"  ,  "X0Y4","X0Y4","X0Y4","X0Y4" , "X0Y5","X0Y5","X0Y5","X0Y5"  ,  "X0Y6","X0Y6","X0Y6","X0Y6"  ,  "X0Y7","X0Y7","X0Y7","X0Y7" }*) 
	// (*BEL ={"A6LUT","B6LUT","C6LUT","D6LUT" , "A6LUT","B6LUT","C6LUT","D6LUT" , "A6LUT","B6LUT","C6LUT","D6LUT" , "A6LUT","B6LUT","C6LUT","D6LUT" , "A6LUT","B6LUT","C6LUT","D6LUT" , "A6LUT","B6LUT","C6LUT","D6LUT" , "A6LUT","B6LUT","C6LUT","D6LUT" , "A6LUT","B6LUT","C6LUT","D6LUT"}*)
	// LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit[31:0] (.O6(bar[31:0]),.O5(pos_w[31:0]),.I0(Y[31:0]),.I1(X[31:0]),.I2(Z0[31:0]),.I3(Z1[31:0]),.I4(32'b0),.I5(32'hFFFFFFFF));
    
	 /*
	    below LUTs and carry chain take two' complement of one of x and y and leave other untouched depending on or leave both untouched Z[31:30]
		  z[31:30] = 2'b00 both untouched -> pos = Xin   neg = Yin
	     z[31:30] = 2'b11 both untouched -> pos = Yin   neg = Xin
		  z[31:30] = 2'b01 both untouched -> pos = Xin   neg = -Yin
	     z[31:30] = 2'b10 both untouched -> pos = Yin   neg = -Xin
	 
	 */
	 
	 (*RLOC={"X0Y0"}*) (*BEL ={"A6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_0 (.O6(bar[0]),.O5(pos_w[0]),.I0(Y[0]),.I1(X[0]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y0"}*) (*BEL ={"B6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_1 (.O6(bar[1]),.O5(pos_w[1]),.I0(Y[1]),.I1(X[1]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y0"}*) (*BEL ={"C6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_2 (.O6(bar[2]),.O5(pos_w[2]),.I0(Y[2]),.I1(X[2]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y0"}*) (*BEL ={"D6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_3 (.O6(bar[3]),.O5(pos_w[3]),.I0(Y[3]),.I1(X[3]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 
	 (*RLOC={"X0Y1"}*) (*BEL ={"A6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_4 (.O6(bar[4]),.O5(pos_w[4]),.I0(Y[4]),.I1(X[4]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y1"}*) (*BEL ={"B6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_5 (.O6(bar[5]),.O5(pos_w[5]),.I0(Y[5]),.I1(X[5]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y1"}*) (*BEL ={"C6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_6 (.O6(bar[6]),.O5(pos_w[6]),.I0(Y[6]),.I1(X[6]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y1"}*) (*BEL ={"D6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_7 (.O6(bar[7]),.O5(pos_w[7]),.I0(Y[7]),.I1(X[7]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 
	 (*RLOC={"X0Y2"}*) (*BEL ={"A6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_8 (.O6(bar[8]),.O5(pos_w[8]),.I0(Y[8]),.I1(X[8]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y2"}*) (*BEL ={"B6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_9 (.O6(bar[9]),.O5(pos_w[9]),.I0(Y[9]),.I1(X[9]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y2"}*) (*BEL ={"C6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_10 (.O6(bar[10]),.O5(pos_w[10]),.I0(Y[10]),.I1(X[10]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y2"}*) (*BEL ={"D6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_11 (.O6(bar[11]),.O5(pos_w[11]),.I0(Y[11]),.I1(X[11]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 
	 (*RLOC={"X0Y3"}*) (*BEL ={"A6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_12 (.O6(bar[12]),.O5(pos_w[12]),.I0(Y[12]),.I1(X[12]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y3"}*) (*BEL ={"B6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_13 (.O6(bar[13]),.O5(pos_w[13]),.I0(Y[13]),.I1(X[13]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y3"}*) (*BEL ={"C6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_14 (.O6(bar[14]),.O5(pos_w[14]),.I0(Y[14]),.I1(X[14]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y3"}*) (*BEL ={"D6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_15 (.O6(bar[15]),.O5(pos_w[15]),.I0(Y[15]),.I1(X[15]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));

    (*RLOC={"X0Y4"}*) (*BEL ={"A6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_16 (.O6(bar[16]),.O5(pos_w[16]),.I0(Y[16]),.I1(X[16]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y4"}*) (*BEL ={"B6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_17 (.O6(bar[17]),.O5(pos_w[17]),.I0(Y[17]),.I1(X[17]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y4"}*) (*BEL ={"C6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_18 (.O6(bar[18]),.O5(pos_w[18]),.I0(Y[18]),.I1(X[18]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y4"}*) (*BEL ={"D6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_19 (.O6(bar[19]),.O5(pos_w[19]),.I0(Y[19]),.I1(X[19]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));

    (*RLOC={"X0Y5"}*) (*BEL ={"A6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_20 (.O6(bar[20]),.O5(pos_w[20]),.I0(Y[20]),.I1(X[20]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y5"}*) (*BEL ={"B6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_21 (.O6(bar[21]),.O5(pos_w[21]),.I0(Y[21]),.I1(X[21]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y5"}*) (*BEL ={"C6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_22 (.O6(bar[22]),.O5(pos_w[22]),.I0(Y[22]),.I1(X[22]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y5"}*) (*BEL ={"D6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_23 (.O6(bar[23]),.O5(pos_w[23]),.I0(Y[23]),.I1(X[23]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));

    (*RLOC={"X0Y6"}*) (*BEL ={"A6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_24 (.O6(bar[24]),.O5(pos_w[24]),.I0(Y[24]),.I1(X[24]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y6"}*) (*BEL ={"B6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_25 (.O6(bar[25]),.O5(pos_w[25]),.I0(Y[25]),.I1(X[25]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y6"}*) (*BEL ={"C6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_26 (.O6(bar[26]),.O5(pos_w[26]),.I0(Y[26]),.I1(X[26]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y6"}*) (*BEL ={"D6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_27 (.O6(bar[27]),.O5(pos_w[27]),.I0(Y[27]),.I1(X[27]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));

    (*RLOC={"X0Y7"}*) (*BEL ={"A6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_28 (.O6(bar[28]),.O5(pos_w[28]),.I0(Y[28]),.I1(X[28]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y7"}*) (*BEL ={"B6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_29 (.O6(bar[29]),.O5(pos_w[29]),.I0(Y[29]),.I1(X[29]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y7"}*) (*BEL ={"C6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_30 (.O6(bar[30]),.O5(pos_w[30]),.I0(Y[30]),.I1(X[30]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));
	 (*RLOC={"X0Y7"}*) (*BEL ={"D6LUT"}*) LUT6_2 #(.INIT(64'hC35AC35AAACCAACC)) two_comp_bit_31 (.O6(bar[31]),.O5(pos_w[31]),.I0(Y[31]),.I1(X[31]),.I2(Z[30]),.I3(Z[31]),.I4(1'b0),.I5(1'b1));

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	  
	 (*RLOC="X0Y7"*) CARRY4 two_comp_carry_7 (	.CO(carry_prop[31:28]),.O(neg_w[31:28]),.CI(carry_prop[27]),.CYINIT(),.DI(4'b0),.S(bar[31:28]));
	 (*RLOC="X0Y6"*) CARRY4 two_comp_carry_6 (	.CO(carry_prop[27:24]),.O(neg_w[27:24]),.CI(carry_prop[23]),.CYINIT(),.DI(4'b0),.S(bar[27:24]));
    (*RLOC="X0Y5"*) CARRY4 two_comp_carry_5 (	.CO(carry_prop[23:20]),.O(neg_w[23:20]),.CI(carry_prop[19]),.CYINIT(),.DI(4'b0),.S(bar[23:20]));
    (*RLOC="X0Y4"*) CARRY4 two_comp_carry_4 (	.CO(carry_prop[19:16]),.O(neg_w[19:16]),.CI(carry_prop[15]),.CYINIT(),.DI(4'b0),.S(bar[19:16]));
    (*RLOC="X0Y3"*) CARRY4 two_comp_carry_3 (	.CO(carry_prop[15:12]),.O(neg_w[15:12]),.CI(carry_prop[11]),.CYINIT(),.DI(4'b0),.S(bar[15:12]));
    (*RLOC="X0Y2"*) CARRY4 two_comp_carry_2 (	.CO(carry_prop[11:8]),.O(neg_w[11:8]),.CI(carry_prop[7]),.CYINIT(),.DI(4'b0),.S(bar[11:8]));
    (*RLOC="X0Y1"*) CARRY4 two_comp_carry_1 (	.CO(carry_prop[7:4]),.O(neg_w[7:4]),.CI(carry_prop[3]),.CYINIT(),.DI(4'b0),.S(bar[7:4]));
    (*RLOC="X0Y0"*) CARRY4 two_comp_carry_0 (	.CO(carry_prop[3:0]),.O(neg_w[3:0]),.CI(),.CYINIT(carry__in),.DI(pos_w[3:0]),.S(bar[3:0]));

        
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		  
		  
		  (*RLOC={"X0Y0" }*) (*BEL  =  {"A5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_0 (.Q(pos[0]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[0]));
		  (*RLOC={"X0Y0" }*) (*BEL  =  {"B5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_1 (.Q(pos[1]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[1]));
		  (*RLOC={"X0Y0" }*) (*BEL  =  {"C5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_2 (.Q(pos[2]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[2]));
		  (*RLOC={"X0Y0" }*) (*BEL  =  {"D5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_3 (.Q(pos[3]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[3]));
		  
		  (*RLOC={"X0Y1" }*) (*BEL  =  {"A5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_4 (.Q(pos[4]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[4]));
		  (*RLOC={"X0Y1" }*) (*BEL  =  {"B5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_5 (.Q(pos[5]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[5]));
		  (*RLOC={"X0Y1" }*) (*BEL  =  {"C5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_6 (.Q(pos[6]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[6]));
		  (*RLOC={"X0Y1" }*) (*BEL  =  {"D5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_7 (.Q(pos[7]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[7]));
		          
		  (*RLOC={"X0Y2" }*) (*BEL  =  {"A5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_8 (.Q(pos[8]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[8]));
		  (*RLOC={"X0Y2" }*) (*BEL  =  {"B5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_9 (.Q(pos[9]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[9]));
		  (*RLOC={"X0Y2" }*) (*BEL  =  {"C5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_10 (.Q(pos[10]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[10]));
		  (*RLOC={"X0Y2" }*) (*BEL  =  {"D5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_11 (.Q(pos[11]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[11]));

        (*RLOC={"X0Y3" }*) (*BEL  =  {"A5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_12 (.Q(pos[12]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[12]));
		  (*RLOC={"X0Y3" }*) (*BEL  =  {"B5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_13 (.Q(pos[13]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[13]));
		  (*RLOC={"X0Y3" }*) (*BEL  =  {"C5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_14 (.Q(pos[14]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[14]));
		  (*RLOC={"X0Y3" }*) (*BEL  =  {"D5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_15 (.Q(pos[15]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[15]));
        
		  (*RLOC={"X0Y4" }*) (*BEL  =  {"A5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_16 (.Q(pos[16]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[16]));
		  (*RLOC={"X0Y4" }*) (*BEL  =  {"B5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_17 (.Q(pos[17]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[17]));
		  (*RLOC={"X0Y4" }*) (*BEL  =  {"C5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_18 (.Q(pos[18]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[18]));
		  (*RLOC={"X0Y4" }*) (*BEL  =  {"D5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_19 (.Q(pos[19]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[19]));

        (*RLOC={"X0Y5" }*) (*BEL  =  {"A5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_20 (.Q(pos[20]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[20]));
		  (*RLOC={"X0Y5" }*) (*BEL  =  {"B5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_21 (.Q(pos[21]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[21]));
		  (*RLOC={"X0Y5" }*) (*BEL  =  {"C5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_22 (.Q(pos[22]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[22]));
		  (*RLOC={"X0Y5" }*) (*BEL  =  {"D5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_23 (.Q(pos[23]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[23]));
        
		  (*RLOC={"X0Y6" }*) (*BEL  =  {"A5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_24 (.Q(pos[24]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[24]));
		  (*RLOC={"X0Y6" }*) (*BEL  =  {"B5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_25 (.Q(pos[25]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[25]));
		  (*RLOC={"X0Y6" }*) (*BEL  =  {"C5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_26 (.Q(pos[26]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[26]));
		  (*RLOC={"X0Y6" }*) (*BEL  =  {"D5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_27 (.Q(pos[27]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[27]));

        (*RLOC={"X0Y7" }*) (*BEL  =  {"A5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_28 (.Q(pos[28]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[28]));
		  (*RLOC={"X0Y7" }*) (*BEL  =  {"B5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_29 (.Q(pos[29]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[29]));
        (*RLOC={"X0Y7" }*) (*BEL  =  {"C5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_30 (.Q(pos[30]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[30]));
		  (*RLOC={"X0Y7" }*) (*BEL  =  {"D5FF"}*) FDSE #(.INIT(1'b0)) out_reg_pos_31 (.Q(pos[31]),.C(C),.CE(CE),.S(1'b0),.D(pos_w[31]));

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		  
		  
		  (*RLOC={"X0Y0" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_0 (.Q(neg[0]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[0]));
		  (*RLOC={"X0Y0" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_1 (.Q(neg[1]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[1]));
		  (*RLOC={"X0Y0" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_2 (.Q(neg[2]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[2]));
		  (*RLOC={"X0Y0" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_3 (.Q(neg[3]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[3]));
		  
		  (*RLOC={"X0Y1" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_4 (.Q(neg[4]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[4]));
		  (*RLOC={"X0Y1" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_5 (.Q(neg[5]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[5]));
		  (*RLOC={"X0Y1" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_6 (.Q(neg[6]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[6]));
		  (*RLOC={"X0Y1" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_7 (.Q(neg[7]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[7]));
		          
		  (*RLOC={"X0Y2" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_8 (.Q(neg[8]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[8]));
		  (*RLOC={"X0Y2" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_9 (.Q(neg[9]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[9]));
		  (*RLOC={"X0Y2" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_10 (.Q(neg[10]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[10]));
		  (*RLOC={"X0Y2" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_11 (.Q(neg[11]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[11]));

        (*RLOC={"X0Y3" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_12 (.Q(neg[12]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[12]));
		  (*RLOC={"X0Y3" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_13 (.Q(neg[13]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[13]));
		  (*RLOC={"X0Y3" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_14 (.Q(neg[14]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[14]));
		  (*RLOC={"X0Y3" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_15 (.Q(neg[15]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[15]));
        
		  (*RLOC={"X0Y4" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_16 (.Q(neg[16]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[16]));
		  (*RLOC={"X0Y4" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_17 (.Q(neg[17]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[17]));
		  (*RLOC={"X0Y4" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_18 (.Q(neg[18]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[18]));
		  (*RLOC={"X0Y4" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_19 (.Q(neg[19]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[19]));

        (*RLOC={"X0Y5" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_20 (.Q(neg[20]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[20]));
		  (*RLOC={"X0Y5" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_21 (.Q(neg[21]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[21]));
		  (*RLOC={"X0Y5" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_22 (.Q(neg[22]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[22]));
		  (*RLOC={"X0Y5" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_23 (.Q(neg[23]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[23]));
        
		  (*RLOC={"X0Y6" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_24 (.Q(neg[24]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[24]));
		  (*RLOC={"X0Y6" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_25 (.Q(neg[25]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[25]));
		  (*RLOC={"X0Y6" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_26 (.Q(neg[26]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[26]));
		  (*RLOC={"X0Y6" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_27 (.Q(neg[27]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[27]));

        (*RLOC={"X0Y7" }*) (*BEL  =  {"AFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_28 (.Q(neg[28]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[28]));
		  (*RLOC={"X0Y7" }*) (*BEL  =  {"BFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_29 (.Q(neg[29]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[29]));
        (*RLOC={"X0Y7" }*) (*BEL  =  {"CFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_30 (.Q(neg[30]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[30]));
		  (*RLOC={"X0Y7" }*) (*BEL  =  {"DFF"}*) FDSE #(.INIT(1'b0)) out_reg_neg_31 (.Q(neg[31]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[31]));


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		  
		  
		  
		  /*(*RLOC={"X0Y0","X0Y0","X0Y0","X0Y0"  ,  "X0Y1","X0Y1","X0Y1","X0Y1"  ,  "X0Y2","X0Y2","X0Y2","X0Y2"  ,  "X0Y3","X0Y3","X0Y3","X0Y3"  ,  "X0Y4","X0Y4","X0Y4","X0Y4" , "X0Y5","X0Y5","X0Y5","X0Y5"  ,  "X0Y6","X0Y6","X0Y6","X0Y6"  ,  "X0Y7","X0Y7","X0Y7","X0Y7" }*) 
         (*BEL  =  {"AFF/LATCH","BFF/LATCH","CFF/LATCH","DFF/LATCH", "AFF/LATCH","BFF/LATCH","CFF/LATCH","DFF/LATCH", "AFF/LATCH","BFF/LATCH","CFF/LATCH","DFF/LATCH", "AFF/LATCH","BFF/LATCH","CFF/LATCH","DFF/LATCH"}*)
	     FDSE #(.INIT(1'b0)) out_reg_neg [31:0] (.Q(neg[31:0]),.C(C),.CE(CE),.S(1'b0),.D(neg_w[31:0]));
        */

assign Z_30_bit = Z[30];		  
assign _Z_ = {Z[31],Z[31],Z[29:0]}; 
endmodule

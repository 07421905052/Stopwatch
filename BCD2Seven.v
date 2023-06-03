/*
	BCD2Seven
	-----------------
	By Longzhen Yuan
	Date: 10th April 2023
	
	Module Description:
	-----------------------
	Accept a BCD number, convert it into the format which can be used to control each segment of a 7-segment display
	input:
		BCD: input a 4bits BCD number
	output:
		HEX: 7 bits, used to control the 7 segment respectively.
*/
module BCD2Seven(

	input [3:0] BCD,
	
	
	output [6:0] HEX
	
);

assign HEX[0] = !((~BCD[3])&(~BCD[2])&(~BCD[1])&(~BCD[0]) | (~BCD[3])&(~BCD[2])&(BCD[1])&(~BCD[0]) | (~BCD[3])&(~BCD[2])&(BCD[1])&(BCD[0]) | (~BCD[3])&(BCD[2])&(~BCD[1])&(BCD[0]) | (~BCD[3])&(BCD[2])&(BCD[1])&(~BCD[0]) | (~BCD[3])&(BCD[2])&(BCD[1])&(BCD[0]) | (BCD[3])&(~BCD[2])&(~BCD[1])&(~BCD[0]) | (BCD[3])&(~BCD[2])&(~BCD[1])&(BCD[0]));
assign HEX[1] = !((~BCD[3])&(~BCD[2])&(~BCD[1])&(~BCD[0]) | (~BCD[3])&(~BCD[2])&(~BCD[1])&(BCD[0]) | (~BCD[3])&(~BCD[2])&(BCD[1])&(~BCD[0]) | (~BCD[3])&(~BCD[2])&(BCD[1])&(BCD[0]) | (~BCD[3])&(BCD[2])&(~BCD[1])&(~BCD[0]) | (~BCD[3])&(BCD[2])&(BCD[1])&(BCD[0]) | (BCD[3])&(~BCD[2])&(~BCD[1])&(~BCD[0]) | (BCD[3])&(~BCD[2])&(~BCD[1])&(BCD[0]));
assign HEX[2] = !((~BCD[3])&(~BCD[2])&(~BCD[1])&(~BCD[0]) | (~BCD[3])&(~BCD[2])&(~BCD[1])&(BCD[0]) | (~BCD[3])&(~BCD[2])&(BCD[1])&(BCD[0]) | (~BCD[3])&(BCD[2])&(~BCD[1])&(~BCD[0]) | (~BCD[3])&(BCD[2])&(BCD[1])&(~BCD[0]) |(~BCD[3])&(BCD[2])&(BCD[1])&(BCD[0]) | (BCD[3])&(~BCD[2])&(~BCD[1])&(~BCD[0]) | (BCD[3])&(~BCD[2])&(~BCD[1])&(BCD[0]) | (~BCD[3])&(BCD[2])&(~BCD[1])&(BCD[0]) | (BCD[3])&(BCD[2])&(BCD[1])&(~BCD[0]));
assign HEX[3] = !((~BCD[3])&(~BCD[2])&(~BCD[1])&(~BCD[0]) | (~BCD[3])&(~BCD[2])&(BCD[1])&(~BCD[0]) | (~BCD[3])&(~BCD[2])&(BCD[1])&(BCD[0]) | (~BCD[3])&(BCD[2])&(~BCD[1])&(BCD[0]) | (~BCD[3])&(BCD[2])&(BCD[1])&(~BCD[0]) | (BCD[3])&(~BCD[2])&(~BCD[1])&(~BCD[0]) | (BCD[3])&(~BCD[2])&(~BCD[1])&(BCD[0]));
assign HEX[4] = !((~BCD[3])&(~BCD[2])&(~BCD[1])&(~BCD[0]) | (~BCD[3])&(~BCD[2])&(BCD[1])&(~BCD[0]) | (~BCD[3])&(BCD[2])&(BCD[1])&(~BCD[0]) | (BCD[3])&(~BCD[2])&(~BCD[1])&(~BCD[0]));
assign HEX[5] = !((~BCD[3])&(~BCD[2])&(~BCD[1])&(~BCD[0]) | (~BCD[3])&(BCD[2])&(~BCD[1])&(~BCD[0]) | (~BCD[3])&(BCD[2])&(~BCD[1])&(BCD[0]) | (~BCD[3])&(BCD[2])&(BCD[1])&(~BCD[0]) | (BCD[3])&(~BCD[2])&(~BCD[1])&(~BCD[0]) | (BCD[3])&(~BCD[2])&(~BCD[1])&(BCD[0]));
assign HEX[6] = !((~BCD[3])&(~BCD[2])&(BCD[1])&(~BCD[0]) | (~BCD[3])&(~BCD[2])&(BCD[1])&(BCD[0]) | (~BCD[3])&(BCD[2])&(~BCD[1])&(~BCD[0]) | (~BCD[3])&(BCD[2])&(~BCD[1])&(BCD[0]) | (~BCD[3])&(BCD[2])&(BCD[1])&(~BCD[0]) | (BCD[3])&(~BCD[2])&(~BCD[1])&(~BCD[0]) | (BCD[3])&(~BCD[2])&(~BCD[1])&(BCD[0]));



endmodule
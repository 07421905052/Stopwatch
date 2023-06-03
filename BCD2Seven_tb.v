`timescale 1 ns / 100 ps
module BCD2Seven_tb;

reg [3:0] BCD;
reg en_dot;

wire [7:0] HEX;

integer i;


initial
begin
   en_dot <= 1'b0;
	for(i = 0; i < 9; i = i+1)begin
		BCD = i;
		#10;
	end
	
	en_dot <= 1'b1;
	#100;
	en_dot <= 1'b0;
	$stop;
end

BCD2Seven dut(

	.BCD(BCD),
	.en_dot(en_dot),
	
	.HEX(HEX)
	
);

endmodule
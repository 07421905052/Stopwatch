`timescale 1 ns / 100 ps
module BreathLed_tb;

reg enable;
reg CLK_50MHz;
reg reset_n;

wire led;

BreathLed dut(
	.enable(enable),
	.CLK_50MHz(CLK_50MHz),
	.reset_n(reset_n),
	
	.led(led)
);



initial begin
	CLK_50MHz = 1'b0;
	reset_n <= 1'b0;
	enable <= 1'b1;
	#40
	reset_n <= 1'b1;
	
	#1000000
	
	enable <= 1'b0;
	
	#100000
	
	enable <= 1'b1;
	
	#1000000
	$stop;
	
end

always begin
	#10;
	CLK_50MHz <= ~CLK_50MHz;

end


endmodule
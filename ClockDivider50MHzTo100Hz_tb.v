`timescale 1 ns / 100 ps
module ClockDivider50MHzTo100Hz_tb;
//observe the counter: a complete period should be from 0 to 249999(Unsigned)
//observe the reset signal

reg CLK_50_MHz;
reg reset_n;

wire CLK_100Hz;

initial
begin
	CLK_50_MHz <= 1'b0;
	reset_n <= 1'b0; //acticate reset_n signal
	#20;
	reset_n <= 1'b1; //deactivate reset_n signal
	#12500050 // after a random period, activate the reset_n signal
	reset_n <= 1'b0;
	#100
	reset_n <= 1'b1;
	#12000000;
	$stop;
end

always begin
	#10;
	CLK_50_MHz <= ~CLK_50_MHz;

end

ClockDivider50MHzTo100Hz dut(
	.CLK_50_MHz(CLK_50_MHz),
	.reset_n(reset_n),
	.CLK_100Hz(CLK_100Hz)
);



endmodule
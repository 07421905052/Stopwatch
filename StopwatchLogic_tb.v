`timescale 1 ns / 100 ps
module StopwatchLogic_tb;

reg CLK_100Hz;
reg reset_n;
reg start_stop;
reg hold;
reg adjust;

wire [6:0] stopwatch_unit_mins;
wire [5:0] stopwatch_unit_secs;
wire [6:0] stopwatch_unit_decs;
wire stopwatch_overflow;

initial begin
	CLK_100Hz <= 1'b0;
	reset_n <= 1'b0; //reset is activated
	start_stop <= 1'b1; //button not pressed
	hold <= 1'b1; //button not pressed
	adjust <= 1'b0; //start_pause mode
	#20
	reset_n <= 1'b1; //reset is deactivated
	
	#20000
	
	start_stop <= 1'b0; //test start_stop -- start
	#400
	start_stop <= 1'b1;
	
	#20000
	
	hold <= 1'b0; //test hold
	#400
	hold <= 1'b1;
	
	#20000
	
	start_stop <= 1'b0; //test start_stop -- pause
	#400
	start_stop <= 1'b1;
	
	#1000
	
	reset_n <= 1'b0; //test reset: reset when the stopwatch is pausing
	#100
	reset_n <= 1'b1;
	
	#2000
	
	start_stop <= 1'b0; //test start_stop -- start
	#400
	start_stop <= 1'b1;
	
	reset_n <= 1'b0; //test reset: reset when the stopwatch is running
	#100
	reset_n <= 1'b1;
	
	#2000
	
	start_stop <= 1'b0; //test start_stop -- start
	#400
	start_stop <= 1'b1;
	
	#13000000 //test overflow
	
	reset_n <= 1'b0; //test if the stopwatch can be reset after overflow
	#100
	reset_n <= 1'b1;
	
	#1000
	
	start_stop <= 1'b0; //start to test adjustment mode, first, let the counter count up for a random period
	#400
	start_stop <= 1'b1;
	
	#4000000
	
	adjust <= 1'b1; //turn on the switch while the counter is running, the counter should stop to count up and wait for user adjustment
	
	#2000
	
	start_stop <= 1'b0; //press once
	#400
	start_stop <= 1'b1;
	
	#2000
	
	start_stop <= 1'b0; //keep pressng for 10s
	#20000
	start_stop <= 1'b1;
	
	#2000
	
	hold <= 1'b0; //press once
	#400
	hold <= 1'b1;
	
	#2000
	
	hold <= 1'b0; //keep pressing for 30s
	#60000
	hold <= 1'b1;
	
	#2000
	
	hold <= 1'b0; //keep pressing for 5s
	#10000
	hold <= 1'b1;
	
	#2000
	
	adjust <= 1'b0; //turn off the switch and go back to normal mode
	
	#2000
	
	start_stop <= 1'b0; //press once
	#400
	start_stop <= 1'b1;
	
	#2000
	
	$stop;
	
end


always begin
	#10;
	CLK_100Hz <= ~CLK_100Hz;

end

StopwatchLogic dut(
	.CLK_100Hz(CLK_100Hz),
	.reset_n(reset_n),
	.start_stop(start_stop),
	.hold(hold),
	.adjust(adjust),
	.stopwatch_unit_mins(stopwatch_unit_mins),
	.stopwatch_unit_secs(stopwatch_unit_secs),
	.stopwatch_unit_decs(stopwatch_unit_decs),
	.stopwatch_overflow(stopwatch_overflow)
);

endmodule
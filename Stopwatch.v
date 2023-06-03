/*
	Stopwatch
	-----------------
	By Longzhen Yuan
	Date: 10th April 2023
	
	Module Description:
	-----------------------
	The top-level file of stopwatch project, used to connect all the modules together.
	It also controlls the clk indicator.
	input:
		CLK_50MHz: input 50MHz signal
		reset_n :the reset switch
		start_stop: the start_stop button
		hold: the hold button
		adjust: connected to the switch which used to control the mode (start_stop mode and adjustment mode)
	output:
		ten_mins_seven_seg: the 7-segment display which represents 10 minutes.
		one_mins_seven_seg: the 7-segment display which represents 1 minutes.
		ten_secs_seven_seg: the 7-segment display which represents 10 seconds.
		one_sec_seven_seg: the 7-segment display which represents 1 seconds.
		tenths_seven_seg: the 7-segment display which represents 0.1 second.
		hundredths_seven_seg: the 7-segment display which represents 0.01 second.
		CLK_ind: the clock indicator, which blinks each 1s.
		overflow_flag: connected to LED, which will be illuminated if the time exceed 99:59:99
		led: a breath led which will be illuminated when under adjustment mode
*/
module Stopwatch(
	input CLK_50MHz,
	input reset_n,
	input start_stop,
	input hold,
	input adjust,
	output [7:0] ten_mins_seven_seg,
	output [7:0] one_min_seven_seg,
	output [7:0] ten_secs_seven_seg,
	output [7:0] one_sec_seven_seg,
	output [7:0] tenths_seven_seg,
	output [7:0] hundredths_seven_seg,
	output CLK_ind,
	output overflow_flag,
	output led
);

wire CLK_100Hz;
wire [6:0] stopwatch_unit_mins;
wire [5:0] stopwatch_unit_secs;
wire [6:0] stopwatch_unit_decs;
wire enable;



reg [6:0] cnt_1s;
reg [4:0] cnt_0_2s;

assign CLK_ind = (|cnt_0_2s); //only when the value stored in cnt_0_2s is 0, illuminate the indicator. 

ClockDivider50MHzTo100Hz inst1(
	.CLK_50_MHz(CLK_50MHz),
	.reset_n(reset_n),
	.CLK_100Hz(CLK_100Hz)
);

StopwatchLogic inst2(
	.CLK_100Hz(CLK_100Hz),
	.reset_n(reset_n),
	.start_stop(start_stop),
	.hold(hold),
	.adjust(adjust),
	.stopwatch_unit_mins(stopwatch_unit_mins),
	.stopwatch_unit_secs(stopwatch_unit_secs),
	.stopwatch_unit_decs(stopwatch_unit_decs),
	.stopwatch_overflow(overflow_flag),
	.enable(enable)
);

SevenSegEncoder inst3( //Use BCD code to display numbers on the 7-segment display. BCD to 7 segment
	.stopwatch_unit_mins(stopwatch_unit_mins), //0-99
	.stopwatch_unit_secs(stopwatch_unit_secs), //0-59
	.stopwatch_unit_decs(stopwatch_unit_decs), //0-99
	.hex_10_mins(ten_mins_seven_seg),
	.hex_1_min(one_min_seven_seg),
	.hex_10_secs(ten_secs_seven_seg),
	.hex_1_sec(one_sec_seven_seg),
	.hex_hundredths(hundredths_seven_seg), //0.01
	.hex_tenths(tenths_seven_seg) // 0.1
);

BreathLed inst4(
	.enable(enable),
	.CLK_50MHz(CLK_50MHz),
	.reset_n(reset_n),
	
	.led(led)
);

always@(posedge CLK_100Hz or negedge reset_n)begin //Used to control the clk indicator, for each 1s, it will be illuminated for 0.8s.
	if(!reset_n)begin
		cnt_1s <= 7'd0;
		cnt_0_2s <= 5'd0;
	end
	
	else if (cnt_1s == 7'd99)begin //assign a initial value to cnt_0_2s each 1s.
		cnt_1s <= 7'd0;
		cnt_0_2s <= 5'd19; 
	end
	
	else if (cnt_0_2s > 1'b0) begin //cnt_0_2s decrease by 1 for each 0.01s, 19...0 is 0.2s.
		cnt_1s <= cnt_1s + 1'd1;
		cnt_0_2s <= cnt_0_2s - 1'd1;
	end
	
	else begin
		cnt_1s <= cnt_1s + 1'd1;
		cnt_0_2s <= cnt_0_2s;
	end
	
	
end

endmodule

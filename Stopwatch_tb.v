`timescale 1 ns/ 100 ps
module Stopwatch_tb;

reg CLK_50MHz;
reg reset_n;
reg start_stop;
reg hold;
reg adjust;

wire [6:0] ten_mins_seven_seg;
wire [6:0] one_min_seven_seg;
wire [6:0] ten_secs_seven_seg;
wire [6:0] one_sec_seven_seg;
wire [6:0] tenths_seven_seg;
wire [6:0] hundredths_seven_seg;

wire CLK_ind;
wire overflow_flag;
wire led;

initial
begin
	CLK_50MHz <= 1'b0;
	reset_n <= 1'b0;
	start_stop <= 1'b1;
	hold <= 1'b1;
	adjust <= 1'b0;
	
	#2000
	
	reset_n <= 1'b1;
	
	#2000
	
	start_stop <= 1'b0;
	#1600 //0.2s
	start_stop <= 1'b1;
	
	#40000 //4s
	
	start_stop <= 1'b0;
	#1600 //0.2s
	start_stop <= 1'b1;
	
	#20000
	
	adjust <= 1'b1;
	
	#10000
	
	start_stop <= 1'b0;
	#1600 //0.2s
	start_stop <= 1'b1;
	
	#10000
	
	start_stop <= 1'b0;
	#100000 //10s
	start_stop <= 1'b1;
	
	#10000
	
	hold <= 1'b0;
	#1600
	hold <= 1'b1;
	
	#10000
	
	hold <= 1'b0;
	#100000
	hold <= 1'b1;
	
	#10000
	
	$stop;
	
end

always begin
	#10
	CLK_50MHz = !CLK_50MHz;
end

Stopwatch dut(
	.CLK_50MHz(CLK_50MHz),
	.reset_n(reset_n),
	.start_stop(start_stop),
	.hold(hold),
	.adjust(adjust),
	
	.ten_mins_seven_seg(ten_mins_seven_seg),
	.one_min_seven_seg(one_min_seven_seg),
	.ten_secs_seven_seg(ten_secs_seven_seg),
	.one_sec_seven_seg(one_sec_seven_seg),
	.tenths_seven_seg(tenths_seven_seg),
	.hundredths_seven_seg(hundredths_seven_seg),
	
	.CLK_ind(CLK_ind),
	.overflow_flag(overflow_flag),
	.led(led)
);

endmodule
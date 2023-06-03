`timescale 1 ns/ 100 ps
module SevenSegEncoder_tb;

reg [6:0] stopwatch_unit_mins;
reg [5:0] stopwatch_unit_secs;
reg [6:0] stopwatch_unit_decs;


wire [7:0] hex_10_mins;
wire [7:0] hex_1_min;
wire [7:0] hex_10_secs;
wire [7:0] hex_1_sec;
wire [7:0] hex_hundredths;
wire [7:0] hex_tenths;

integer i;

initial
begin
	for (i = 0; i< 99; i = i+1'd1)begin
		stopwatch_unit_mins <= i;
		stopwatch_unit_secs <= 6'd0;
		stopwatch_unit_decs <= 7'd0;
		#10;
	end
	for (i = 0; i< 59; i = i+1'd1)begin
		stopwatch_unit_secs <= i;
		stopwatch_unit_mins <= 7'd0;
		stopwatch_unit_decs <= 7'd0;
		#10;
	end
	for (i = 0; i< 99; i = i+1'd1)begin
		stopwatch_unit_decs <= i;
		stopwatch_unit_secs <= 6'd0;
		stopwatch_unit_mins <= 7'd0;
		#10;
	end
	$stop;
end



SevenSegEncoder dut(
	.stopwatch_unit_mins(stopwatch_unit_mins), //0-99
	.stopwatch_unit_secs(stopwatch_unit_secs), //0-59
	.stopwatch_unit_decs(stopwatch_unit_decs), //0-99
	.hex_10_mins(hex_10_mins),
	.hex_1_min(hex_1_min),
	.hex_10_secs(hex_10_secs),
	.hex_1_sec(hex_1_sec),
	.hex_hundredths(hex_hundredths), //0.01
	.hex_tenths(hex_tenths) // 0.1
);

endmodule
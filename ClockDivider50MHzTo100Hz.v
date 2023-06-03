/*
	ClockDivider50MHzTo100Hz
	-----------------
	By Longzhen Yuan
	Date: 10th April 2023
	
	Module Description:
	-----------------------
	Used to convert the 50MHz input signal to a 100Hz signal
	parameter MAX = 18'd249999
	input:
		CLK_50_MHz: the 50MHz input signal
		reset_n: the reset switch
	output:
		CLK_100Hz: output a 100Hz clock signal which can be used in othe modules.
*/
module ClockDivider50MHzTo100Hz (
	input CLK_50_MHz,
	input reset_n,
	output reg CLK_100Hz
);

reg [17:0] cnt;

//parameter MAX = 18'd2; //use this number when doing the simulation
parameter MAX = 18'd249999;

always@(posedge CLK_50_MHz or negedge reset_n)begin

	if(!reset_n)begin
		cnt <= 18'b0;
		CLK_100Hz <= 1'b0;
	end
	
	else if(cnt == MAX)begin //if the counter counts to maximum value, flip over the 100Hz signal
		cnt <= 18'b0;
		CLK_100Hz = ~CLK_100Hz;
	end
	
	else begin
		cnt = cnt + 1'b1;
	end
	
end

endmodule

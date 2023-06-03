/*
	BreathLed
	-----------------
	By Longzhen Yuan
	Date: 10th April 2023
	
	Module Description:
	-----------------------
	Control the behavior of the breath led. When the enable signal is at high level, illuminated.
	input:
		enable: generated from the StopwtchLogic module
		CLK_50MHz: input 50MHz clock signal
		reset_n: reset signal.
		
	output:
		led: connected to the led.
		
	parameter CNT_1US_MAX = 6'd49;    
	parameter CNT_1MS_MAX = 10'd999;  
	parameter CNT_1S_MAX  = 10'd999;
*/
module BreathLed(
	input enable,
	input CLK_50MHz,
	input reset_n,
	
	output reg led
);


parameter CNT_1US_MAX = 6'd49;    //0.02*10^-6 * 50 = 1us change this value to 9 when run the simulation
parameter CNT_1MS_MAX = 10'd999;  //change this value to 9 when run the simulation
parameter CNT_1S_MAX  = 10'd999; //change this value to 9 when run the simulation




reg [5:0] cnt_1us;
reg [9:0] cnt_1ms;
reg [9:0] cnt_1s;
reg state;


always@(posedge CLK_50MHz or negedge reset_n)begin
    if(reset_n == 1'b0)begin
        cnt_1us <= 6'b0;
	 end
    else if(cnt_1us == CNT_1US_MAX)begin //if the counter counts to the maximum value, set it to be 0.
        cnt_1us <= 6'b0;
	 end
    else begin
        cnt_1us <= cnt_1us + 1'b1;
	 end
end


always@(posedge CLK_50MHz or negedge reset_n)begin
    if(reset_n == 1'b0)begin
        cnt_1ms <= 10'b0;
	 end
    else if(cnt_1ms == CNT_1MS_MAX && cnt_1us == CNT_1US_MAX)begin //when both ms and us counter reach a maximum, 1ms has passed.
        cnt_1ms <= 10'b0;
	 end
    else if(cnt_1us == CNT_1US_MAX)begin //every 1us
        cnt_1ms <= cnt_1ms + 1'b1;
	 end
end


always@(posedge CLK_50MHz or negedge reset_n)begin
    if(reset_n == 1'b0)begin
        cnt_1s <= 10'b0;
	 end
    else if(cnt_1s == CNT_1S_MAX && cnt_1ms == CNT_1MS_MAX && cnt_1us == CNT_1US_MAX)begin //when all three counters reach a maximum, 1s has passed
        cnt_1s <= 10'b0;
	 end
    else if(cnt_1ms == CNT_1MS_MAX && cnt_1us == CNT_1US_MAX)begin
        cnt_1s <= cnt_1s + 1'b1;
	 end
end


always@(posedge CLK_50MHz or negedge reset_n)begin
    if(reset_n == 1'b0)
        state <= 1'b1;
    else    if(cnt_1s == CNT_1S_MAX && cnt_1ms == CNT_1MS_MAX && cnt_1us == CNT_1US_MAX) //change the state each 1s (brighter or dimmer)
        state <= ~state;
end

always@(posedge CLK_50MHz or negedge reset_n)begin
    if(reset_n == 1'b0)begin
        led <= 1'b0;
	 end
    else if( ((state == 1'b1 && cnt_1ms < cnt_1s) || (state == 1'b0 && cnt_1ms > cnt_1s)) && (enable == 1'b1) )begin
        led <= 1'b1; //the logic used to judge whether the led should be illuminated or turned off. The principle is demonstrated in the appendix of the report.
	 end
    else begin
        led <= 1'b0;
	 end
end

endmodule
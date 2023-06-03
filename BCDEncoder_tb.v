`timescale 1 ns / 100 ps
module BCDEncoder_tb;

reg [7:0] BinaryIn;
wire [3:0] number2;
wire [3:0] number1;
wire [3:0] number0;

integer i;

initial begin
	for(i = 0; i < 255; i = i+1)begin
		BinaryIn = i;
		#10;
	end
	$stop;
end

BCDEncoder dut( //将一个8位数转换成12位BCD
    .BinaryIn(BinaryIn), //8位输入 0-255
    .BCDOut({number2,number1,number0}) //每4位分别表示百位，十位，个位，即[11:8],[7:4],[3:0]
);
	 
	 
endmodule
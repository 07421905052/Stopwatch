/*
	BCDEncoder
	-----------------
	By Doctor Z. Zhang
	
	Module Description:
	-------------------------
	Used to convert number to BCD code.
*/
 module BCDEncoder( //将一个8位数转换成12位BCD
    input [7:0] BinaryIn, //8位输入 0-255
    output reg [11:0] BCDOut //每4位分别表示百位，十位，个位，即[11:8],[7:4],[3:0]
    );

    
reg [3:0] i;   
     

always @(BinaryIn)
  begin
		BCDOut = 0; 
		for (i = 4'd0; i < 4'd8; i = i+4'd1) begin
		 BCDOut = {BCDOut[10:0],BinaryIn[7-i]}; 
			  
		 if(i < 7 && BCDOut[3:0] > 4) 
			  BCDOut[3:0] = BCDOut[3:0] + 4'd3;
		 if(i < 7 && BCDOut[7:4] > 4)
			  BCDOut[7:4] = BCDOut[7:4] + 4'd3;
		 if(i < 7 && BCDOut[11:8] > 4)
			  BCDOut[11:8] = BCDOut[11:8] + 4'd3;  
		end
end     
				 
endmodule

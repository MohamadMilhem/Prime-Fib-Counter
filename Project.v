module TFF(Q, T, clk, rst);
	
	input clk, T, rst;
	output reg Q;
	
	always @ (posedge clk, negedge rst)
	begin
		if (rst == 0)
			Q = 1'b0;
		else 
			Q = Q ^ T;
			
	end
endmodule  


module MUX2x1(A, B, S, Y);
	input [5:0] A,B;
	input S;
	output reg [5:0] Y;
	
	always @ (A, B, S)
	begin
		if (S == 0)
			Y = A;
		else 
			Y = B;	
	end
endmodule



module Mod11UpDownCounter(clk, M, rst, count);
	input clk, M, rst;
	output wire [3:0] count;
  	wire [2:0] up, down;  
	wire [2:0] Tin;	

	
	TFF T0(count[0], 1, clk, rst & (~(count[0] & count[1] & ~count[2] & count[3])) & (~(count[0] & count[1] & count[2] & count[3]))); 
	and up0(up[0], ~M, count[0]);
	and down0(down[0], M, ~count[0]); 
	or Tin0(Tin[0], up[0], down[0]);
	TFF T1(count[1], Tin[0], clk, rst&(~(count[0] & count[1] & ~count[2] & count[3])));
	and up1(up[1], up[0], count[1]);
	and down1(down[1], down[0], ~count[1]);	
	or Tin1(Tin[1], up[1], down[1]);
	TFF T2(count[2], Tin[1], clk, rst&(~(count[0] & count[1] & ~count[2] & count[3])) & (~(count[0] & count[1] & count[2] & count[3]))); 
	and up2(up[2], up[1], count[2]);
	and down2(down[2], down[1], ~count[2]);
	or Tin2(Tin[2], up[2], down[2]);
	TFF T3(count[3], Tin[2], clk, rst&(~(count[0] & count[1] & ~count[2] & count[3])));

	
endmodule	  


																													

module fib(index, value);
	input [3:0] index;
	output [5:0] value;
	
	assign value[0] = index[3]&(~index[0]) | index[2]&(~index[1]) | index[2]&index[0] | (~index[2] & index[1] & ~index[0]) | (~index[3] & ~index[1] & index[0]); 
	assign value[1] = index[3]&index[1] | index[3]&index[0] | (~index[2] & index[1] & index[0]) | (index[2] & ~index[1] & ~index[0]); 
	assign value[2] = index[3]&(~index[0]) | index[2]&index[0];
	assign value[3] = index[2]&index[1];
	assign value[4] = index[3]&(~index[0]);
	assign value[5] = index[3]&index[1] | index[3]&index[0];
	
endmodule



module prime(index, value);
	input [3:0] index;
	output [5:0] value;
	
	
	assign value[0] = index[3] | index[2] | index[1] | index[0];
	assign value[1] = index[1]&index[0] | (~index[1])&(~index[0]) | index[3]&index[1] | (~index[3])&(~index[2])&index[0];
	assign value[2] = index[3] | (~index[2])&index[1] | index[2]&(~index[1])&index[0];
	assign value[3] = index[3]&index[0] | index[3]&index[1] | index[2]&(~index[1]);
	assign value[4] = index[3] | index[2]&index[1];
	assign value[5] = 0;

endmodule





module circuit(en, fibPri ,UD, clk, rst, OUT);
	
	input en, fibPri , UD, clk, rst;
	output [5:0] OUT;
	wire [3:0] index;
	wire [5:0] Fib, Pri;
	
	
	Mod11UpDownCounter counter(en&clk, UD, rst, index);
	fib f(index, Fib);
	prime p(index, Pri);
	
	MUX2x1 M(Fib, Pri, fibPri, OUT);
	
	

endmodule
	


module circuit_tb;
	
	reg en, fibPri, UD, clk, rst;
	reg [5:0] Fibonacci[0:11], Prime[0:11];
	wire [5:0] Y;
	integer index;
	
	circuit C(en , fibPri, UD, clk, rst, Y);
	
	initial begin
		$display("CLK M RST   Y");	  
		$monitor(" %b  %b  %b   %d ", clk, UD, rst, Y);		  
		
		index = 0;
		
		// Hardcode the Fibonacci terms
		Fibonacci[0] = 0	 ; Fibonacci[6] = 8;
		Fibonacci[1] = 1	 ; Fibonacci[7] = 13;
		Fibonacci[2] = 1	 ; Fibonacci[8] = 21;
		Fibonacci[3] = 2	 ; Fibonacci[9] = 34;
		Fibonacci[4] = 3	 ; Fibonacci[10] = 55;
		Fibonacci[5] = 5	 ;	   
		
		// Hardcode the Prime terms
		Prime[0] = 2	 ; Prime[6] = 17;
		Prime[1] = 3	 ; Prime[7] = 19;
		Prime[2] = 5	 ; Prime[8] = 23;
		Prime[3] = 7	 ; Prime[9] = 29;
		Prime[4] = 11	 ; Prime[10] = 31;
		Prime[5] = 13	 ;	 
		
		clk = 0; UD = 0; rst = 1; fibPri = 1; en = 1;
		#10 rst = 0;
		#10 rst = 1;   
		
		#500 UD = 1;
		#500 UD = 0;
		#500 rst = 0;  
		
		#100 fibPri = 0;
		rst = 1;
		
		#500 UD = 1;
		#500 UD = 0;
		#500 rst = 0;
		
		#100 
		$display("All Tests Passed!!");
		$finish;				   
		
	end
	
	always	#10 clk = ~clk;
		
	always @ (posedge clk, negedge rst)begin
		if (rst == 0)
			index = 0;
		else begin
			if (UD == 0)
				index = index + 1;
			else 
				index = index - 1;
				index = (index+11) % 11;// add 11 to set the index to 10 again when it value = -1.
		end	
	end
	
		
	always @ (posedge clk)
		begin
		  	#5	  // to make sure that the changes were applied.
			if (fibPri == 0 && Fibonacci[index] != Y)begin
				$display("Error expected: %d Found: %d", Fibonacci[index], Y);
				$finish	;
			end
			
			else if (fibPri == 1 && Prime[index] != Y)begin
			   $display("Error expected: %d Found: %d", Prime[index], Y);
			   $finish	;
			end
		end
		
endmodule

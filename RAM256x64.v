module RAM256x64(address, clock, in, write, out);
			input [7:0] address;
			input clock;
			input [63:0] in;
			input write;
			output reg [63:0] out;
			
			reg [63:0] mem [0:225];
			
			not U1(clk, clock);
			
			always @(posedge clk) begin
			
					if(write) begin
								mem[address] <= in;
					end
			end
			
			always @(posedge clk)begin
						out<= mem[address];
			end
endmodule
			
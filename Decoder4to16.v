module Decoder4to16(A , m);
			input [3:0]A;
			output [15:0]m;
			
			assign m[0]= ~A &~A &~A
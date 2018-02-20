module Shifter(A, shift_out, left, right);

		input[63:0]A;
		input[5:0]shift_out;
		output[63:0] left, right;
		
		assign left = A << shift_out;
		assign right = A >> shift_out;

endmodule 
module ALU_LEGv8(A, B, FS, C0, F, status);
	input [63:0] A, B;
	input [4:0]FS;
	// FS0 - Invert A
	// FS1 - Invert B
	// FS4:2 - output mux select
	//  000 - AND
	//  001 - OR
	//  010 - ADD
	//  011 - XOR
	//  100 - Shift Left (note: FS0/1 do nothing for shift ops)
	//  101 - Shift Right
	input C0;
	output [63:0]F;
	output [3:0]status;
	
	// A/Anot B/Bnot muxes
	wire [63:0] A_Signal, B_Signal;
	// A Mux
	assign A_Signal = FS[1] ? ~A : A;
	// B Mux
	assign B_Signal = FS[0] ? ~B : B;
	
	// status bits
	wire Z, N, C, V;
	assign status = {V, C, N, Z};
	assign N = F[63];
	assign Z = (F == 64'b0) ? 1'b1 : 1'b0;
	assign V = ~(A_Signal[63] ^ B_Signal[63]) &  (F[63] ^ A_Signal[63]);
	
	// logic unit
	wire [63:0]and_output, or_output, xor_output, add_output, shift_left, shift_right;
	assign and_output = A_Signal & B_Signal;
	assign or_output = A_Signal | B_Signal;
	assign xor_output = A_Signal ^ B_Signal;
	// arithmetic unit
	Adder adder_inst (A_Signal, B_Signal, C0, add_output, C);
	// shifter
	Shifter shift_inst (A, B[5:0], shift_left, shift_right);
	// mux to combine everything
	Mux8to1Nbit main_mux (F, FS[4:2], and_output, or_output, add_output, xor_output, shift_left, shift_right, 64'b0, 64'b0);
endmodule


module DatapathTestbench();
		reg [24:0] ControlWord;
		reg [63:0] constant;
		reg clock, reset;
		wire [3:0] status;
		
		wire [63:0] R00, R01, R02, R03, R04, R05, R06, R07, R08, R09,
					R10, R11, R12, R13, R14, R15, R16, R17, R18, R19,
					R20, R21, R22, R23, R24, R25, R26, R27, R28, R29,
					R30, R31;
					
	assign R00 = dut.regfile.R00;
	assign R01 = dut.regfile.R01;
	assign R02 = dut.regfile.R02;
	assign R03 = dut.regfile.R03;
	assign R04 = dut.regfile.R04;
	assign R05 = dut.regfile.R05;
	assign R06 = dut.regfile.R06;
	assign R07 = dut.regfile.R07;
	assign R08 = dut.regfile.R08;
	assign R09 = dut.regfile.R09;
	assign R10 = dut.regfile.R10;
	assign R11 = dut.regfile.R11;
	assign R12 = dut.regfile.R12;
	assign R13 = dut.regfile.R13;
	assign R14 = dut.regfile.R14;
	assign R15 = dut.regfile.R15;
	assign R16 = dut.regfile.R16;
	assign R17 = dut.regfile.R17;
	assign R18 = dut.regfile.R18;
	assign R19 = dut.regfile.R19;
	assign R20 = dut.regfile.R20;
	assign R21 = dut.regfile.R21;
	assign R22 = dut.regfile.R22;
	assign R23 = dut.regfile.R23;
	assign R24 = dut.regfile.R24;
	assign R25 = dut.regfile.R25;
	assign R26 = dut.regfile.R26;
	assign R27 = dut.regfile.R27;
	assign R28 = dut.regfile.R28;
	assign R29 = dut.regfile.R29;
	assign R30 = dut.regfile.R30;
	assign R31 = dut.regfile.R31;
		
		DatapathLEGv8 dut(ControlWord, status, constant, data, clock, reset);
		
	initial begin 
		clock <= 1'b0;
		reset <= 1'b1;
		constant <= 64'd3;
		ControlWord <= 25'b1111100000001001001000001;
	
	/*clock <= 1'b0;
	reset <= 1'b1;
	ControlWord <= 25'b1111100000001011001000001;
		<= 64'd4;
	data <= {$random, $random};*/
	
	#100 $stop;
	end
	
	always begin
		#5 clock <= ~clock;
	end
	
	always begin
		#10 reset <= 1'b0;
		constant <= 64'd4;
		ControlWord <= 25'b1111100000001011001000001;
		#10 constant <= 64'd3;
		ControlWord <= 25'b1111100000001011001000001;
		
	end
endmodule 
module DatapathLEGv8(ControlWord, status, constant, data, clock, reset);
			input [24:0] ControlWord;
			input [63:0] constant;
			inout [63:0] data;
			input clock, reset;
			output [3:0] status;
			//RegFile32x64(A, B, D, DA, SA, SB, W, reset, clock);
			wire [4:0] SA, SB, DA;
			wire RegWrite, MemWrite;
			wire [63:0] RegAbus, RegBbus, Muxout;
			wire [4:0] FS;
			wire Bsel;
			wire C0;
			wire [63:0] ALU_output, MEM_output;
			wire EN_Mem, EN_ALU;
			
			assign {SA, SB, DA, RegWrite, FS, Bsel, EN_Mem, EN_ALU} = ControlWord;
			
			assign Muxout = Bsel ? constant : RegBbus;
			
			RegFile32x64 regfile(RegAbus, RegBbus, data, DA, SA, SB, RegWrite, reset, clock);
			
			ALU_LEGv8 alu (RegAbus, Muxout, FS, FS[0], ALU_output, status);
			
			RAM256x64 data_mem (ALU_output, clock, RegBbus, MemWrite, MEM_output);
						
			assign data = EN_Mem ? MEM_output : 64'bz;
			assign data = EN_ALU ? ALU_output : 64'bz;
			
endmodule 
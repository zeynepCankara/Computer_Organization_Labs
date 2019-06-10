////////////////////////////////////////////////////////
//  
//  display_controller.sv
//
//  by Will Sawyer  31 March 2017
//
//  puts 4 hexadecimal values (from O to F) on the 4-digit 7-segment display unit
//     
//
//  the AN, Cx and DP outputs are active-low, for the BASYS3 board
//    AN3 is the left-most digit, AN2 is the second-left-most, etc
//    C[6] is CA for the a segment, c[5] is CB for the b segment, etc
//   
//  Uses the 100 MHz board clock for clk, and uses a clear signal for resetting
//  Takes 4 active-high enable signals, 1 per digit, to enable 
//     or disable display digits
//
//  For correct connections, carefully plan what should be in the .XDC file
//   
//  
////////////////////////////////////////////////////////

module display_controller (
		input logic clk, clear,
		input logic [3:0] enables, 
		input logic [3:0] digit3, digit2, digit1, digit0,
		output logic [3:0] AN,
		output logic [6:0] C,
		output logic       DP
		);

		logic [3:0] current_digit, cur_dig_AN;
		logic [6:0] segments;
		
      assign AN = ~(enables & cur_dig_AN);// AN signals are active low on the BASYS3 board,
                                // and must be enabled in order to display the digit
      assign C = ~segments;     // segments must be inverted, since the C values are active low
      assign DP = 1;            // makes the dot point always off 
                                // (0 = on, since it is active low)

// the 19-bit counter, runs at 100 MHz, so bit17 changes each 131072 clock cycles, 
//   or about once each 1.3 millisecond. Turning on and off the digits at this rate will
//   fool the human eye and make them appear to be on continuously
	   localparam N=19;
	   logic [N-1:0] count;
	always_ff @(posedge clk, posedge clear)
		if(clear) count <= 0;
		else count <= count + 1;	

// the upper 2 bits of count will cycle through the digits and the AN patterns
//  from left to right across the display unit			
	always_comb
	   case (count[N-1:N-2])
                // left most, AN3  
		2'b00: begin current_digit = digit3; cur_dig_AN = 4'b1000; end  
		2'b01: begin current_digit = digit2; cur_dig_AN = 4'b0100; end
		2'b10: begin current_digit = digit1; cur_dig_AN = 4'b0010; end
		2'b11: begin current_digit = digit0; cur_dig_AN = 4'b0001; end
                // right most, AN0
		default: begin current_digit = 4'bxxxx; cur_dig_AN = 4'bxxxx; end
	   endcase

// the hex-to-7-segment decoder
	always_comb
		case (current_digit)
		4'b0000: segments = 7'b111_1110;  // 0
		4'b0001: segments = 7'b011_0000;  // 1
		4'b0010: segments = 7'b110_1101;  // 2
		4'b0011: segments = 7'b111_1001;  // 3
		4'b0100: segments = 7'b011_0011;  // 4
		4'b0101: segments = 7'b101_1011;  // 5
		4'b0110: segments = 7'b101_1111;  // 6
		4'b0111: segments = 7'b111_0000;  // 7
		4'b1000: segments = 7'b111_1111;  // 8
		4'b1001: segments = 7'b111_0011;  // 9
		4'b1010: segments = 7'b111_0111;  // A
		4'b1011: segments = 7'b001_1111;  // b
		4'b1100: segments = 7'b000_1101;  // c
		4'b1101: segments = 7'b011_1101;  // d
		4'b1110: segments = 7'b100_1111;  // E
		4'b1111: segments = 7'b100_0111;  // F
		default: segments = 7'bxxx_xxxx;
		endcase		
endmodule

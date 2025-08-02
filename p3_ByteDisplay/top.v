/*



*/

module top (
	input clk,
	output d0,
	output d1,
	output d2,
	output d3,
	output d4,
	output d5,
	output d6,
	output d7, //mittelstrich
	output d8
	);
	
	
	reg [31:0] r_counter = 0;
	reg [31:0] r_counter_2 = 0;
	reg r_pos_freq = 0;
	reg r_counter_freq = 0;
	reg [1:0] r_charpos = 2; 			//char/display position 12, 2 or 0
	reg [7:0] r_display_byte=0;
	reg [7:0] r_dp = 0;
	reg [7:0] r_display_1=0;
	reg [7:0] r_display_2=0;
	
	always @(posedge clk) begin
		r_counter = r_counter + 1;
		if(r_counter == 1200) begin
			r_counter <= 0;
			r_pos_freq <= ~r_pos_freq;
		end
	end
	
	always @(posedge clk) begin
		r_counter_2 = r_counter_2 + 1;
		if(r_counter_2 == 1200000) begin
			r_counter_2 <= 0;
			r_counter_freq <= ~r_counter_freq;
		end
	end
	
	always @(posedge r_counter_freq) begin
			r_display_1 <= r_display_1 + 1;
			if(r_display_1 == 15) begin
				r_display_1 <= 0;
				r_display_2 <= r_display_2 + 1;
			end
			if(r_display_2 == 16) begin
				r_display_2 <= 0;
			end
			
	end
	
	
	always @(posedge clk) begin
	      if(r_pos_freq == 0) begin
				r_charpos = 1;
				r_display_byte <= r_display_1;
			end
			if(r_pos_freq == 1) begin
			   r_charpos = 2;
				r_display_byte <= r_display_2;
			end
		case(r_charpos)
			0: r_charpos <= 2'b00;
			1: r_charpos <= 2'b01;
			2: r_charpos <= 2'b10;
		endcase
		
		case(r_display_byte)
			0: r_dp <= 8'b11101011;
			1: r_dp <= 8'b10000010;
			2: r_dp <= 8'b10111001;
			3: r_dp <= 8'b10111010;
			4: r_dp <= 8'b11010010;
			5: r_dp <= 8'b01111010;
			6: r_dp <= 8'b01111011;
			7: r_dp <= 8'b10100010;
			8: r_dp <= 8'b11111011;
			9: r_dp <= 8'b11110010;
			10: r_dp <=8'b11110011;		//A
			11: r_dp <=8'b01011011;		//B
			12: r_dp <=8'b01101001;		//C
			13: r_dp <=8'b10011011;		//D
			14: r_dp <=8'b01111001;		//E
			15: r_dp <=8'b01110001;		//F
		endcase
	end
	
	assign d0 = r_charpos[0];
	assign d1 = r_dp[0];
	assign d2 = r_dp[1];
	assign d3 = r_charpos[1];
	assign d4 = r_dp[3];
	assign d5 = r_dp[4];
	assign d6 = r_dp[5];
	assign d7 = r_dp[6];
	assign d8 = r_dp[7]; 
	
	/*
	assign d1 = 1;
	assign d2 = 1;
	assign d3 = 1;
	assign d4 = 1;
	assign d5 = 1;
	assign d6 = 1;
	assign d7 = 1;
	assign d8 = 1;
	*/

endmodule

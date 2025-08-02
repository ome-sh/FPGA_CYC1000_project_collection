module top(
	input i_clock,
	output o_red,
	output o_green,
	output o_blue
	);
	
	reg [1:0] r_led_select = 0;						//0 = red; 1 = green; 2 = blue
	reg [7:0] r_pwm	= 8'b0;

	reg [7:0] r_red = 0;
	reg [7:0] r_green = 0;
	reg [7:0] r_blue = 255;
	
	reg r_clock_freq;
	reg [31:0]r_freq_c = 0;
	
	reg pwm_red, pwm_green, pwm_blue;
	
	
	always @(posedge r_clock_freq) begin
		case(r_led_select)
			0: begin			//red
				r_blue <= r_blue - 1;
				r_red <= r_red + 1; 
				if(r_red == 254)
					r_led_select <= 1;
			end
			
			1: begin			//green
				r_red <= r_red - 1;
				r_green <= r_green + 1;
				if(r_green == 254)
					r_led_select <= 2;
			end
			
			2: begin			//blue
				r_green <= r_green - 1;
				r_blue <= r_blue + 1;
				if(r_blue == 254)
					r_led_select <= 0;
			end
		endcase
	end
	
	
	//generate frequency
	always @(posedge i_clock) begin
		r_freq_c <= r_freq_c + 1;
		if(r_freq_c == 120000) begin
			r_freq_c <= 0;
			r_clock_freq <= ~r_clock_freq;
		end
	end
	
	
	//generate pwm
	always @(posedge i_clock)  begin
		r_pwm <= r_pwm + 1;
		if (r_red > r_pwm)
			pwm_red <= 1;
		else
			pwm_red <= 0;
	
		if (r_green > r_pwm)
			pwm_green <= 1;
		else
			pwm_green <= 0;

		if (r_blue > r_pwm)
			pwm_blue <= 1;
		else
			pwm_blue <= 0;
	end 
	
	
	assign o_red = pwm_red;
	assign o_green = pwm_green;
	assign o_blue = pwm_blue;

endmodule


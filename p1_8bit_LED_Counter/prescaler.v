module prescaler(
	input clk_200mhz,
	input button,
	output led1,
	output led2,
	output led3,
	output led4,
	output led5,
	output led6,
	output led7,
	output led8,
	output clk_output_25mhz
	);
	
	reg [31:0] r_counter;
	reg [7:0] r_led;
	reg r_freq;
	reg r_clk_output_25mhz;
	reg [7:0] r_clk_output_25mhz_c;
	
	always @(posedge clk_200mhz) begin
		r_counter <= r_counter + 1;
		if(r_counter == 10000000) begin
			r_counter <=0;
			r_freq = ~ r_freq;
			r_led = r_led + 1;
		end
	end
	
	always  @(posedge clk_200mhz) begin
		r_clk_output_25mhz_c <= r_clk_output_25mhz_c + 1;
		if (r_clk_output_25mhz_c == 8) begin
			r_clk_output_25mhz_c <= 0;
			r_clk_output_25mhz <= ~r_clk_output_25mhz;
		end
	end
	
	assign led1 = r_led[0];
	assign led2 = r_led[1];
	assign led3 = r_led[2];
	assign led4 = r_led[3];
	assign led5 = r_led[4];
	assign led6 = r_led[5];
	assign led7 = r_led[6];
	assign led8 = r_led[7];
	
	assign clk_output_25mhz = r_clk_output_25mhz;
	
endmodule

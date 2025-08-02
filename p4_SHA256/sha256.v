module sha256(
	input clk,
	input button,
	output led1,
	output led2,
	output led3,
	output led4,	
	output led5,
	output led6,
	output led7, 
	output led8
	);
	
	
	//hash
	reg [5:0] r_digist = 5;
	reg [6:0] r_charset = 35;						//25 = a-c; 35= a-z + 0-9
	reg [255:0] h1 = 256'hed968e840d10d2d313a870bc131a4e2c311d7ad09bdf32b3418147221f51a6e2;		//aaaaa
	reg [255:0] h2 = 256'h5e846c64f2db12266e6b658a8e5b5b42cc225419b3ee1fca88acbb181ddfdb52;		//bbbbb
	reg [255:0] h3 = 256'h6304fbfe2b22557c34c42a70056616786a733b3d09fb326308c813d6ab712ec0;		//ccccc
	reg [255:0] h4 = 256'haf4764571f217a9bd2c50d8e97c54239bcacb15c835100e59fda84cb33603d14;		//ddddd
    reg [255:0] h5 = 256'hed968e840d10d2d313a870bc131a4e2c311d7ad09bdf32b3418147221f51a6e2;		//aaaaa
	reg [255:0] h6 = 256'h5e846c64f2db12266e6b658a8e5b5b42cc225419b3ee1fca88acbb181ddfdb52;		//bbbbb
	reg [255:0] h7 = 256'h6304fbfe2b22557c34c42a70056616786a733b3d09fb326308c813d6ab712ec0;		//ccccc
	reg [255:0] h8 = 256'haf4764571f217a9bd2c50d8e97c54239bcacb15c835100e59fda84cb33603d14;		//ddddd
	
	//init
	reg r_initialize = 0;
	
	//if hash found
	reg r_led1 = 0;									//hash1
	reg r_led2 = 0;									//hash2
	reg r_led3 = 0;									//hash3
	reg r_led4 = 0;									//hash4
	reg r_led5 = 0;									//hash5
	reg r_led6 = 0;									//hash6
	reg r_led7 = 0;									//hash7
	reg r_led8 = 0;									//hash8
	
	//sha256 all
	reg r_init;	
	reg reset = 1;
	reg r_tb_mode = 1; 								//sha256
	reg [7:0] r_char[35:0];							//26 x 8 bit charakter: a-z
	

	//sha256 core1
	reg [511:0] r_block;
	reg [7:0] r_counter[9:0];						//10 x 8 bit counter 
	wire w_ready;
	wire [255:0] r_digest;							//hash	32 byte	
	
	//sha256 core2
	reg [511:0] r_block2;
	reg [7:0] r_counter2[9:0];						//10 x 8 bit counter 
	wire w_ready2;
	wire [255:0] r_digest2;							//hash	32 byte	
	

	
	sha256_core core1(								//core 1
		.clk(clk),
		.reset_n(reset),
		.init(r_init),
		.next(),
		.mode(r_tb_mode),
		.block(r_block),
		.ready(w_ready),
		.digest(r_digest),
		.digest_valid()
    );
	 
	
	sha256_core core2(								//core 1
		.clk(clk),
		.reset_n(reset),
		.init(r_init),
		.next(),
		.mode(r_tb_mode),
		.block(r_block2),
		.ready(w_ready2),
		.digest(r_digest2),
		.digest_valid()
    ); 
	 
	
	always @(posedge clk) begin												//initialize
		if(r_initialize == 0) begin
			r_initialize <= 1;
			r_init <= 1;
		end
	end
	
	
	
////////////// ## CORE 1 BEGIN ## ////////////////////////////////////////////////////////////////
	
	always @(posedge clk) begin
		if(w_ready == 1) begin
			if(r_initialize == 0)
				r_counter[4] = 0;													//used for more sha inst
			r_block[7:0] = r_char[r_counter[0]];
			r_block[15:8] = r_char[r_counter[1]];
			r_block[23:16] = r_char[r_counter[2]];	
			r_block[31:24] = r_char[r_counter[3]];	
			r_block[39:32] = r_char[r_counter[4]];	
			r_block[47:40] = r_char[r_counter[5]];
			r_block[55:48] = r_char[r_counter[6]];
			r_block[63:56] = r_char[r_counter[7]];

			r_block = r_block << (512-r_digist*8); 						//PADDING: shift string to left
			r_block = r_block + (128 << (512-(r_digist+1)*8));			//append 1
			r_block = r_block + r_digist*8;             					//size of string in bit	
			
			r_counter[0] <= r_counter[0] + 1;
			if(r_counter[0] == r_charset) begin
				r_counter[0] <= 0;
				r_counter[1] <= r_counter[1] + 1;
				if(r_counter[1] == r_charset) begin
					r_counter[1] <= 0;
					r_counter[2] <= r_counter[2] + 1;
					if(r_counter[2] == r_charset) begin
						r_counter[2] <= 0;
						r_counter[3] <= r_counter[3] + 1;
						if(r_counter[3] == r_charset) begin
							r_counter[3] <= 0;
							r_counter[4] <= r_counter[4] + 1;
							if(r_counter[4] == r_charset) begin
								r_counter[4] <= 0;
								r_counter[5] <= r_counter[5] + 1;
								if(r_counter[5] == r_charset) begin
									r_counter[5] <= 0;
									r_counter[6] <= r_counter[6] + 1;
									if(r_counter[6] == r_charset) begin
										r_counter[6] <= 0;
										r_counter[7] <= r_counter[7] + 1;
										if(r_counter[7] == r_charset) begin
											r_counter[7] <= 0;
											r_counter[8] <= r_counter[8] + 1;
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	
	
////////////// ## CORE 1 END ## //////////////////////////////////////////////////////////////////


////////////// ## CORE 2 BEGIN ## ////////////////////////////////////////////////////////////////
	
	always @(posedge clk) begin
		if(w_ready2 == 1) begin
			if(r_initialize == 0)
				r_counter2[4] = 0;													//used for more sha inst
			r_block2[7:0] = r_char[r_counter2[0]];
			r_block2[15:8] = r_char[r_counter2[1]];
			r_block2[23:16] = r_char[r_counter2[2]];	
			r_block2[31:24] = r_char[r_counter2[3]];	
			r_block2[39:32] = r_char[r_counter2[4]];	
			r_block2[47:40] = r_char[r_counter2[5]];
			r_block2[55:48] = r_char[r_counter2[6]];
			r_block2[63:56] = r_char[r_counter2[7]];

			r_block2 = r_block2 << (512-r_digist*8); 							//PADDING: shift string to left
			r_block2 = r_block2 + (128 << (512-(r_digist+1)*8));			//append 1
			r_block2 = r_block2 + r_digist*8;             					//size of string in bit	
			
			
			r_counter2[0] <= r_counter2[0] + 1;
			if(r_counter2[0] == r_charset) begin
				r_counter2[0] <= 0;
				r_counter2[1] <= r_counter2[1] + 1;
				if(r_counter2[1] == r_charset) begin
					r_counter2[1] <= 0;
					r_counter2[2] <= r_counter2[2] + 1;
					if(r_counter2[2] == r_charset) begin
						r_counter2[2] <= 0;
						r_counter2[3] <= r_counter2[3] + 1;
						if(r_counter2[3] == r_charset) begin
							r_counter2[3] <= 0;
							r_counter2[4] <= r_counter2[4] + 1;
							if(r_counter2[4] == r_charset) begin
								r_counter2[4] <= 0;
								r_counter2[5] <= r_counter2[5] + 1;
								if(r_counter2[5] == r_charset) begin
									r_counter2[5] <= 0;
									r_counter2[6] <= r_counter2[6] + 1;
									if(r_counter2[6] == r_charset) begin
										r_counter2[6] <= 0;
										r_counter2[7] <= r_counter2[7] + 1;
										if(r_counter2[7] == r_charset) begin
											r_counter2[7] <= 0;
											r_counter2[8] <= r_counter2[8] + 1;
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	
	
////////////// ## CORE 2 END ## //////////////////////////////////////////////////////////////////

	always @(posedge clk) begin
		case (r_digest)
			h1 : r_led1 <= 1;
			h2 : r_led2 <= 1;
			h3 : r_led3 <= 1;
			h4 : r_led4 <= 1;	
			h5 : r_led5 <= 1;
			h6 : r_led6 <= 1;
			h7 : r_led7 <= 1;
			h8 : r_led8 <= 1;
		endcase
		case (r_digest2)
			h1 : r_led1 <= 1;
			h2 : r_led2 <= 1;
			h3 : r_led3 <= 1;
			h4 : r_led4 <= 1;	
			h5 : r_led5 <= 1;
			h6 : r_led6 <= 1;
			h7 : r_led7 <= 1;
			h8 : r_led8 <= 1;
		endcase
	end
	

	

	
	always @(posedge clk) begin		
		r_char[0] = 8'b01100001;										//a
		r_char[1] = 8'b01100010;										//b
		r_char[2] = 8'b01100011;										//c
		r_char[3] = 8'b01100100;										//d
		r_char[4] = 8'b01100101;
		r_char[5] = 8'b01100110;
		r_char[6] = 8'b01100111;
		r_char[7] = 8'b01101000;
		r_char[8] = 8'b01101001;
		r_char[9] = 8'b01101010;
		r_char[10] = 8'b01101011;
		r_char[11] = 8'b01101100;
		r_char[12] = 8'b01101101;
		r_char[13] = 8'b01101110;
		r_char[14] = 8'b01101111;
		r_char[15] = 8'b01110000;
		r_char[16] = 8'b01110001;
		r_char[17] = 8'b01110010;
		r_char[18] = 8'b01110011;
		r_char[19] = 8'b01110100;
		r_char[20] = 8'b01110101;
		r_char[21] = 8'b01110110;
		r_char[22] = 8'b01110111;
		r_char[23] = 8'b01111000;
		r_char[24] = 8'b01111001;
		r_char[25] = 8'b01111010;										//z
		r_char[26] = 8'b00110000;										//0
		r_char[27] = 8'b00110001;										//1
		r_char[28] = 8'b00110010;
		r_char[29] = 8'b00110011;
		r_char[30] = 8'b00110100;
		r_char[31] = 8'b00110101;
		r_char[32] = 8'b00110110;
		r_char[33] = 8'b00110111;
		r_char[34] = 8'b00111000;
		r_char[35] = 8'b00111001;										//9
	end
	
	
	assign led1 = r_led1;
	assign led2 = r_led2;
	assign led3 = r_led3;
	assign led4 = r_led4;
	assign led5 = r_led5;
	assign led6 = r_led6;
	assign led7 = r_led7;
	assign led8 = r_led8;
	
endmodule
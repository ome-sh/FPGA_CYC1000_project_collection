module sha256(
	input clk,
	input button,
	output led,
	output led2,
	output led3,
	output led4,								
	output TX
	);
	
	//hash
	reg [5:0] r_digist = 6;
	reg [7:0] r_charset = 25;						//25 = a-c; 35= a-z + 0-9
	reg [255:0] h1 = 256'h9f45aa99ad9ab5c822155c4a44f9d64d010faeaea76468a939d2d4f046e340bd;		//roland
	reg [255:0] h2 = 256'h8cc7b2f12dd403b62cb2e9af058433342c9bb6b6d191be3e67af3452a3577314;		//luisse
	reg [255:0] h3 = 256'ha812e391245827ae9e4d6da12ce76016e12c0ecb26836a93b2cf5c0b69c163bf;		//svenio
	reg [255:0] h4 = 256'hf292d7b4a1ed9dacf4ee91e31fde51fdb9ab171138e2b41be2fe37ad307ca23f;		//baldur
	
	//init
	reg r_initialize = 0;
	
	//if hash found
	reg r_led = 0;										//hash1
	reg r_led2 = 0;									//hash2
	reg r_led3 = 0;									//hash3
	reg r_led4 = 0;									//hash4
	
	//sha256 all
	reg r_init;	
	reg reset = 1;
	reg r_tb_mode = 1; 								//sha256
	reg [7:0] r_char[35:0];							//26 x 8 bit charakter: a-z
	reg [5:0] r_cores = 6;
	

	//sha256 core1
	reg [511:0] r_block;
	reg [5:0] r_counter[9:0];						//10 x 5 bit counter 
	wire w_ready;
	wire [255:0] r_digest;							//hash	32 byte	
	
	//sha256 core2
	reg [511:0] r_block2;
	reg [5:0] r_counter2[9:0];						//10 x 5 bit counter 
	wire w_ready2;
	wire [255:0] r_digest2;							//hash	32 byte	
	
	//sha256 core3
	reg [511:0] r_block3;
	reg [5:0] r_counter3[9:0];						//10 x 5 bit counter 
	wire w_ready3;
	wire [255:0] r_digest3;							//hash	32 byte	
	
	//sha256 core4
	reg [511:0] r_block4;
	reg [5:0] r_counter4[9:0];						//10 x 5 bit counter 
	wire w_ready4;
	wire [255:0] r_digest4;							//hash	32 byte	
	
	//sha256 core5
	reg [511:0] r_block5;
	reg [5:0] r_counter5[9:0];						//10 x 5 bit counter 
	wire w_ready5;
	wire [255:0] r_digest5;							//hash	32 byte	
	
	//sha256 core6
	reg [511:0] r_block6;
	reg [5:0] r_counter6[9:0];						//10 x 5 bit counter 
	wire w_ready6;
	wire [255:0] r_digest6;							//hash	32 byte	
	
	//sha256 core7
	reg [511:0] r_block7;
	reg [5:0] r_counter7[9:0];						//10 x 5 bit counter 
	wire w_ready7;
	wire [255:0] r_digest7;							//hash	32 byte	
	
	//sha256 core8
	reg [511:0] r_block8;
	reg [5:0] r_counter8[9:0];						//10 x 5 bit counter 
	wire w_ready8;
	wire [255:0] r_digest8;							//hash	32 byte	
	

	//uart
	reg r_Tx_DV = 0;
   reg [7:0] r_Tx_Byte = 0;
	reg [3:0]r_uart_start = 0;
	reg [7:0] r_uart_byte_counter = 0;
	wire w_Tx_Active;
	wire w_Tx_Done;

	
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
	 
	sha256_core core2(								//core 2
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
	 
	sha256_core core3(								//core 3
		.clk(clk),
		.reset_n(reset),
		.init(r_init),
		.next(),
		.mode(r_tb_mode),
		.block(r_block3),
		.ready(w_ready3),
		.digest(r_digest3),
		.digest_valid()
    );
	 
	 sha256_core core4(								//core 4
		.clk(clk),
		.reset_n(reset),
		.init(r_init),
		.next(),
		.mode(r_tb_mode),
		.block(r_block4),
		.ready(w_ready4),
		.digest(r_digest4),
		.digest_valid()
    );
	 
	 sha256_core core5(								//core 5
		.clk(clk),
		.reset_n(reset),
		.init(r_init),
		.next(),
		.mode(r_tb_mode),
		.block(r_block5),
		.ready(w_ready5),
		.digest(r_digest5),
		.digest_valid()
    );
	 
	 sha256_core core6(								//core 6
		.clk(clk),
		.reset_n(reset),
		.init(r_init),
		.next(),
		.mode(r_tb_mode),
		.block(r_block6),
		.ready(w_ready6),
		.digest(r_digest6),
		.digest_valid()
    );
	 
	sha256_core core7(								//core 7
		.clk(clk),
		.reset_n(reset),
		.init(r_init),
		.next(),
		.mode(r_tb_mode),
		.block(r_block7),
		.ready(w_ready7),
		.digest(r_digest7),
		.digest_valid()
    );
	 
	sha256_core core8(								//core 8
		.clk(clk),
		.reset_n(reset),
		.init(r_init),
		.next(),
		.mode(r_tb_mode),
		.block(r_block8),
		.ready(w_ready8),
		.digest(r_digest8),
		.digest_valid()
    );
	 
	uart_tx UART_TX_INST(.
		i_Clock(clk),
     .i_Tx_DV(r_Tx_DV),
     .i_Tx_Byte(r_Tx_Byte),
     .o_Tx_Active(w_Tx_Active),
     .o_Tx_Serial(TX),
     .o_Tx_Done(w_Tx_Done)
     );
	 
	
	always @(posedge clk) begin										//initialize
		if(r_initialize == 0) begin
			r_initialize <= 1;
			r_init <= 1;
		end
	end
	
	always @(posedge clk) begin										// ## UART ## send every sec r_block
		r_uart_start <= 1;
		if(r_uart_start == 1) begin
			case (r_uart_byte_counter)
				0 : r_Tx_Byte <= r_char[r_counter[6]];
				1 : r_Tx_Byte <= r_char[r_counter[5]];
				2 : r_Tx_Byte <= r_char[r_counter[4]];
				3 : r_Tx_Byte <= r_char[r_counter[3]];
				4 : r_Tx_Byte <= r_char[r_counter[2]];
				5 : r_Tx_Byte <= r_char[r_counter[1]];
				6 : r_Tx_Byte <= r_char[r_counter[0]];
				7 : r_Tx_Byte <= 8'h0a;
			endcase
			r_uart_start <= 2;
			r_uart_byte_counter <= r_uart_byte_counter + 1;		//counter
			if(r_uart_byte_counter == r_digist) begin
				r_uart_byte_counter <= 0;
				r_uart_start <= 0;
			end
		end
		
		else if(r_uart_start == 2) begin
			r_Tx_DV <= 1;
			r_uart_start <= 3;
		end
		
		else if(r_uart_start == 3) begin
			r_Tx_DV <= 0;
			if(w_Tx_Done)
				r_uart_start <= 0;
		end	
	end
	
////////////// ## CORE 1 BEGIN ## ////////////////////////////////////////////////////////////////
	
	always @(posedge clk) begin
		if(w_ready == 1) begin
			if(r_initialize == 0)
				r_counter[5] = 0;											//used for more sha inst
			r_block[7:0] = r_char[r_counter[0]];
			r_block[15:8] = r_char[r_counter[1]];
			r_block[23:16] = r_char[r_counter[2]];	
			r_block[31:24] = r_char[r_counter[3]];	
			r_block[39:32] = r_char[r_counter[4]];	
			r_block[47:40] = r_char[r_counter[5]];

			r_block = r_block << (512-r_digist*8); 							//PADDING: shift string to left
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
				r_counter2[5] = 3;											//used for more sha inst: m
			r_block2[7:0] = r_char[r_counter2[0]];
			r_block2[15:8] = r_char[r_counter2[1]];
			r_block2[23:16] = r_char[r_counter2[2]];	
			r_block2[31:24] = r_char[r_counter2[3]];	
			r_block2[39:32] = r_char[r_counter2[4]];	
			r_block2[47:40] = r_char[r_counter2[5]];

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
								end
							end
						end
					end
				end
			end
		end
	end
	
	
////////////// ## CORE 2 END ## //////////////////////////////////////////////////////////////////

////////////// ## CORE 3 BEGIN ## ////////////////////////////////////////////////////////////////
	
	always @(posedge clk) begin
		if(w_ready3 == 1) begin
			if(r_initialize == 0)
				r_counter3[5] = 6;											//used for more sha inst
			r_block3[7:0] = r_char[r_counter3[0]];
			r_block3[15:8] = r_char[r_counter3[1]];
			r_block3[23:16] = r_char[r_counter3[2]];	
			r_block3[31:24] = r_char[r_counter3[3]];	
			r_block3[39:32] = r_char[r_counter3[4]];	
			r_block3[47:40] = r_char[r_counter3[5]];

			r_block3 = r_block3 << (512-r_digist*8); 							//PADDING: shift string to left
			r_block3 = r_block3 + (128 << (512-(r_digist+1)*8));			//append 1
			r_block3 = r_block3 + r_digist*8;             					//size of string in bit	
			
			r_counter3[0] <= r_counter3[0] + 1;
			if(r_counter3[0] == r_charset) begin
				r_counter3[0] <= 0;
				r_counter3[1] <= r_counter3[1] + 1;
				if(r_counter3[1] == r_charset) begin
					r_counter3[1] <= 0;
					r_counter3[2] <= r_counter3[2] + 1;
					if(r_counter3[2] == r_charset) begin
						r_counter3[2] <= 0;
						r_counter3[3] <= r_counter3[3] + 1;
						if(r_counter3[3] == r_charset) begin
							r_counter3[3] <= 0;
							r_counter3[4] <= r_counter3[4] + 1;
							if(r_counter3[4] == r_charset) begin
								r_counter3[4] <= 0;
								r_counter3[5] <= r_counter3[5] + 1;
								if(r_counter3[5] == r_charset) begin
									r_counter3[5] <= 0;
									r_counter3[6] <= r_counter3[6] + 1;
								end
							end
						end
					end
				end
			end
		end
	end
	
	
////////////// ## CORE 3 END ## //////////////////////////////////////////////////////////////////

////////////// ## CORE 4 BEGIN ## ////////////////////////////////////////////////////////////////
	
	always @(posedge clk) begin
		if(w_ready4 == 1) begin
			if(r_initialize == 0)
				r_counter4[5] = 9;											//used for more sha inst
			r_block4[7:0] = r_char[r_counter4[0]];
			r_block4[15:8] = r_char[r_counter4[1]];
			r_block4[23:16] = r_char[r_counter4[2]];	
			r_block4[31:24] = r_char[r_counter4[3]];	
			r_block4[39:32] = r_char[r_counter4[4]];	
			r_block4[47:40] = r_char[r_counter4[5]];

			r_block4 = r_block4 << (512-r_digist*8); 							//PADDING: shift string to left
			r_block4 = r_block4 + (128 << (512-(r_digist+1)*8));			//append 1
			r_block4 = r_block4 + r_digist*8;             					//size of string in bit	
			
			r_counter4[0] <= r_counter4[0] + 1;
			if(r_counter4[0] == r_charset) begin
				r_counter4[0] <= 0;
				r_counter4[1] <= r_counter4[1] + 1;
				if(r_counter4[1] == r_charset) begin
					r_counter4[1] <= 0;
					r_counter4[2] <= r_counter4[2] + 1;
					if(r_counter4[2] == r_charset) begin
						r_counter4[2] <= 0;
						r_counter4[3] <= r_counter4[3] + 1;
						if(r_counter4[3] == r_charset) begin
							r_counter4[3] <= 0;
							r_counter4[4] <= r_counter4[4] + 1;
							if(r_counter4[4] == r_charset) begin
								r_counter4[4] <= 0;
								r_counter4[5] <= r_counter4[5] + 1;
								if(r_counter4[5] == r_charset) begin
									r_counter4[5] <= 0;
									r_counter4[6] <= r_counter4[6] + 1;
								end
							end
						end
					end
				end
			end
		end
	end
	
	
////////////// ## CORE 4 END ## //////////////////////////////////////////////////////////////////

////////////// ## CORE 5 BEGIN ## ////////////////////////////////////////////////////////////////
	
	always @(posedge clk) begin
		if(w_ready5 == 1) begin
			if(r_initialize == 0)
				r_counter5[5] = 12;											//used for more sha inst
			r_block5[7:0] = r_char[r_counter5[0]];
			r_block5[15:8] = r_char[r_counter5[1]];
			r_block5[23:16] = r_char[r_counter5[2]];	
			r_block5[31:24] = r_char[r_counter5[3]];	
			r_block5[39:32] = r_char[r_counter5[4]];	
			r_block5[47:40] = r_char[r_counter5[5]];

			r_block5 = r_block5 << (512-r_digist*8); 							//PADDING: shift string to left
			r_block5 = r_block5 + (128 << (512-(r_digist+1)*8));			//append 1
			r_block5 = r_block5 + r_digist*8;             					//size of string in bit	
			
			r_counter5[0] <= r_counter5[0] + 1;
			if(r_counter5[0] == r_charset) begin
				r_counter5[0] <= 0;
				r_counter5[1] <= r_counter5[1] + 1;
				if(r_counter5[1] == r_charset) begin
					r_counter5[1] <= 0;
					r_counter5[2] <= r_counter5[2] + 1;
					if(r_counter5[2] == r_charset) begin
						r_counter5[2] <= 0;
						r_counter5[3] <= r_counter5[3] + 1;
						if(r_counter5[3] == r_charset) begin
							r_counter5[3] <= 0;
							r_counter5[4] <= r_counter5[4] + 1;
							if(r_counter5[4] == r_charset) begin
								r_counter5[4] <= 0;
								r_counter5[5] <= r_counter5[5] + 1;
								if(r_counter5[5] == r_charset) begin
									r_counter5[5] <= 0;
									r_counter5[6] <= r_counter5[6] + 1;
								end
							end
						end
					end
				end
			end
		end
	end
	
	
////////////// ## CORE 5 END ## //////////////////////////////////////////////////////////////////

////////////// ## CORE 6 BEGIN ## ////////////////////////////////////////////////////////////////
	
	always @(posedge clk) begin
		if(w_ready6 == 1) begin
			if(r_initialize == 0)
				r_counter6[5] = 15;											//used for more sha inst
			r_block6[7:0] = r_char[r_counter6[0]];
			r_block6[15:8] = r_char[r_counter6[1]];
			r_block6[23:16] = r_char[r_counter6[2]];	
			r_block6[31:24] = r_char[r_counter6[3]];	
			r_block6[39:32] = r_char[r_counter6[4]];	
			r_block6[47:40] = r_char[r_counter6[5]];

			r_block6 = r_block6 << (512-r_digist*8); 							//PADDING: shift string to left
			r_block6 = r_block6 + (128 << (512-(r_digist+1)*8));			//append 1
			r_block6 = r_block6 + r_digist*8;             					//size of string in bit	
			
			r_counter6[0] <= r_counter6[0] + 1;
			if(r_counter6[0] == r_charset) begin
				r_counter6[0] <= 0;
				r_counter6[1] <= r_counter6[1] + 1;
				if(r_counter6[1] == r_charset) begin
					r_counter6[1] <= 0;
					r_counter6[2] <= r_counter6[2] + 1;
					if(r_counter6[2] == r_charset) begin
						r_counter6[2] <= 0;
						r_counter6[3] <= r_counter6[3] + 1;
						if(r_counter6[3] == r_charset) begin
							r_counter6[3] <= 0;
							r_counter6[4] <= r_counter6[4] + 1;
							if(r_counter6[4] == r_charset) begin
								r_counter6[4] <= 0;
								r_counter6[5] <= r_counter6[5] + 1;
								if(r_counter6[5] == r_charset) begin
									r_counter6[5] <= 0;
									r_counter6[6] <= r_counter6[6] + 1;
								end
							end
						end
					end
				end
			end
		end
	end
	
	
////////////// ## CORE 6 END ## //////////////////////////////////////////////////////////////////

////////////// ## CORE 7 BEGIN ## ////////////////////////////////////////////////////////////////
	
	always @(posedge clk) begin
		if(w_ready7 == 1) begin
			if(r_initialize == 0)
				r_counter7[5] = 18;											//used for more sha inst
			r_block7[7:0] = r_char[r_counter7[0]];
			r_block7[15:8] = r_char[r_counter7[1]];
			r_block7[23:16] = r_char[r_counter7[2]];	
			r_block7[31:24] = r_char[r_counter7[3]];	
			r_block7[39:32] = r_char[r_counter7[4]];	
			r_block7[47:40] = r_char[r_counter7[5]];

			r_block7 = r_block7 << (512-r_digist*8); 							//PADDING: shift string to left
			r_block7 = r_block7 + (128 << (512-(r_digist+1)*8));			//append 1
			r_block7 = r_block7 + r_digist*8;             					//size of string in bit	
			
			r_counter7[0] <= r_counter7[0] + 1;
			if(r_counter7[0] == r_charset) begin
				r_counter7[0] <= 0;
				r_counter7[1] <= r_counter7[1] + 1;
				if(r_counter7[1] == r_charset) begin
					r_counter7[1] <= 0;
					r_counter7[2] <= r_counter7[2] + 1;
					if(r_counter7[2] == r_charset) begin
						r_counter7[2] <= 0;
						r_counter7[3] <= r_counter7[3] + 1;
						if(r_counter7[3] == r_charset) begin
							r_counter7[3] <= 0;
							r_counter7[4] <= r_counter7[4] + 1;
							if(r_counter7[4] == r_charset) begin
								r_counter7[4] <= 0;
								r_counter7[5] <= r_counter7[5] + 1;
								if(r_counter7[5] == r_charset) begin
									r_counter7[5] <= 0;
									r_counter7[6] <= r_counter7[6] + 1;
								end
							end
						end
					end
				end
			end
		end
	end
	
	
////////////// ## CORE 7 END ## //////////////////////////////////////////////////////////////////

////////////// ## CORE 8 BEGIN ## ////////////////////////////////////////////////////////////////
	
	always @(posedge clk) begin
		if(w_ready8 == 1) begin
			if(r_initialize == 0)
				r_counter8[5] = 21;											//used for more sha inst
			r_block8[7:0] = r_char[r_counter8[0]];
			r_block8[15:8] = r_char[r_counter8[1]];
			r_block8[23:16] = r_char[r_counter8[2]];	
			r_block8[31:24] = r_char[r_counter8[3]];	
			r_block8[39:32] = r_char[r_counter8[4]];	
			r_block8[47:40] = r_char[r_counter8[5]];

			r_block8 = r_block8 << (512-r_digist*8); 							//PADDING: shift string to left
			r_block8 = r_block8 + (128 << (512-(r_digist+1)*8));			//append 1
			r_block8 = r_block8 + r_digist*8;             					//size of string in bit	
			
			r_counter8[0] <= r_counter8[0] + 1;
			if(r_counter8[0] == r_charset) begin
				r_counter8[0] <= 0;
				r_counter8[1] <= r_counter8[1] + 1;
				if(r_counter8[1] == r_charset) begin
					r_counter8[1] <= 0;
					r_counter8[2] <= r_counter8[2] + 1;
					if(r_counter8[2] == r_charset) begin
						r_counter8[2] <= 0;
						r_counter8[3] <= r_counter8[3] + 1;
						if(r_counter8[3] == r_charset) begin
							r_counter8[3] <= 0;
							r_counter8[4] <= r_counter8[4] + 1;
							if(r_counter8[4] == r_charset) begin
								r_counter8[4] <= 0;
								r_counter8[5] <= r_counter8[5] + 1;
								if(r_counter8[5] == r_charset) begin
									r_counter8[5] <= 0;
									r_counter8[6] <= r_counter8[6] + 1;
								end
							end
						end
					end
				end
			end
		end
	end
	
	
////////////// ## CORE 8 END ## //////////////////////////////////////////////////////////////////

	 
	always @(posedge clk) begin
		if(r_digest == h1 || r_digest2 == h1 || r_digest3 == h1 || r_digest4 == h1 || r_digest5 == h1 || r_digest6 == h1 || r_digest7 == h1 || r_digest8 == h1) begin
			r_led <= 1;
		end
		else if(r_digest == h2 || r_digest2 == h2 || r_digest3 == h2 || r_digest4 == h2 || r_digest5 == h2 || r_digest6 == h2 || r_digest7 == h2 || r_digest8 == h2) begin			
			r_led2 <= 1;
		end
		else if(r_digest == h3 || r_digest2 == h3 || r_digest3 == h3 || r_digest4 == h3 || r_digest5 == h3 || r_digest6 == h3 || r_digest7 == h3 || r_digest8 == h3) begin		
			r_led3 <= 1;
		end
		else if(r_digest == h4 || r_digest2 == h4 || r_digest3 == h4 || r_digest4 == h4 || r_digest5 == h4 || r_digest6 == h4 || r_digest7 == h4 || r_digest8 == h4) begin				
			r_led4 <= 1;
		end
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
	
	
	assign led = r_led;
	assign led2 = r_led2;
	assign led3 = r_led3;
	assign led4 = r_led4;
	
endmodule
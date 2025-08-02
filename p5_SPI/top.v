//CPOL = 0; CPHA = 0

module top(
  input clk,
  input spi_clk,
  input cs,
  input mosi,
  output miso,
  output led,
  output TX,
  input button
  );

  reg [7:0] r_data_out = 0;
  reg [7:0] r_data_in;
  reg [3:0] r_byte_counter = 7;
  reg r_buffer;
  reg r_led;
  reg r_data_valid = 0;
  wire w_TX;
  
  //instances
	uart_tx uart_tx_inst_(
		.i_Clock(clk),
		.i_Tx_DV(r_data_valid),
		.i_Tx_Byte(r_data_in),
		.o_Tx_Active(),
		.o_Tx_Serial(w_TX),
		.o_Tx_Done()
   );
	

  always @(posedge spi_clk) begin  
    if(cs == 0) begin
      r_data_in[r_byte_counter] <= mosi;						//reading bit from MOSI (Master)
		r_buffer <= r_data_out[r_byte_counter-1];				//writing bit from byte
		r_byte_counter <= r_byte_counter - 1;					//Bit Counter for store data in a byte
		if(r_byte_counter == 0) begin
			r_byte_counter <= 7;
			r_data_out <= r_data_out + 1;
			if(r_data_out == 3)
				r_data_out <= 0;
		end
    end
	 else
		r_byte_counter <= 7;											//for reset (eg. Connection interrupt)
  end


  always@(posedge clk) begin
	 if(button == 0)
		r_data_valid <= 0;
	else
		r_data_valid <= 1;
		
    if(r_data_in == 3) begin
      r_led <= 1;
    end
    else
      r_led <= 0;
  end

  assign led = r_led;
  assign miso = r_buffer;
  assign TX = w_TX;

endmodule

/*

//TESTED WITH ARDUINO


  #include <SPI.h>

  void setup (void)
    {
    Serial.begin (9600);
    Serial.println ();

    digitalWrite(SS, HIGH);  // ensure SS stays high for now
    SPI.begin ();

    // Slow down the master a bit
    SPI.setClockDivider(SPI_CLOCK_DIV8);
    }  // end of setup

    int x = 0;
    
  void loop (void)
    {

    // enable Slave Select
    digitalWrite(SS, LOW);

    byte a = SPI.transfer (x);
    x++;
    if(x > 4)
      x = 0;

    // disable Slave Select
    digitalWrite(SS, HIGH);

    Serial.print("x = ");
    Serial.print(x);
    Serial.print(" -> bin: ");
    Serial.print(x, HEX);
    Serial.print("; a = ");
    Serial.print(a);
    Serial.print(" -> bin: ");
    Serial.println(a, HEX);

    delay (500);  // 1 second delay
    }  // end of loop
	 
	 */


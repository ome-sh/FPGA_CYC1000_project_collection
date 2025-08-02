module tb_sha256_core();

  //----------------------------------------------------------------
  // Internal constant and parameter definitions.
  //----------------------------------------------------------------
  parameter DEBUG = 0;

  parameter CLK_HALF_PERIOD = 2;
  parameter CLK_PERIOD = 2 * CLK_HALF_PERIOD;


  //----------------------------------------------------------------
  // Register and Wire declarations.
  //----------------------------------------------------------------
  reg [31 : 0] cycle_ctr;
  reg [31 : 0] error_ctr;
  reg [31 : 0] tc_ctr;

  reg            tb_clk;
  reg            tb_reset_n;
  reg            tb_init;
  reg            tb_next;
  reg            tb_mode;
  reg [511 : 0]  tb_block;
  wire           tb_ready;
  wire [255 : 0] tb_digest;


  //----------------------------------------------------------------
  // Device Under Test.
  //----------------------------------------------------------------
  sha256_core dut(
                  .clk(tb_clk),
                  .reset_n(tb_reset_n),

                  .init(tb_init),
                  .next(),
                  .mode(tb_mode),

                  .block(tb_block),

                  .ready(tb_ready),

                  .digest(tb_digest),
                  .digest_valid()
                 );


  //----------------------------------------------------------------
  // clk_gen
  //
  // Always running clock generator process.
  //----------------------------------------------------------------
  always
    begin : clk_gen
      #CLK_HALF_PERIOD;
      tb_clk = !tb_clk;
    end // clk_gen


  //----------------------------------------------------------------
  // sys_monitor()
  //
  // An always running process that creates a cycle counter and
  // conditionally displays information about the DUT.
  //----------------------------------------------------------------
  always
    begin : sys_monitor
      cycle_ctr = cycle_ctr + 1;
      #(2 * CLK_HALF_PERIOD);
      if (DEBUG)
        begin
          dump_dut_state();
        end
    end


  //----------------------------------------------------------------
  // wait_ready()
  //
  // Wait for the ready flag in the dut to be set.
  //
  // Note: It is the callers responsibility to call the function
  // when the dut is actively processing and will in fact at some
  // point set the flag.
  //----------------------------------------------------------------
  task wait_ready;
    begin
      while (!tb_ready)
        begin
          #(CLK_PERIOD);
        end
    end
  endtask // wait_ready


  //----------------------------------------------------------------
  // single_block_test()
  //
  // Run a test case spanning a single data block.
  //----------------------------------------------------------------
  task single_block_test(input [7 : 0]   tc_number,
                         input [511 : 0] block,
                         input [255 : 0] expected);
   begin
     $display("*** TC %0d single block test case started.", tc_number);
     tc_ctr = tc_ctr + 1;

     tb_block = block;
     tb_init = 1;
     #(CLK_PERIOD);
     wait_ready();


     if (tb_digest == expected)
       begin
         $display("*** TC %0d successful.", tc_number);
         $display("Got:      0x%064x", tb_digest);
         $display("");
       end
     else
       begin
         $display("*** ERROR: TC %0d NOT successful.", tc_number);
         $display("Expected: 0x%064x", expected);
         $display("Got:      0x%064x", tb_digest);
         $display("");

         error_ctr = error_ctr + 1;
       end
   end
  endtask // single_block_test


  //----------------------------------------------------------------
  // sha256_core_test
  // Test cases taken from:
  // http://csrc.nist.gov/groups/ST/toolkit/documents/Examples/SHA256.pdf
  //----------------------------------------------------------------
  task sha256_core_test;
    reg [511 : 0] tc1;
    reg [511 : 0] tc1_raw;
    reg [255 : 0] res1;
    reg [511 : 0] tc2_1;
    reg [255 : 0] res2_1;
    reg [511 : 0] tc2_2;
    reg [255 : 0] res2_2;
    begin : sha256_core_test

    /////////////////////////////////////////////////////////--------------------------/////////////////////////////////////////////////////////
      // TC1: Single block message: "Roland".
      tc1_raw = "Roland";
      tc1 = tc1_raw << (512-6*8); //shift to right 6=size of string
      tc1 = tc1 + (128 << (512-7*8));
      tc1 = tc1 + 48;             //48 = size of string *8 (bit)
      //tc1="Roland";
      $display("tc1: %x", tc1);

      //tc1 = 512'h526f6c616e6480000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000030;
      res1 = 256'ha1ef7bf9b9098c49c8aa4e6e8b42b199762a55f85ec6ad215a76045088276fcc;
      single_block_test(1, tc1, res1);

    /////////////////////////////////////////////////////////--------------------------/////////////////////////////////////////////////////////


    end
  endtask // sha256_core_test


  //----------------------------------------------------------------
  // main()
  //----------------------------------------------------------------
  initial
    begin : main

      tb_reset_n = 0;
      #1 tb_reset_n = 1;

      tb_clk = 0;
      tb_mode = 1;

      sha256_core_test();
      sha256_core_test();

      $finish;
    end
endmodule

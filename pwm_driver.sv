module pwm_gen (
    input logic clk_200mhz,  //200MHz, 
    input logic rst,  // active high
    input logic [11:0] din,  // sample data, take upper 12 bits of 16bit
    output logic dout
);
  // 200MHz/44.1kHz = 200e6/(100e6/2/1134) = 4536, that is within 1 sample you can only count from 0 to 4535
  logic [12:0] counter;  //max 8192
  always_ff @(posedge clk_200mhz or posedge rst) begin
    if (rst) begin
      counter <= 0;
    end else begin
      if (counter == 4535) begin  // total 4536 states
        counter <= 0;
      end else begin
        counter <= counter + 1;
      end
      if (counter < din) begin  // there is a issue that din is at max 4095, so volume won't be 100%
        dout <= 1'b1;
      end else begin
        dout <= 1'b0;
      end
    end
  end
endmodule

module binary2bcd(input [7:0]Bin, output reg [11:0] Bout);
  reg [19:0] shift_reg;
  integer i;
  
  always @(*)
    begin
      shift_reg = 0;
      shift_reg = Bin;
      
      for(i=0; i<8;i++)
        begin
          if(shift_reg[11:8] >=5) shift_reg[11:8] = shift_reg[11:8] +3;
          if(shift_reg[15:12] >=5) shift_reg[15:12] = shift_reg[15:12] +3;
          if(shift_reg[19:16] >=5) shift_reg[11:8] = shift_reg[19:16]+3;
          shift_reg = shift_reg <<1;
                       end
                       Bout = shift_reg [19:8];
                       end
                       endmodule

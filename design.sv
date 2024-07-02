module contador_sequencial (
    input wire clk,
    input wire reset,
    output reg [3:0] count
);

  wire [3:0] next_count; //Representação do proximo estado
  
  //Lógica combinacional para próximo estado
  //permite ser self-Starter
  //[3] = A [2] = B [1] = C [0] = D

  //AD' + BCD
  assign next_count[3] = (count[3] & ~count[0]) | (count[1] & count[2] & 		count[0]);
  
  //BD' + BC' B'CD
  assign next_count[2] = (count[2] & ~count[0]) | (~count[1] & count[2]) | 		(~count[2] & count[1] & count[0]);
  
  //CD' + A'C'D
  assign next_count[1] = (count[1] & ~count[0]) | (count[0] & ~count[3] & 		~count[1]);
  
  //D'
  assign next_count[0] = ~count[0];

  //atualização do estado
 always @(posedge clk or posedge reset) begin
   if (reset)
     count <= 4'b0000;// Reset para 0000
   else
     count <= next_count;
 end

endmodule

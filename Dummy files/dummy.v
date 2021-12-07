wire A_in, B_in, C_in;
reg A_out, B_out, C_out;
always @( posedge clk )
begin
 A_out <= A_in;
 B_out <= B_in;
 C_out <= C_in;
end
assign B_in = A_out + 1;
assign C_in = B_out + 1;

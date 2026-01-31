//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.01.2026 17:30:23
// Design Name: 
// Module Name: fsm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fsm(
    input wire CLK100MHZ,
    output reg LED16_R,
    output reg LED16_G,
    output reg LED16_B
   //output reg [1:0] LED
   
    );

parameter [1:0] INIT_RED =3'b00;
parameter [1:0] FOWARD_ORANGE =3'b01;
parameter [1:0] FOWARD_GREEN =3'b10;
parameter [1:0] REVERS_ORANGE =3'b11;

reg [2:0] state;
reg [7:0] counter;
wire t_1000ms;

timer_1000ms t1s(.clk(CLK100MHZ),.t_1000ms(t_1000ms));

initial begin
    LED16_R= 1'b0;
    LED16_G= 1'b0;
    LED16_B= 1'b0;
    counter =8'b0000_0000;
    state = INIT_RED;
    
end

always @ (posedge t_1000ms) begin
    
    case (state)
    INIT_RED:   begin
                 LED16_R <=1'b1;
                 counter <= counter +8'h01;
                 if(counter >= 8'd5) begin
                                       state <=FOWARD_ORANGE;
                                       LED16_R <=1'b0;
                                       counter<= 8'd0;
                                        
                                     end
                end
    
    FOWARD_ORANGE:begin
                     LED16_B <=1'b1;
                      counter <= counter +8'h01;
                      if(counter >= 8'd5) begin
                                       state <=FOWARD_GREEN;
                                       LED16_B <=1'b0;
                                       counter<= 8'd0;
                                        
                                     end
    
                   end
 
  FOWARD_GREEN:begin
                     LED16_G <=1'b1;
                      counter <= counter +8'h01;
                      if(counter >= 8'd5) begin
                                       state <=REVERS_ORANGE;
                                       LED16_G <=1'b0;
                                       counter<= 8'd0;
                                        
                                     end
    
                   end
 REVERS_ORANGE:begin
                     LED16_B <=1'b1;
                     counter <= counter +8'h01;
                     if(counter >= 8'd5) begin
                                       state <=INIT_RED;
                                       LED16_B <=1'b0;
                                       counter<= 8'd0;
                                        
                                     end
    
                   end
                   
    
    default: begin
        LED16_R= 1'b0;
        LED16_G= 1'b0;
        LED16_B= 1'b0;
        counter =8'b0000_0000;
        state = INIT_RED;
    
    end 
    endcase

end

endmodule
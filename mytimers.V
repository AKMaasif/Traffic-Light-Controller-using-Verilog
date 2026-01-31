`timescale 1ns / 1ps

module timer_1000ms(
    input wire clk,
    output reg t_1000ms
    );
    
    reg [31:0] counter;

    always @(posedge clk)
    begin
        if(counter >= 32'd50000000)
        begin
            counter <= 32'd0;
            t_1000ms <= ~t_1000ms; // non-blocking
        end
        else 
        begin
            counter <= counter + 32'd1;
        end
    end
endmodule
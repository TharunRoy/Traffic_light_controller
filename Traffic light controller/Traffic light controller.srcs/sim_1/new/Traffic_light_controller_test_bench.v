`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2023 12:05:15
// Design Name: 
// Module Name: Traffic_light_controller_test_bench
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


module Traffic_light_controller_test_bench();

reg rst,clock;
reg [3:0] state,sensor_ip;
wire [3:0] next_state;


Traffic_light_controller controller(.clock(clock),.rst(rst),.sensor_ip(sensor_ip),.state(state),.next_state(next_state));

initial
begin
state <= 4'b0000;
sensor_ip <= 4'b0000;
end
initial
begin

clock <= 0;
forever #10 clock = ~clock;

end

initial
begin
forever #10 state <= next_state;
end

initial
begin

rst <= 1'b1;
#10;
rst <= 1'b0;
#10;
sensor_ip <= 4'b0000;
#10;


#150;sensor_ip = 4'b1100;
#150;sensor_ip = 4'b1101;
#150;sensor_ip = 4'b0100;
#150;sensor_ip = 4'b0010;
#150;sensor_ip = 4'b0011;
#150;sensor_ip = 4'b0001;
#150;sensor_ip = 4'b1111;
#150;sensor_ip = 4'b1110;
$finish;
end
endmodule

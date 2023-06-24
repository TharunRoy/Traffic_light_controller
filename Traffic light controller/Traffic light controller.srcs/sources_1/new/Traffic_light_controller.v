`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2023 17:44:12
// Design Name: 
// Module Name: Traffic_light_controller
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


module Traffic_light_controller(
                                clock,              //clock
                                rst,                //reset
                                sensor_ip,          //input from the sensor
                                state,              //present state of traffic light
                                next_state          //next state of traffic light
                                );

    input rst;
    input clock;
    input[3:0] sensor_ip,state;
    output reg [3:0] next_state;
    reg [2:0]count_green,count_yellow;
    
    
    parameter time_green = 3'd4;
    parameter time_yellow = 3'd2;
    parameter s0 = 4'b0000;
    parameter s1 = 4'b0001;
    parameter s2 = 4'b0010;
    parameter s3 = 4'b0011;
    parameter s4 = 4'b0100;
    parameter s5 = 4'b0101;
    parameter s6 = 4'b0110;
    parameter s7 = 4'b0111;
    parameter s8 = 4'b1000;
    
    
    always @(posedge clock)
    begin : logic
        if ( rst == 1'b1) begin
            next_state <= s0;
            count_green <= 3'd0;
            count_yellow <= 3'd0;
        end
        
        else begin
            case (state)
            
                s0:
                if (sensor_ip == 4'b0000) begin
                    next_state <= s0;
                end
                else if(sensor_ip[3:3] == 1'b1) begin       //1xxx
                    next_state <= s1;
                end
                else if(sensor_ip[3:2] == 2'b01) begin      //01xx
                    next_state <= s2;
                end
                else if(sensor_ip[3:1] == 3'b001) begin     //001x
                    next_state <= s3;
                end
                else if(sensor_ip == 4'b0001) begin
                    next_state <= s4;
                end
                else begin
                    next_state <= s0;
                end
                
                s1:
                if (count_green >= time_green) begin
                    count_green = 3'd0;
                    next_state <= s5;
                end
                else begin
                    next_state <= s1;
                    count_green <= count_green + 3'd1;
                end
                
                s2:
                if (count_green >= time_green) begin
                    count_green <= 3'd0;
                    next_state <= s6;
                end
                else begin
                    next_state <= s2;
                    count_green <= count_green + 3'd1;
                end
                
                s3:
                if (count_green >= time_green) begin
                    count_green <= 3'd0;
                    next_state <= s7;
                end
                else begin
                    next_state <= s3;
                    count_green <= count_green + 3'd1;
                end
                
                s4:
                if (count_green >= time_green) begin
                    count_green <= 3'd0;
                    next_state <= s8;
                end
                else begin
                    next_state <= s4;
                    count_green <= count_green + 3'd1;
                end
                
                s5:
                if (count_yellow >= time_yellow) begin
                    count_yellow <= 3'd0;
                    if (sensor_ip[2:0] == 3'b000) begin         //x000
                        next_state <= s0;
                    end
                    else if(sensor_ip[2:2] == 1'b1) begin       //x1xx
                        next_state <= s2;
                    end
                    else if(sensor_ip[2:1] == 2'b01) begin      //x01x
                        next_state <= s3;
                    end
                    else if(sensor_ip[2:0] == 3'b001) begin     //x001
                        next_state <= s4;
                    end
                    else begin
                        next_state <= s0;
                    end
                end
                else begin
                    next_state <= s5;
                    count_yellow <= count_yellow + 3'd1;
                end
                
                s6:
                if (count_yellow >= time_yellow) begin
                    count_yellow <= 3'd0;
                    if (sensor_ip[3:3] == 1'b0 && sensor_ip[1:0] == 2'b00) begin        //0x00
                        next_state <= s0;
                    end
                    else if(sensor_ip[3:3] == 1'b1) begin                               //1xxx
                        next_state <= s1;
                    end
                    else if(sensor_ip[3:3] == 1'b0 && sensor_ip[1:1] == 1'b1) begin     //0x1x
                        next_state <= s3;
                    end
                    else if(sensor_ip[1:0] == 2'b01) begin                              //xx01
                        next_state <= s4;
                    end
                    else begin
                        next_state <= s0;
                    end
                end
                else begin
                    next_state <= s6;
                    count_yellow <= count_yellow + 3'd1;
                end
                
                
                s7:
                if (count_yellow >= time_yellow) begin
                    count_yellow <= 3'd0;
                    if (sensor_ip[3:2] == 2'b00 && sensor_ip[0:0] == 1'b0) begin        //00x0
                        next_state <= s0;
                    end
                    else if(sensor_ip[3:3] == 1'b1) begin                               //1xxx
                        next_state <= s1;
                    end
                    else if(sensor_ip[3:2] == 2'b01) begin                              //01xx
                        next_state <= s2;
                    end
                    else if(sensor_ip[0:0] == 1'b1) begin                               //xxx1
                        next_state <= s4;
                    end
                    else begin
                        next_state <= s0;
                    end
                end
                else begin
                    next_state <= s7;
                    count_yellow <= count_yellow + 3'd1;
                end
            
                s8:
                if (count_yellow >= time_yellow) begin
                    count_yellow <= 3'd0;
                    if (sensor_ip[3:1] == 3'b000) begin         //000x
                        next_state <= s0;
                    end
                    else if(sensor_ip[3:3] == 1'b1) begin       //1xxx
                        next_state <= s1;
                    end
                    else if(sensor_ip[3:2] == 2'b01) begin      //01xx
                        next_state <= s2;
                    end
                    else if(sensor_ip[3:1] == 3'b001) begin     //001x
                        next_state <= s3;
                    end
                    else begin
                        next_state <= s0;
                    end
                end
                else begin
                    next_state <= s8;
                    count_yellow <= count_yellow + 3'd1;
                end
                default:
                next_state <= s0;
            endcase
        end
    end
endmodule

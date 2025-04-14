`timescale 1ns / 1ps
module traffic_controller(
    input reset,            // button input
    input clk_100MHz,       // FPGA clock
    output [2:0] main_st,   // 3-bit output for main street light ( R, Y, G )
    output [2:0] cross_st   // 3-bit output for cross street light ( R, Y, G )
    );
    
    wire w_1Hz, w_reset; // internal wires
    
    state_machine sm(.reset(w_reset), .clk_1Hz(w_1Hz), 
                     .main_st(main_st), .cross_st(cross_st)); //my main logic (FSM) and use 1Hz clock, debounced reset 
    oneHz_gen uno(.clk_100MHz(clk_100MHz), .reset(w_reset), .clk_1Hz(w_1Hz));
    sw_debounce db(.clk(clk_100MHz), .btn_in(reset), .btn_out(w_reset) );
    
endmodule

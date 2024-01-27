`timescale 1ns / 1ps
`include "two_player_game.v"
module two_player_game_tb();

    // Declare the inputs and outputs
    reg clk, reset;
    reg [2:0] action_player1, action_player2;
    wire [1:0] health_player1, health_player2;
    wire [2:0] position_player1, position_player2;

    // Instantiate the two_player_game module
    two_player_game uut (
        .clk(clk),
        .reset(reset),
        .action_player1(action_player1),
        .action_player2(action_player2),
        .health_player1(health_player1),
        .health_player2(health_player2),
        .position_player1(position_player1),
        .position_player2(position_player2)
    );

    // Generate the reset signal
    initial begin
        reset = 1;
        clk = 0;
        #10;
        reset = 0;
        repeat(27) #10 clk = ~clk;
    end

    // Apply the test vectors
    initial begin
        $dumpfile("two_player_game_tb.vcd");
        $dumpvars(0, uut);
        #20;
        
        action_player1 = 3'b001;//move right
        action_player2 = 3'b000;//move left
        #20

        action_player1 = 3'b001;//move right
        action_player2 = 3'b000;//move left
        #20;

        
        action_player1 = 3'b100;//punch
        action_player2 = 3'b010;//jump
        #20;

        action_player1 = 3'b100;//punch
        action_player2 = 3'b101;//kick
        #20;

        action_player1 = 3'b100;//punch
        action_player2 = 3'b100;//punch
        #20;

        action_player1 = 3'b001;//move right
        action_player2 = 3'b011;//wait
        #20;

        action_player1 = 3'b010;//jump
        action_player2 = 3'b011;//wait
        #20;

        action_player1 = 3'b100;//punch
        action_player2 = 3'b101;//kick
        #20;

        action_player1 = 3'b101;//kick
        action_player2 = 3'b010;//jump
        #20;

        action_player1 = 3'b000;//move left
        action_player2 = 3'b101;//kick
        #20;

        action_player1 = 3'b101;//kick
        action_player2 = 3'b000;//move left
        #20;

    


    end

endmodule

`timescale 1ns / 1ps


module two_player_game(
    input clk, reset,
    input [2:0] action_player1, action_player2,
    output reg [1:0] health_player1, health_player2,
    output reg [2:0] position_player1, position_player2
);

// Define states for actions
parameter MOVE_LEFT = 3'b000, MOVE_RIGHT = 3'b001, JUMP = 3'b010, WAIT = 3'b011, PUNCH = 3'b100, KICK = 3'b101;

// State registers for both players
reg [2:0] state_player1, state_player2, last_action_player1, last_action_player2;

// Initialize players' states, health, positions, and last actions
initial begin
    health_player1 = 3;  // 3 health points
    health_player2 = 3;
    position_player1 = 0;  // Starting positions
    position_player2 = 5;
    state_player1 = WAIT;  // Starting state
    state_player2 = WAIT;
    last_action_player1 = WAIT;
    last_action_player2 = WAIT;
end

// State transition logic with clock and reset
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Resetting health, positions, and last actions
        health_player1 <= 3;
        health_player2 <= 3;
        position_player1 <= 0;
        position_player2 <= 5;
        state_player1 <= WAIT;
        state_player2 <= WAIT;
        last_action_player1 <= WAIT;
        last_action_player2 <= WAIT;
    end else begin
        // Update states based on actions
        state_player1 <= action_player1;
        state_player2 <= action_player2;
    end
end

// Game logic to handle interactions, health changes, and special rules
always @(posedge clk) begin
    // Handling movement
    if (state_player1 == MOVE_LEFT && position_player1 > 0) position_player1 <= (position_player1 - 1);
    else if (state_player1 == MOVE_RIGHT && position_player1 < 2) position_player1 <= (position_player1 + 1);
    if (state_player2 == MOVE_LEFT && position_player2 > 3) position_player2 <= (position_player2 - 1);
    else if (state_player2 == MOVE_RIGHT && position_player2 < 5) position_player2 <= (position_player2 + 1);

    // Handling attacks and health reduction
    if (position_player2 - position_player1 == 1) begin
        // Punch takes precedence over kick
        if (state_player1 == PUNCH && state_player2 != PUNCH && state_player2 != JUMP) health_player2 <= health_player2 - 2;
        else if (state_player2 == PUNCH && state_player1 != PUNCH && state_player1 != JUMP) health_player1 <= health_player1 - 2;
        else if (state_player1 == KICK && state_player2 != KICK && state_player2 != JUMP) health_player2 <= health_player2 - 1;
        else if (state_player2 == KICK && state_player1 != KICK && state_player1 != JUMP) health_player1 <= health_player1 - 1;
        else if (state_player1 == PUNCH && state_player2 == PUNCH) begin
            // Both players perform the same attack, move to farthest positions
            position_player1 <= position_player1 - 1;  // Leftmost position for player 1
            position_player2 <= position_player2 + 1;  // Rightmost position for player 2
        end
        else if (state_player1 == KICK && state_player2 == KICK) begin
            // Both players perform the same attack, move to farthest positions
            position_player1 <= position_player1 - 1;  // Leftmost position for player 1
            position_player2 <= position_player2 + 1;  // Rightmost position for player 2
        end
    end

    if(position_player2 - position_player1 == 2) begin
        if (state_player1 == KICK && state_player2 != KICK && state_player2 != JUMP) health_player2 <= (health_player2 - 1);
        else if (state_player2 == KICK && state_player1 != KICK && state_player1 != JUMP) health_player1 <= (health_player1 - 1);
        else if (state_player1 == KICK && state_player2 == KICK) begin
            // Both players perform the same attack, move to farthest positions
            position_player1 <= position_player1 - 1;  // Leftmost position for player 1
            position_player2 <= position_player2 + 1;  // Rightmost position for player 2
        end
    end

    // Handling the wait logic for player 1
    if (state_player1 == WAIT && last_action_player1 == WAIT) begin
        if (health_player1 < 3) health_player1 <= health_player1 + 1;
    end
    last_action_player1 <= state_player1;  // Update last action

    // Handling the wait logic for player 2
    if (state_player2 == WAIT && last_action_player2 == WAIT) begin
        if (health_player2 < 3) health_player2 <= health_player2 + 1;
    end
    last_action_player2 <= state_player2;  // Update last action
end

endmodule
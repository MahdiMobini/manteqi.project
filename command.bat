iverilog -o two_player_game_tb.vvp two_player_game_tb.v
vvp two_player_game_tb.vvp




        
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



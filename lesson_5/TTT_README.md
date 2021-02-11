# TicTacToe Bonus Features exploration and checklists:

## 1. Improved #join
If we run the current game, we'll see the following prompt:
=> Choose a position to place a piece: 1, 2, 3, 4, 5, 6, 7, 8, 9

This is ok, but we'd like for this message to read a little better. We want to separate the last item with a "or", so that it reads:
=> Choose a position to place a piece: 1, 2, 3, 4, 5, 6, 7, 8, or 9

Currently, we're using the Array#join method, which can only insert a delimiter between the array elements, and isn't smart enough to display a joining word for the last element.

Write a method called joinor that will produce the following result:
joinor([1, 2])                   # => "1 or 2"
joinor([1, 2, 3])                # => "1, 2, or 3"
joinor([1, 2, 3], '; ')          # => "1; 2; or 3"
joinor([1, 2, 3], ', ', 'and')   # => "1, 2, and 3"

Then, use this method in the TTT game when prompting the user to mark a square.

Notes:
  - Decided to implement this #joinor method within the Joinable module for reuse
    later as needed and to fit with the OO paradigm
  - Mixed Joinable module into RPSGame class and defined a new RPSGame instance method
    \#display_unmarked_keys which makes use of the joinor method. Added this method
    to the RPSGame class instead of the board because all the other display methods
    are within this class and this way the Board class can remain agnostic in terms
    of how the board is displayed (for other games, for example)

## 2. Keep Score
Keep score of how many times the player and computer each win. Don't use global or instance variables. Make it so that the first player to 5 wins the game.

Checklist
  [x] Constant to keep track of game winning score (WINNING_ROUNDS = 5)
  [x] A structure to store the score of each Player (Human and Computer)
    - Added an instance variable @score to Player class, initialized to 0
  [x] a mechanism for updating the score of the winning Player each round
  [x] a mechanism for checking if the grand winning score has been reached
      by either player (compare player scores to the winning rounds number)
  [x] a mechanism for asking the player if they want to continue to the
      next round or stop early
  [x] a mechanism for displaying the grand winner
      [x] display grand winner needs to reflect quitting early (ties)
  [x] a mechanism for restarting the whole game (adapt existing)
  [x] update the intro messaging to say how many rounds constitute a game
      "first to 10 games wins" for example
  [x] a mechanism to display the score and round number
  [x] keep track of total rounds (RPSGame instance variable?)
  [x] Refactor reset method with any necessary changes

## 3. Computer AI: Defense
The computer currently picks a square at random. That's not very interesting. Let's make the computer defensive minded, so that if there's an immediate threat, then it will defend the 3rd square. We'll consider an "immediate threat" to be 2 squares marked by the opponent in a row. If there's no immediate threat, then it will just pick a random square.

## 4. Computer AI: Offense
The defensive minded AI is pretty cool, but it's still not performing as well as it could because if there are no impending threats, it will pick a square at random. We'd like to make a slight improvement on that. We're not going to add in any complicated algorithm (there's an extra bonus below on that), but all we want to do is piggy back on our find_at_risk_square from bonus #3 above and turn it into an attacking mechanism as well. The logic is simple: if the computer already has 2 in a row, then fill in the 3rd square, as opposed to moving at random.

## 5. Computer Turn Refinements
a) We actually have the offense and defense steps backwards. In other words, if the computer has a chance to win, it should take that move rather than defend. As we have coded it now, it will defend first. Update the code so that it plays the offensive move first.

b) We can make one more improvement: pick square #5 if it's available. The AI for the computer should go like this: first, pick the winning move; then, defend; then pick square #5; then pick a random square.

c) Can you change the game so that the computer moves first? Can you make this a setting at the top (i.e. a constant), so that you could play the game with either player or computer going first? Can you make it so that if the constant is set to "choose", then your game will prompt the user to determine who goes first? Valid options for the constant can be "player", "computer", or "choose".

## 6. Improve the game loop
There's a bit of redundant code in the main game loop:

loop do
  display_board(board)

  player_places_piece!(board)
  break if someone_won?(board) || board_full?(board)

  computer_places_piece!(board)
  break if someone_won?(board) || board_full?(board)
end

Notice how we have to break after each player makes a move. What if we could have a generic method that marks a square based on the player? We could do something like this:

loop do
  display_board(board)
  place_piece!(board, current_player)
  current_player = alternate_player(current_player)
  break if someone_won?(board) || board_full?(board)
end

There are two new methods there: place_piece! and alternate_player. The place_piece! is a generic method that will know how to place the piece on the board depending on the current_player. That is, it will call player_places_piece! or computer_places_piece! depending on the value of current_player. The trick, then, is to keep track of a current_player, and to switch that variable's value after every turn.

See if you can build those two methods and make this work.

There are two new methods there: place_piece! and alternate_player. The place_piece! is a generic method that will know how to place the piece on the board depending on the current_player. That is, it will call player_places_piece! or computer_places_piece! depending on the value of current_player. The trick, then, is to keep track of a current_player, and to switch that variable's value after every turn.

See if you can build those two methods and make this work.

## Additional OOP Bonus Features

### 2. Allow the player to pick any marker

### 3. Set a name for the player and computer

## Own ideas
Below are some extra ideas you may want to explore on your own. They're too challenging and out of scope for this course, but may be worth exploring for the adventurous programmer.

### 1 Minimax algorithm

You can build an unbeatable Tic Tac Toe by utilizing the minimax algorithm.

### 2 Bigger board

What happens if the board is 5x5 instead of 3x3? What about a 9x9 board?

### 3 More players

When you have a bigger board, you can perhaps add more than 2 players. Would it be interesting to play against 2 computers? What about 2 human players against a computer?


## Final Checklist
[ ] Run Rubocop and fix any issues
[ ] Method access control - only expose necessary methods publicly
[ ] OOP design 
  [ ] Refactor duplicate code into a class or module to inherit and override
  [ ] Create CRC cards to reflect on structure
  [ ] Refactor dependencies so less objects know about each other
[ ] Final rubocop run and fix
[ ] Remove any comments and binding.pry and require pry/byebug
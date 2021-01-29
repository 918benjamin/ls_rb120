RPS Bonus Features (Instructions and my thoughts/notes)
- Keeping score
  Right now, the game doesn't have very much dramatic flair. It'll be more
  interesting if we were playing up to, say, 10 points. Whoever reaches 10 points
  first wins. Can you build this functionality? We have a new noun -- a score. Is
  that a new class, or a state of an existing class? You can explore both options
  and see which one works better.

  Notes:
    - 10 points is a constant vs magic number
    - Score as class
      - Needs to be flexible: a state that stores both the human and computer scores
      - Could I implement every in this one class easier than as states?
        - comparing scores, determining a grand winner, etc.
    - Score as state
      - Easy to imagine a score as a state of a Player object
      - But then how do we compare the scores to determine a winner?
        Where does that code live?
    - Checklist
      [x] A structure to store the score of each Player (Human and Computer)
      [x] a mechanism for updating the score of the winning Player each round
        (BAD: display_winner method is doing too much)
      [x] a constant (winning rounds number) to hold the grand winning score (10)
      [x] a mechanism for checking if the grand winning score has been reached
            by either player (compare player scores to the winning rounds number)
      [x] a mechanism for asking the player if they want to continue to the
            next round or quit early
      [x] a mechanism for displaying the grand winner
        [x] display grand winner needs to reflect quitting early (ties)
      [x] a mechanism for restarting the whole game (adapt existing)
      [x] update the intro messaging to say how many rounds constitute a game
            "first to 10 games wins" for example
      [x] a mechanism to display the score and round number
          [x] keep track of total rounds (RPSengine instance variable?)
              (Related to future "history of rounds" bonus feature)
      Extra Bonus(my own ideas):
        [ ] Let the user choose how many rounds before a grand winner is chosen?
            (Is the winning rounds still a constant in this scenario?)
            (Is there such a thing as a user inputted constant?)
        [ ] ASCII art for the grand winner message?

- Add Lizard and Spock
  This is a variation on the normal Rock Paper Scissors game by adding two more
  options - Lizard and Spock. The full explanation and rules are here:
  http://www.samkass.com/theories/RPSSL.html

  Extra bonus(my own ideas)
  [ ] let the user choose rock paper scissors version or lizard spock version from the start

- Add a class for each move
  What would happen if we went even further and introduced 5 more classes, one
  for each move: Rock, Paper, Scissors, Lizard, and Spock. How would the code
  change? Can you make it work? After you're done, can you talk about whether
  this was a good design decision? What are the pros/cons?

  Pros/cons:
    - I did get it to work and it seems to be an OK design decision.
    - Con: I had to add some additional complexity in order to instantiate the right
        object since we can no longer just instantiate a single Move object.
    - Pro: I was able to elimitate much of the code from the Move class
    - Pro: I replaced the many or checks within the > and < Move instance methods
      - Replaced these with simpler versions within each individual move subclass

- Keep track of a history of moves
  As long as the user doesn't quit, keep track of a history of moves by both the
  human and computer. What data structure will you reach for? Will you use a new
  class, or an existing class? What will the display output look like?

  Notes:
    - Each round I need to keep track of the
      - round number (before it increments)
      - human object coupled with their move
      - computer object coupled with their move
    - Could use nested arrays with a pattern - [[round #, human move, computer move]]
    - Could use one instance variable of the RPS engine to store with no new classes
    - Could create instance variable within the player class to store their own move
      - Then access it from within the RPS engine class
    - Display:
      Round 1: Player's Scissors beat Computer's Paper
      Round 2: ...

  Checklist:
    [x] Create move_log instance variable and attr_accessor in Player class
    [x] Initialize empty history: empty array
    [x] Method for outputting the move history if the user would like
      [x] Ask the user if they want to see history (before asking to play again)
      [x] Output the history. Format: Round 1: Player's Scissors beat Computer's Paper
    [x] Store each move to the history of that player (nested array)
    [x] Reset history if they play again

- Computer personalities
  We have a list of robot names for our Computer class, but other than the name,
  there's really nothing different about each of them. It'd be interesting to
  explore how to build different personalities for each robot. For example, R2D2
  can always choose "rock". Or, "Hal" can have a very high tendency to choose
  "scissors", and rarely "rock", but never "paper". You can come up with the
  rules or personalities for each robot. How would you approach a feature like this?

  Notes:
    - Build a robot personality engine
      - Method that initializes a new set of move options for each robot
      - An array with total number of possibilities X times the actual amount
        so we can increase the probability of some
      - Formula for each robot that defines the personality

Other ideas (my own bonus features):
  [x] Accept single letter user inputs (just like old RPS game)
  - add an 'and/or' method - "Rock paper scissors lizard, or spock"
  - Could refactor the three related methods into one with arguments
    - play_again? #stop_early? #view_move_log?
    - but this would require quite a bit of customization.
      Might be better to leave them as is for now

- Notes from TA feedback on other code reviews:
  [x] Accept abbreviations for human move input

Code Review Feedback from Karl
[x] Extract planning and notes to a readme.md file
[x] In user move prompt, specify that the first letter is OK for other choices.
[x] Refactor Human#choose method to fix Rubocop cop and split into two methods
[x] Define more general < & > methods in Move class and have subclasses inherit
      these methods.
[x] Don't need both < & > methods in Move class (only used in RPSGame#determine_winner)
    - Eliminate need for one method by amending the elsif conditional expression:
      elsif computer.move > human.move
[x] Create subclasses for each of the computer personalities to match OO paradigm
    - The idea is to use objects for managing different behavior (vs conditional expressions)
[x] Implement method access control
    - Many methods in RPSGame only called by other methods of RPSGame (make private)
[x] Clear screen method should be in a module and then mixed into classes that need it
[x] Refactor the methods that are currently disabling rubocop cops
[ ] Check for method access control in classes besides RPSGame
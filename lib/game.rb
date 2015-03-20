class Game
  attr_accessor :board, :player, :computer, :turn_count

  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @turn_count = 0
    get_player_marker
    assign_computer
  end

  def show_board
    puts "
    "
    puts "#{self.board[0]} | #{self.board[1]} | #{self.board[2]}"
    puts "-----------"
    puts "#{self.board[3]} | #{self.board[4]} | #{self.board[5]}"
    puts "-----------"
    puts "#{self.board[6]} | #{self.board[7]} | #{self.board[8]}"
    puts "
    "
  end

  def turn_verbiage
    if @turn_count == 0
      puts "Let's go! Player 1, enter your move"
      show_board
    elsif @turn_count <= 3
      puts "Player 1, enter your move"
    elsif @turn_count >= 4 && @turn_count <6
      puts "The game marches forward! Enter your move"
    elsif @turn_count >= 6 && @turn_count <9
      puts "Things are really getting heated! Enter your move"
    end
  end

  def get_player_marker
    puts "Welcome to TicTacToe. Are you X or O?"
    marker_input = gets.chomp.upcase
    if validate_marker?(marker_input)
      @player = Player.new(marker_input)
    else
      puts "Error, please enter either X or O"
      get_player_marker #loop
    end
  end

  def validate_marker?(marker)
    if marker == "X" || marker == "O" || marker == "x" || marker == "o"
      true
    end
  end

  def assign_computer
    if self.player.marker == "X"
      @computer = Computer.new("O")
    else
      @computer = Computer.new("X")
    end
  end

  def play
    make_moves
    show_board
    if win?
      win_verbiage
      try_again
    else
      tie_game_verbiage
      try_again
    end
  end

  def try_again
    puts "Want to try again? Y/N"
    input = gets.chomp.upcase
    if input == "Y"
      Game.new.play
    else
      puts "Thanks for playing."
    end
  end


  def win?
    if @turn_count >= 5
      win_combos.each do |combo|
        if combo.uniq.count == 1
          return true
        end
      end
    end
    false
  end


  def win_marker
    if @turn_count >= 5
      win_combos.each do |combo|
        if combo.uniq.count == 1
          return combo.first
        end
      end
    end
  end


  def win_verbiage
    if win_marker == "X"
      puts "X Wins!"
      if @computer.marker == "X"
        puts "You lose!"
      elsif
        puts "You win!"
      end
    elsif win_marker == "O"
      puts "O Wins!!"
      if @computer.marker == "O"
        puts "You lose!!"
      elsif
        puts "You win!!"
      end
    end
  end

    def win_combos
      combos = [
        [@board[0],@board[3],@board[6]],
        [@board[1],@board[4],@board[7]],
        [@board[2],@board[5],@board[8]],
        [@board[0],@board[1],@board[2]],
        [@board[3],@board[4],@board[5]],
        [@board[6],@board[7],@board[8]],
        [@board[0],@board[4],@board[8]],
        [@board[2],@board[4],@board[6]]]
    end

  def tie_game_verbiage
    if !win?
      print "Game is a tie."
    end
  end

  def make_moves
    while @turn_count <= 8 && !win?
      if @turn_count.even?
        turn_verbiage
        actual_input = @player.move
        if validate_move?(actual_input)
          position = actual_input.to_i
          if self.board[position] == "X" || self.board[position] == "O"
            puts "Space taken"
          else
            self.board[position] = @player.marker
            @turn_count += 1
          end
        else
          puts "Please enter a number 0 through 8 that is not in a spot that has already been played."
        end
      else
        position = self.computer.move
        if self.board.include?(position)
          self.board[position.to_i] = @computer.marker
          puts "FYI Computer played position #{position}"
          show_board
          @turn_count += 1
        else
          @turn_count
        end
      end
    end
  end

  def validate_move?(actual_input)
    if self.board.include?(actual_input)
      true
    end
  end

end


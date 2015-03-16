class Board
  attr_accessor :board, :player, :computer
  def initialize
    @board = ["0", "1,", "2", "3", "4", "5", "6", "7", "8"]
  end



  def show_board
    puts "#{self.board[0]} | #{self.board[1]} | #{self.board[2]}"
    puts "---------------"
    puts "#{self.board[3]} | #{self.board[4]} | #{self.board[5]}"
    puts "---------------"
    puts "#{self.board[6]} | #{self.board[7]} | #{self.board[8]}"
  end

  def get_player_marker
    puts "Welcome to TicTacToe. Are you X or O?"
    marker_input = gets.chomp

    if validate_marker?(marker_input)
      @player = Player.new(marker_input)
    else
      puts "Error, please enter either X or O"
      get_player_marker #loop
    end

  end

  def validate_marker?(marker)
    if marker == "X" || marker == "O"
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

  def play_game
    get_player_marker
    assign_computer
    make_moves
  end

  def make_moves
    actual_input = @player.move
    if validate_move?(actual_input)
      self.board[actual_input.to_i] = @player.marker
    binding.pry
    else
      "Please enter a number 0 through 8 that is not in a spot that has already been played."
    end
  end

  def validate_move?(actual_input)
    if self.board.include?(actual_input)
      true
    end
  end


end

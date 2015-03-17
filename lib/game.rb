class Game
  attr_accessor :board, :player, :computer, :turn_count
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @turn_count = 0
    get_player_marker
    assign_computer
  end


  def show_board
    puts "#{self.board[0]} | #{self.board[1]} | #{self.board[2]}"
    puts "---------------"
    puts "#{self.board[3]} | #{self.board[4]} | #{self.board[5]}"
    puts "---------------"
    puts "#{self.board[6]} | #{self.board[7]} | #{self.board[8]}"
  end

  def turn_verbiage
    if @turn_count <= 3
      puts "Player 1. Enter your move"
    elsif @turn_count >= 4
      puts "The game marches forward! Enter your move"
    else
      puts "Things are really getting heated Enter your move"
    end
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

  def play
    make_moves
  end

  def win?
    if @turn_count >= 5
      win_combos.each do |combo|
        if combo.uniq.count == 1
          if combo.include? "X"
            puts "X wins!"
          elsif combo.include? "O"
            puts "O wins!"
          end
          return true
        end
      end
      false
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

  # def try_again
  #   if @turn_count == 9
  #     print "Want to try again? Y/N"
  #     input = gets.chomp.to_s
  #     if input == "Y"
  #       @turn_count = 0
  #     else
  #       print "Thanks for playing."
  #     end
  #   end
  # end



  # def tie_game
  #   if @turn_count <=8 && win? == false
  #   end
  # end


  def make_moves
    while @turn_count <9 && !win?
      if @turn_count.even?
        turn_verbiage
        actual_input = @player.move
        if validate_move?(actual_input)
          position = actual_input.to_i
          if self.board[position] == "X" || self.board[position] == "O"
            puts "Space taken"
          else
            self.board[position] = @player.marker
            show_board
            @turn_count+=1
          end
        else
          puts "Please enter a number 0 through 8 that is not in a spot that has already been played."
        end
      else
        position = self.computer.move
        if self.board.include?(position)
          self.board[position.to_i] = @computer.marker
          puts "FYI Computer played #{position}"
          show_board
          @turn_count+=1
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

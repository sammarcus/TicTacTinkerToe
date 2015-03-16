class Player
  attr_accessor :marker
  def initialize(marker)
    @marker = marker
  end

  def move
    puts "Player 1 start. Enter your position"
    input = gets.chomp.to_s
  end


end

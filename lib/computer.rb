class Computer
  attr_accessor :marker
  def initialize(marker)
    @marker = marker
  end

  def move
    random_move = rand(9).to_s
  end



end

#card.rb

class Card
  attr_accessor :costume, :color
  def initialize(costume, color)
    @costume = costume; @color = color
  end
end
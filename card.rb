#card.rb

class Card
  attr_accessor :costume, :color
  def initialize(costume, color)
    @costume = costume; @color = color
  end
  def to_s
    @color.to_s
  end
end
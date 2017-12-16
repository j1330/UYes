#card.rb
require_relative "rule"
class Card
  attr_accessor :costume, :color
  def initialize(costume, color)
    @costume = costume; @color = color
  end
  def to_s
    Rule::COLOR_NAMES[@color]
  end
end
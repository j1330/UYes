#card.rb
require_relative "rule"
class Card
  attr_accessor :costume, :color
  def initialize(costume, color)
    @costume = costume; @color = color
  end
  def to_s
    # コンソールに色をつけて表示する
    "\e[#{Rule::COLOR_CODES[@color]}m#{Rule::COLOR_NAMES[@color]}\e[0m"
  end
end
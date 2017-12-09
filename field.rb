#field.rb
require "pp"
require_relative "number_card"
class Field
  attr_reader :open_card, :tableau, :deck
  def initialize
    colors = [:red,:blue,:green,:yellow]
    numbers = [*0..9] + [*1..9]
    @deck = colors.product(numbers).map do |color, num|
              costume = "a"#Image.load(color+num.to_s+".png")
              NumberCard.new(costume, color, num)
            end
    @tableau = []
    @deck.shuffle!
  end
  def shuffle!
    @tableau.shuffle!
  end
  def refresh
    self.shuffle!
    @deck = @tableau + @deck
    @tableau = []
  end
  def pop_cards(n)
    @deck.pop(n)
  end 
  def set_card(card)
    if @open_card
      @tableau.push(@open_card)
    end
    @open_card = card
  end
end
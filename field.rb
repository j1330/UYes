#field.rb
require "pp"
require_relative "number_card"
class Field
  attr_reader :open_card, :tableau, :deck
  def initialize
    colors = [:red,:blue,:green,:yellow]
    numbers = [*0..9]+[*1..9]
    @deck = colors.product(numbers).map do |color, num|
              costume = "a"#Image.load(color+num.to_s+".png")
              NumberCard.new(costume, color, num)
            end
  end
end

Field.new
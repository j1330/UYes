#number_card.rb
require_relative "card.rb"
class NumberCard < Card
  attr_accessor :number
  def initialize(costume, color, number)
    super(costume, color)
    @number = number
  end
end
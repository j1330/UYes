#number_card.rb
require_relative "card.rb"
class NumberCard < Card
  attr_accessor :number
  def initialize(costume, color, number)
    super(costume, color)
    @number = number
  end
  def to_s
    super.to_s + @number.to_s
  end
end
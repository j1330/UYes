require_relative "card.rb"
class Draw2Card < Card
  def to_s
    super.to_s + "d"
  end
end
require_relative "card"
class SkipCard < Card
  def to_s
    super.to_s + "S"
  end
end
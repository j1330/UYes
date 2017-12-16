require_relative "card"
class ReverseCard < Card
  def to_s
    super.to_s + "R"
  end
end
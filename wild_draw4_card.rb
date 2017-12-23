require_relative "wild_card"
class WildDraw4Card < WildCard
  def initialize(costume)
    @costume = costume; @color = nil; @display = "D"
  end
end
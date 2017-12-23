require_relative "card"
class WildCard < Card
  def initialize(costume)
    @costume = costume; @color = nil; @display = "W"
  end
  def to_s
    if @color
      super.to_s + @display
    else
      "無" + @display
    end
  end
end
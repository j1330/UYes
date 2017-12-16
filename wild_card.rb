require_relative "card"
class WildCard < Card
  def initialize(costume)
    @costume = costume; @color = nil
  end
  def to_s
    if @color
      super.to_s + "W"
    else
      "無W"
    end
  end
end
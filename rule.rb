require_relative "number_card.rb"
require_relative "wild_card.rb"
module Rule
  # 色の定義
  COLORS = [:red,:blue,:green,:yellow]
  COLOR_NAMES = {
    red: "赤",
    blue: "青",
    green: "緑",
    yellow: "黄",
    wild: "無"
  }
  # 各色0が1枚,1~9が2枚ずつ
  # 数の定義
  NUMBERS = [*0..9] + [*1..9]
  module_function
  def judge_playable_cards(open_card, cards)
    cards.map do | card |
      if card.kind_of?(WildCard)
        true
      elsif open_card.instance_of?(NumberCard) && card.instance_of?(NumberCard)
        card.number == open_card.number || card.color == open_card.color
      elsif open_card.class != card.class
        card.color == open_card.color
      else
        true
      end
    end
  end
end
# open = NumberCard.new("a",:red, 7)
# cards = [
#   NumberCard.new("a",:blue,4),
#   NumberCard.new("a",:red,5),
#   NumberCard.new("a",:green,7)
# ]
# puts Rule.judge_playable_cards(open,cards)
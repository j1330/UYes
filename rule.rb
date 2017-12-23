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
  CALLS = {
    last_one: "UYes"
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

  # 同時に出せるカードを判別
  def judge_playable_plural_cards_at_one_time(cards)
    # 引数がnil，または空の場合はfalse
    if cards.nil? || (not cards.instance_of?(Array)) || cards.empty?
      return false
    # 同時に1枚しか出さないならtrue
    elsif cards.length == 1
      return true
    # 要素のうち1つでも数字カードでない場合はfalse
    elsif cards.any? { |card| not card.instance_of? NumberCard }
      return false
    # 要素のうち1つでも数字が違う場合はfalse
    elsif cards.any? { |card| card.number != cards[0].number }
      return false
    else
      return true
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
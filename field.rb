#field.rb
require "pp"
require_relative "number_card"
class Field

  # open_card:捨て札の一番上
  # tableau:捨て札
  # deck:山札
  attr_reader :open_card, :tableau, :deck

  # 場の生成
  def initialize
    # 色と数字の組み合わせ
    @deck = Rule::COLORS.product(Rule::NUMBERS).shuffle.map do |color, num|
              costume = "a"#Image.load(color+num.to_s+".png")
              NumberCard.new(costume, color, num)
            end
    @tableau = []
  end

  # 捨て札を山札に戻す
  def refresh
    # 捨て札をシャッフル
    @tableau.shuffle!
    @deck = @tableau + @deck
    @tableau = []
  end

  # 山札からｎ枚カードを引く
  def pop_cards(n)
    @deck.pop(n)
  end 

  # 捨て札の一番上のカードを更新
  def set_open_card(card)
    if @open_card
      @tableau.push(@open_card)
    end
    @open_card = card
  end
end
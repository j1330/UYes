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
    # 色の定義
    colors = [:red,:blue,:green,:yellow]
  　# 数の定義
    # 各色0が1枚,１～９が2枚ずつ
    numbers = [*0..9] + [*1..9]
    # 色と数字の組み合わせ
    @deck = colors.product(numbers).map do |color, num|
              costume = "a"#Image.load(color+num.to_s+".png")
              NumberCard.new(costume, color, num)
            end
    @tableau = []
    @deck.shuffle!
  end

  # 捨て札をシャッフル
  def shuffle!
    @tableau.shuffle!
  end

  # 捨て札を山札に戻す
  def refresh
    self.shuffle!
    @deck = @tableau + @deck
    @tableau = []
  end

  # 山札からｎ枚カードを引く
  def pop_cards(n)
    @deck.pop(n)
  end 

  # 捨て札の一番上のカードを更新
  def set_card(card)
    if @open_card
      @tableau.push(@open_card)
    end
    @open_card = card
  end
end
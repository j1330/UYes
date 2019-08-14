#field.rb
require "pp"
require_relative "number_card"
require_relative "draw2_card"
require_relative "skip_card"
require_relative "reverse_card"
require_relative "wild_card"
require_relative "Wild_draw4_card"
class Field

  # open_card:捨て札の一番上
  # tableau:捨て札
  # deck:山札
  attr_reader :open_card, :tableau, :deck

  # 場の生成
  def initialize
    # 色と数字の組み合わせ
    @deck = Rule::COLORS.product(Rule::NUMBERS).map do | color, num |
              costume = "a"#Image.load(color+num.to_s+".png")
              NumberCard.new(costume, color, num)
            end
    @deck +=  Rule::COLORS.map do | color |
                [
                  Array.new(2){Draw2Card.new("a",color)},
                  Array.new(2){SkipCard.new("a",color)},
                  Array.new(2){ReverseCard.new("a",color)}
                ]
              end.flatten
    @deck += Array.new(4){WildCard.new("a")}
    @deck += Array.new(4){WildDraw4Card.new("a")}
    @deck.shuffle!
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
  def set_open_cards(cards)
    if @open_card
      if @open_card.kind_of?(WildCard)
        @open_card.color = nil
      end
      # 捨て札の一番上を捨て札に入れる
      @tableau.push(@open_card)
    end
    # 捨て札の一番上を，出したカードの一番上（最後）のカードにする
    @open_card = cards[-1]
    # 出したカードの一番上以外を捨て札に入れる
    @tableau.push *cards[1..-2]
  end
end
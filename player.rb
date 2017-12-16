#player.rb
require_relative "rule"
require_relative "field"
class Player

  # cards:手札
  attr_accessor :cards
  def initialize(field)
    @field = field
    @cards = []
  end

  # 山札からn枚カードを引く
  # field:場
  # n:山札から引いてくるカードの数
  def draw(n)
    @cards += @field.pop_cards(n)
  end

  # カードを選ぶ
  def choose_card
    if @field.open_card.nil?
      playable_cards = @cards.map {true}
    else
      playable_cards = Rule.judge_playable_cards(@field.open_card, cards)
    end
    if playable_cards.any?
      loop do
        n = gets.chomp.to_i - 1
        if n >= 0 && n < playable_cards.length && playable_cards[n]
          break n
        end
      end
    else
      nil
    end
  end

  # 手札からカードを捨てる
  def out_card
    card_id = choose_card
    if card_id
      @cards.delete_at(card_id)
    else
      self.draw(1)
      if Rule.judge_playable_cards(@field.open_card, [@cards[-1]])[0]
        @cards.delete_at(-1)
      else
        nil
      end
    end
  end

  def to_s
    @cards.inject("") do | str, card |
      str + card.to_s + " "
    end
  end
end
# require "pp"
# field = Field.new
# player = Player.new(field)
# card = NumberCard.new("a",:green,1)
# field.set_open_card(card)
# player.cards = [
#   NumberCard.new("a",:blue,4),
#   NumberCard.new("a",:red,5),
#   #NumberCard.new("a",:green,7)
# ]
# #p player.choose_card
# puts player.out_card
# puts player


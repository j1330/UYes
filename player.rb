#player.rb
class Player

  # cards:手札
  attr_accessor :cards
  def initialize
    @cards = []
  end

  # 山札からn枚カードを引く　
  # field:場
　# n:山札から引いてくるカードの数
  def draw(field, n)
    @cards += field.pop_cards(n)
  end
　
  # カードを選ぶ
  def choose_card
    n = gets.chomp.to_i
    n-1
  end

  # 手札からカードを捨てる
  def out_card
    card_id = choose_card
    @cards.delete_at(card_id)
  end
end
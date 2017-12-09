#player.rb
class Player
  attr_accessor :cards
  def initialize
    @cards = []
  end
  def draw(deck, n)
    @cards += deck.pop(n)
  end
  def choose_card
    n = gets.chomp.to_i
    n-1
  end
  def out_card
    card_id = choose_card
    @cards.delete_at(card_id)
  end
end
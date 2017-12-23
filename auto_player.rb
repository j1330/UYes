#player.rb
require_relative "rule"
require_relative "field"
require_relative "player"
class AutoPlayer < Player
  # カードを選ぶ
  def choose_cards
    if @field.open_card.nil?
      playable_cards = @cards.map {true}
    else
      playable_cards = Rule.judge_playable_cards(@field.open_card, cards)
    end
    if @cards.length == 2
      @call = (rand(4) == 0) ? "" : Rule::CALLS[:last_one]
      puts @call
    end
    card_id = playable_cards.map.with_index { |playable_card, i|
      playable_card ? i : nil
    }.compact.sample
    return card_id.nil? ? [] : [card_id]
  end

  def choose_color
    Rule::COLORS.sample
  end
end
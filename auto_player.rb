#player.rb
require_relative "rule"
require_relative "field"
require_relative "player"
class AutoPlayer < Player
  # カードを選ぶ
  def choose_card
    if @field.open_card.nil?
      playable_cards = @cards.map {true}
    else
      playable_cards = Rule.judge_playable_cards(@field.open_card, cards)
    end
    playable_cards.map.with_index {| playable_card, i | 
      playable_card ? i : nil
    }.compact.sample
  end

  def choose_color
    Rule::COLORS.sample
  end
end
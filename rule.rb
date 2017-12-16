require_relative "number_card.rb"
module Rule
  module_function
  def judge_playable_cards(open_card, cards)
    cards.map do | card |
      if open_card.instance_of?(NumberCard)
        card.number == open_card.number || card.color == open_card.color
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

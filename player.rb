#player.rb
require_relative "rule"
require_relative "field"
class Player

  # cards:手札
  attr_accessor :cards, :call
  def initialize(field)
    @field = field
    @cards = []
    @call = nil
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
        # 標準入力からカードと宣言を入力
        input = gets.split.compact
        # 入力のうち，Ruleで定義されているものがあれば抽出
        calls = input.select do |str|
          Rule::CALLS.values.include? str
        end
        # 宣言は"UYes"ひとつしかないので最初の要素をインスタンス変数に入れる
        @call = calls.empty? ? '' : calls[0]
        # 入力のうち，場に出せる数字を抽出
        card_ids = input.map { |str|
          str.to_i - 1
        }.select { |i|
          i >= 0 && i < playable_cards.length && playable_cards[i]
        }.uniq
        # 選べる手の最初のものを返す．ダメだったらやりなおし
        unless card_ids.empty?
          break card_ids[0]
        end
        puts "選べない手です"
      end
    else
      nil
    end
  end

  # 手札からカードを捨てる
  def out_card
    card_id = choose_card
    if card_id
      card = @cards.delete_at(card_id)
      if card.kind_of?(WildCard)
        card.color = self.choose_color
      end
      return card
    else
      self.draw(1)
      if Rule.judge_playable_cards(@field.open_card, [@cards[-1]])[0]
        card =  @cards.delete_at(-1)
        if card.kind_of?(WildCard)
          card.color = self.choose_color
        end
        return card
      else
        puts "パス(泣)"
        nil
      end
    end
  end

  def to_s
    row1 = @cards.inject("") do | str, card |
      str + card.to_s + " "
    end
    row2 = @cards.each_with_index.inject("") do | str, (card, i) |
      str + "----"
    end
    row3 = @cards.each_with_index.inject("") do | str, (card, i) |
      str + " #{i+1}  "
    end
    row3 + "\n" + row2 + "\n" + row1
  end

  def choose_color
    loop do
      puts "1:赤 2:青 3:緑 4:黄"
      n = gets.chomp.to_i - 1
      if n >= 0 && n < 4
        break Rule::COLORS[n]
      end
      puts "もう一度入力してください"
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
#   NumberCard.new("a",:green,7)
# ]
# p player.choose_card
# puts player.out_card
# puts player.call
# puts player
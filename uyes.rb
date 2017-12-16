#uyes.rb
require_relative "player"
require_relative "auto_player"
require_relative "field"
class Uyes

  # players:プレイヤー
  # turn_player_id:手番のプレイヤーのインデックス
  # field:場
  attr_accessor :players, :turn_player_id, :field

  # ゲームの生成
  def initialize
    @field = Field.new
    @players = [Player.new(@field)]
    @players += Array.new(3){AutoPlayer.new(@field)}
    @turn_player_id = 0
    @players.each do | player |
      player.draw(7)
    end
    @rotation = :right
  end
  def start
    loop do
      puts "\n#{@turn_player_id+1}番目"
      if @field.deck.length < 5
        @field.refresh
      end
      puts "オープンカード:#{@field.open_card}"
      puts @players[@turn_player_id]
      card = @players[@turn_player_id].out_card
      if @players[@turn_player_id].cards.length == 0
        puts "#{@turn_player_id+1}番目のプレイヤー:勝ち"
        break
      end
      if card
        if card.instance_of?(Draw2Card)
          @turn_player_id = self.next_player_id(1)
          @players[@turn_player_id].draw(2)
        elsif card.instance_of?(SkipCard)
          @turn_player_id = self.next_player_id(2)
        else
          @turn_player_id = self.next_player_id(1)
        end
        @field.set_open_card(card)
        puts "選んだカード:#{card}"
      else
        @turn_player_id = self.next_player_id(1)
      end
      gets
    end
  end
  def next_player_id(step)
    if @rotation == :right
      (@turn_player_id + step) % 4
    else
      (@turn_player_id - step + 4) % 4
    end
  end
end
game = Uyes.new
game.start
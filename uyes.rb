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
  end
  def start
    loop do
      puts "#{@turn_player_id+1}番目"
      if @field.deck.length < 5
        @field.refresh
      end
      puts @field.open_card
      puts @players[@turn_player_id]
      card = @players[@turn_player_id].out_card
      if @players[@turn_player_id].cards.length == 0
        puts "#{@turn_player_id+1}番目のプレイヤー:勝ち"
        break
      end
      @turn_player_id = (@turn_player_id + 1) % 4
      if card
        if card.instance_of?(Draw2Card)
          @players[@turn_player_id].draw(2)
        end
        @field.set_open_card(card)
      end
    end
  end
end
game = Uyes.new
game.start
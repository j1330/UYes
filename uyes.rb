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
      cards = @players[@turn_player_id].out_cards
      if @players[@turn_player_id].cards.length == 1 && @players[@turn_player_id].call != Rule::CALLS[:last_one]
        @players[@turn_player_id].draw(2)
        puts "#{@turn_player_id+1}番プレイヤーはUYesと言っていません"
        puts "2枚ドロー"
      end
      if @players[@turn_player_id].cards.length == 0
        puts "#{@turn_player_id+1}番目のプレイヤー:勝ち"
        break
      end
      # カードが出されていないとき次のターンプレイヤーへ
      if cards.nil? || cards.empty?
        @turn_player_id = self.next_player_id(1)
        gets
        next
      end
      # カードが1枚出されたときは特殊カードの可能性があるので，特殊カードの処理を行う
      if cards.length == 1
        card = cards[0]
        if card.instance_of?(Draw2Card)
          @turn_player_id = self.next_player_id(1)
          @players[@turn_player_id].draw(2)
        elsif card.instance_of?(SkipCard)
          @turn_player_id = self.next_player_id(2)
        elsif card.instance_of?(ReverseCard)
          @rotation = (@rotation == :left) ? :right : :left
          @turn_player_id = self.next_player_id(1)
        elsif card.instance_of?(WildDraw4Card)
          @turn_player_id = self.next_player_id(1)
          @players[@turn_player_id].draw(4)
        else
          @turn_player_id = self.next_player_id(1)
        end
      else
        @turn_player_id = self.next_player_id(1)
      end
      # 場にカードを出す
      @field.set_open_cards(cards)
      # 選んだカードを表示する
      puts "選んだカード:#{cards.map(&:to_s).join ' '}"
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
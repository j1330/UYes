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
    @players = [ Player.new(@field,"あなた") ]
    @players += Array.new(3) do |index|
      AutoPlayer.new(@field, "CPU #{index}")
    end
  end

  # 全体ゲームの開始
  # (n回ゲームを行い総得点を競う)
  def start
    puts "[ゲームの回数を入力してください] :"

    @game_max = loop do
      n = gets.chomp.to_i
      if n > 0
        puts "ゲームは#{n}回行われます"
        break n
      end
      puts "1以上の数字を入力してください"
    end

    @game_max.times do |game_count|
      puts "\n[第#{game_count+1}ゲームを開始します...]"

      do_game

      # 現在の総得点の計算
      @players.each {|player| player.total_score += player.score }

      # 得点を表示する
      puts "\n#{'='*10} 第#{game_count+1}ゲームの得点 #{'='*10}"
      display_players_score
    end

    # 最終的な勝利者
    winner = @players.min {|p1,p2| p1.total_score <=> p2.total_score }
    puts "\n#{winner.name} の総合優勝です!\n"
  end

  # 1回ごとのゲームを行う
  def do_game
    @players.each do | player |
      # 手札を空にして、7枚 配る
      player.cards.clear
      player.draw(7)
    end
    @field.refresh
    @turn_player_id = 0
    @rotation = :right

    loop do
      puts "\n[#{@players[@turn_player_id].name} の順番です...]"
      if @field.deck.length < 5
        @field.refresh
      end
      puts "オープンカード:#{@field.open_card}"
      puts @players[@turn_player_id]
      card = @players[@turn_player_id].out_card
      if @players[@turn_player_id].cards.length == 1 && @players[@turn_player_id].call != Rule::CALLS[:last_one]
        @players[@turn_player_id].draw(2)
        puts "#{@players[@turn_player_id].name} はUYesと言っていません"
        puts "2枚ドロー"
      end
      if @players[@turn_player_id].cards.length == 0
        puts "#{@players[@turn_player_id].name} の勝ち"
        break
      end
      if card
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

  # 各プレイヤーの現在のゲームの得点と総得点を表示する
  def display_players_score
    @players.each do |player|
      puts "#{player.name}\tこのゲームの得点: #{player.score}\t総得点: #{player.total_score}"
    end
  end
end
game = Uyes.new
game.start
#uyes.rb
require_relative "player"
require_relative "field"
class Uyes

  # players:プレイヤー
　# turn_player_id:手番のプレイヤーのインデックス
　# field:場
  attr_accessor :players, :turn_player_id, :field

  # ゲームの生成
  def initialize
    @players = Array.new(4) {Player.new}
    @field = Field.new
    @turn_player_id = 0
  end
end
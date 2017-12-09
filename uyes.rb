#uyes.rb
require_relative "player"
require_relative "field"
class Uyes
  attr_accessor :players, :turn_player_id, :field
  def initialize
    @players = Array.new(4) {Player.new}
    @field = Field.new
    @turn_player_id = 0
  end
end
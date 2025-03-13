require './base_player.rb'

class YourPlayer < BasePlayer
  def initialize(game:, name:)
    super(game:, name:)
    @current_position = nil
    @visited = {}
  end

  def next_point(time:)
    if @current_position.nil?
      @current_position = { row: 0, col: 0 }
      @visited[@current_position] = true
      return @current_position
    end

    next_move = find_next_unvisited_point
    @visited[@current_position] = true
    @current_position = next_move
    next_move
  end

  def grid
    game.grid
  end

  private

  def find_next_unvisited_point
    max_row = grid.max_row
    max_col = grid.max_col
  
    (0..max_row).each do |row|
      cols = row.even? ? (0..max_col) : (0..max_col).to_a.reverse
      cols.each do |col|
        point = { row: row, col: col }
        return point if !@visited[point] && grid.is_valid_move?(from: @current_position, to: point)
      end
    end
  
    # If all points are visited, return the current position
    @current_position
  end
end

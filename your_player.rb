require './base_player.rb'

class YourPlayer < BasePlayer
  # Class variable to keep track of visited points across all instances
  @@shared_visited = {}

  def initialize(game:, name:)
    super(game:, name:)
    @current_position = nil
  end

  def next_point(time:)
    if @current_position.nil?
      @current_position = { row: 0, col: 0 }
      visit(@current_position)
      return @current_position
    end

    next_move = find_next_unvisited_point
    visit(next_move)
    @current_position = next_move
    next_move
  end

  def grid
    game.grid
  end

  private

  def visit(point)
    @@shared_visited[point] = true
  end

  def visited?(point)
    @@shared_visited[point]
  end

  def find_next_unvisited_point
    max_row = grid.max_row
    max_col = grid.max_col
  
    (0..max_row).each do |row|
      # Determine the order of columns to iterate through
      # If the row is even, iterate from left to right
      # If the row is odd, iterate from right to left
      cols = row.even? ? (0..max_col) : (0..max_col).to_a.reverse
      cols.each do |col|
        point = { row: row, col: col }

        # Check if the point has not been visited and is a valid move
        # If so, return this point as the next move
        return point if !visited?(point) && grid.is_valid_move?(from: @current_position, to: point)
      end
    end
  
    # If all points are visited, return the current position
    @current_position
  end
end

# frozen_string_literal: true

require_relative './point'

class Stage
  attr_reader :width, :height, :pos, :min_x, :max_x, :min_y, :max_y

  def initialize(x, y, width, height, edge_distance)
    @pos = Point.new(x, y)
    @width = width
    @height = height
    @min_x = x + edge_distance
    @max_x = x + width - edge_distance
    @min_y = y + edge_distance
    @max_y = y + height - edge_distance
  end
end

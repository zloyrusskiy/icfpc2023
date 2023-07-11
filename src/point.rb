# frozen_string_literal: true

require_relative 'distance'

class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x.round.to_f
    @y = y.round.to_f
  end

  def transposed
    Point.new(@y, @x)
  end

  def distance_to(p2)
    Distance.new(self, p2)
  end
end


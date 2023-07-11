# frozen_string_literal: true

class Distance
  attr_reader :sq_value

  def initialize(p1, p2)
    @sq_value = (p2.x - p1.x) ** 2 + (p2.y - p1.y) ** 2
  end

  def value
    @value ||= Math.sqrt(sq_value)
  end
end

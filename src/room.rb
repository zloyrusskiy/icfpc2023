# frozen_string_literal: true

class Room
  attr_reader :width, :height, :stage

  def initialize(width, height, stage)
    @width = width
    @height = height
    @stage = stage
  end
end

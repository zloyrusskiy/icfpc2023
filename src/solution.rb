# frozen_string_literal: true

class Solution
  attr_reader :placements, :volumes

  def initialize(placements, volumes)
    @placements = placements
    @volumes = volumes || placements.map { 1.0 }
  end
end

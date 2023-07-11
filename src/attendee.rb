# frozen_string_literal: true

class Attendee
  attr_reader :pos, :tastes

  def initialize(pos, tastes)
    @pos = pos
    @tastes = tastes
  end
end

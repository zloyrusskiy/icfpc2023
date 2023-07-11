# frozen_string_literal: true

class PlacedMusician
  attr_reader :pos, :instrument_index, :volume

  def initialize(pos, instrument_index, volume)
    @pos = pos
    @instrument_index = instrument_index
    @volume = volume
  end
end

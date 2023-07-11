# frozen_string_literal: true

require 'json'
require_relative 'constants'
require_relative 'solution'
require_relative 'stage'
require_relative 'room'
require_relative 'attendee'

class Parser
  class << self
    def parse_problem(input)
      parsed = JSON.parse(input, symbolize_names: true)
      # place musicians
      room_width = parsed[:room_width]
      room_height = parsed[:room_height]
      stage_width = parsed[:stage_width]
      stage_height = parsed[:stage_height]
      stage_bottom_left_x, stage_bottom_left_y = parsed[:stage_bottom_left]

      stage = Stage.new(stage_bottom_left_x, stage_bottom_left_y, stage_width, stage_height, Constants::MUSICIANS_MIN_RADIUS)
      room = Room.new(room_width, room_height, stage)

      musicians = parsed[:musicians]

      attendees = parsed[:attendees].map { |a| Attendee.new(Point.new(a[:x], a[:y]), a[:tastes])}

      [room, musicians, attendees]
    end

    def parse_solution(input)
      parsed = JSON.parse(input, symbolize_names: true)

      placements = parsed[:placements].map { |pl| Point.new(pl[:x], pl[:y])}

      volumes = parsed[:volumes]

      Solution.new(placements, volumes)
    end
  end
end

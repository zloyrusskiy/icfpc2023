# frozen_string_literal: true

require_relative 'constants'
require_relative 'placed_musician'

class Scoring
  class << self
    def calc(room, musician_instruments, attendees, solution)
      placed_musicians = solution.placements
                                 .zip(musician_instruments, solution.volumes)
                                 .map { |arg| PlacedMusician.new(*arg) }

      attendee_to_musicians = attendees.map do |attendee|
        sorted_musicians = placed_musicians.sort_by { |m| attendee.pos.distance_to(m.pos).sq_value }

        (0..(sorted_musicians.size - 1)).reject { |far_musician_ind|
          (0..(far_musician_ind - 1)).any? { |close_musician_ind|
            calc_is_musician_blocks(attendee.pos, sorted_musicians[far_musician_ind].pos, sorted_musicians[close_musician_ind].pos)
          }
        }
                                        .map { |ind| [attendee, sorted_musicians[ind]] }
      end
                                       .flatten(1)

      attendee_to_musicians
        .map { |(at, mus)| calc_impact(at, mus) }
        .sum

      # v1 pillars
      # v2 playing together
      # v3 volumes
    end

    private

    BLOCK_RADIUS_POW_2 = Constants::MUSICIAN_BLOCK_RADIUS ** 2

    def calc_is_musician_blocks(at_pos, mf_pos, mc_pos)
      if at_pos.x == mf_pos.x
        return calc_is_musician_blocks(at_pos.transposed, mf_pos.transposed, mc_pos.transposed)
      end

      m = (mf_pos.y - at_pos.y) / (mf_pos.x - at_pos.x)
      b = at_pos.y - m * at_pos.x
      d = (2 * (m * b - m * mc_pos.y - mc_pos.x)) ** 2 -
        4 * (m ** 2 + 1) * (mc_pos.y ** 2 - BLOCK_RADIUS_POW_2 + mc_pos.x ** 2 - 2 * b * mc_pos.y + b ** 2)

      d > 0
    end

    def calc_impact(attendee, placed_musician)
      (1_000_000.0 * attendee.tastes[placed_musician.instrument_index] / attendee.pos.distance_to(placed_musician.pos).sq_value).ceil
    end
  end
end

class Room < ApplicationRecord
  filterrific(
    available_filters: [
      :with_name,
      :with_type,
      :nop,
      :ratings
    ]
  )

  scope :with_name, lambda { |name|
    where(game: [*name])
  }

  scope :with_type, lambda { |game_types|
    where(game_type: [*game_types])
  }

  scope :nop, lambda { |nop|
    where(number_of_players: [*nop])
  }

  scope :ratings, lambda { |ratings|
    where(ratings: [*ratings])
  }

  def self.options_for_with_type
    ["Single-player", "Multiplayer", "First-person", "Third-person", "RPG", "Adventure", "Horror", " Shooting", "Puzzle", "Combat"]
  end

  def self.options_for_nop
    (1..10)
  end

  def self.options_for_ratings
    (0..5)
  end

end

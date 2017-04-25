# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "faker"

game_types = ["Single-player", "Multiplayer", "First-person", "Third-person", "RPG", "Adventure", "Horror", " Shooting", "Puzzle", "Combat"]

ActiveRecord::Base.transaction do
  30.times do
    five = rand(0..5)
    Room.create(game: Faker::Superhero.name, game_type: game_types.sample, number_of_players: rand(1..10), ratings: five)
  end
end

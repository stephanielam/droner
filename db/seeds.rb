# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


10.times do
  Robot.create(name:Faker::Name.name, model:Faker::Lorem.characters(5), price:Faker::Commerce.price)
end

10.times do
  Rental.create(robot_id: Faker::Number.between(1, 10), client_id: Faker::Number.between(1, 10))
end

10.times do
  Client.create(username: Faker::Lorem.word, password: Faker::Lorem.word)
end
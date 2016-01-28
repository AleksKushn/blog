# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "admin",
             email: "admin@example.org",
             password_digest: "admin",
             password_confirmation: "admin")
99.times do |n|
  name  = Faker::Name.name
  email = "user-#{n+1}@example.org"
  password  = "password"
  User.create!(name: name,
               email: email,
               password_digest: password,
               password_confirmation: password)
end

5000.times do |i|
  author_id = rand(100) + 1
  date = Faker::Date.between(32.days.ago, 6.days.ago )
  title = Faker::Lorem.sentence
  content = Faker::Lorem.paragraph
  Post.create!(author_id: author_id,
               date: date,
               title: title,
               content: content)
end

10000.times do |j|
  post_id = rand(5000) +1
  author_id = rand(100) + 1
  date = Faker::Date.between(6.days.ago, Date.today )
  content = Faker::Lorem.paragraph
  Comment.create!(post_id: post_id,
                  author_id: author_id,
                  date: date,
                  content: content)
end

500.times do |k|
  post_id = rand(500) + 1
  name = Faker::Hacker.noun
  Tag.create!(post_id: post_id,
              name: name)
end


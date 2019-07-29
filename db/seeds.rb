# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
# User.create({email: 'nbarnes@gmail.com', password: 'password', admin: true}).save!
tags = Array.new(20) { Faker::Verb.ing_form }
users = Array.new(20) { User.create({ email: Faker::Internet.email, password: 'password' }) }
entries = Array.new(80) do
  e = Entry.create({ 
    title: Faker::Book.title,
    description: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraphs(2).join("\n\n"),
    notes: Faker::Lorem.sentences.join("\n\n"),
    tag_list: tags.sample(3).join(' ')
  })
  e.user = users.sample
  e.save!
  e
end
projects = Array.new(20) do
  p = Project.create({ title: Faker::Coffee.blend_name, description: Faker::Lorem.sentence, owner: users.sample })
  p.users << users.sample(3)
  p.entries << entries.sample(5)
  p.save!
  p
end
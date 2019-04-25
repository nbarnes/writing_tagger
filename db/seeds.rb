# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

tags = Array.new(20) { Faker::Verb.ing_form }
users = Array.new(20) { User.create({ email: Faker::Internet.email, password: 'password' }) }
entries = Array.new(80) do
  e = Entry.create({ 
    title: Faker::Book.title,
    description: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph(2),
    notes: Faker::Lorem.sentences.join('\n\n'),
    tag_list: tags.sample(3).join(' ')
  })
  e.user = users.sample
  e.save!
end

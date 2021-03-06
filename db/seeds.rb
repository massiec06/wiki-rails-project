users = []
10.times do
  users << User.create!(
    email: Faker::Internet.email,
    password: '12345678',
    password_confirmation: '12345678'
  )
end
users = User.all

  # Create Wikis
50.times do
  Wiki.create!(
    title: Faker::Beer.name,
    body: Faker::ChuckNorris.fact,
    user: users.sample
  )
end
wiki = Wiki.all

admin = User.create!(
  email:    'admin@test.com',
  password: '123456',
  role:     'admin'
)

premium = User.create!(
  email:    'premium@test.com',
  password: '123456',
  role:     'premium'
)

standard = User.create!(
  email:    'standard@test.com',
  password: '123456'
)

puts "Seed finished"
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"

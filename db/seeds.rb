require 'random_data'

  # Create Wikis
  50.times do
    Wiki.create!(
      title:  RandomData.random_sentence,
      body:   RandomData.random_paragraph
    )
  end
  wiki = Wiki.all

  puts "Seed finished"
  puts "#{Wiki.count} wikis created"

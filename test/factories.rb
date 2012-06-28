Factory.define( :book_review ) do |br|
  br.title { Faker::Lorem.words(3) }
  br.rating "+5 Awesome"
  br.cover_image "stringrandom.jpg"
  br.book_title { Faker::Lorem.words(3) }
  br.book_author { Faker::Name.name }
  br.book_link "http://www.amazon.com/book/link"
  
  br.summary { Faker::Lorem.paragraph(5) }
  br.review { Faker::Lorem.paragraph(5) }
end

Factory.define( :story ) do |s|
  s.title { Faker::Lorem.words(3) }
  s.teaser { Faker::Lorem.sentence }
  s.body { Faker::Lorem.paragraphs(10) }
  s.status "???"
  s.published true
  s.author_notes "These are notes."
  s.author { Factory(:author) }
end

Factory.define( :author ) do |a|
  a.name { Faker::Name.name }
  a.short_bio { Faker::Lorem.sentence }
  a.long_bio { Faker::Lorem.paragraph(3) }
  a.email { Faker::Internet.email }
end
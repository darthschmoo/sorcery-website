require 'factory_girl'

FactoryGirl.define do
  factory :author do
    name      { Faker::Name.name }
    short_bio { Faker::Lorem.sentence }
    long_bio  { Faker::Lorem.paragraph(3) }
    email     { Faker::Internet.email }
    password  "password"
    password_confirmation "password"
  end
    
  factory :book_review do
    title       { Faker::Lorem.sentence }
    rating      "+5 Awesome"
    cover_image "stringrandom.jpg"
    book_title  { Faker::Lorem.sentence }
    book_author { Faker::Name.name }
    book_link   "http://www.amazon.com/book/link"
    summary     { Faker::Lorem.paragraph(5) }
    review      { Faker::Lorem.paragraph(5) }
  end

  factory :page do
    
  end

  factory :story do
    title     { Faker::Lorem.sentence }
    teaser    { Faker::Lorem.sentence }
    body      { Faker::Lorem.paragraphs(10) }
    status    "???"
    published true
    author_notes "These are notes."
    author    { Factory(:author) }
  end
end
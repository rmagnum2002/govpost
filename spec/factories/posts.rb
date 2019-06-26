FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph(13) }
    user { User.all.sample }
    social_network { nil }
    external_link { Faker::Internet.url("www.#{social_network.name}.com") }
  end
end

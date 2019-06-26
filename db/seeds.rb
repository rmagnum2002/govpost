puts 'Starting seed db'

%w[facebook twitter].each do |network|
  SocialNetwork.create(name: network)
end

10.times do
  Listing.create(name: Faker::Team.name)
end

100.times do
  user = User.create(full_name: Faker::Name.name)
  UserListing.create(listing: Listing.all.sample, user: user)
end

100_000.times do
  sn = SocialNetwork.where(name: %w[facebook twitter]).sample
  Post.create(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph(13),
    user: User.all.sample,
    social_network: sn,
    external_link: Faker::Internet.url("www.#{sn.name}.com")
  )
end

User.all.each do |user|
  UserListing.find_or_create_by(listing: Listing.all.sample, user: user)
end
puts 'Db seed ended'

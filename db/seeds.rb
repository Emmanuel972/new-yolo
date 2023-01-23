puts "Cleaning database ..."

Review.destroy_all
Post.destroy_all
User.destroy_all

puts "Database cleaned !"

puts "Creating users ..."

anonymous = { email: "test@test.com", password: "123456", username: "Trolololol"}

params = [anonymous]

params.each do |param|
  user = User.new(param)
  user.save
  puts "User #{user.username} created !"
end

puts "Users created !"

puts "Creating posts ..."

5.times do
  post = Post.new(
    {
      title: Faker::Games::LeagueOfLegends.champion,
      content: "#{Faker::Games::LeagueOfLegends.rank} use #{Faker::Games::LeagueOfLegends.summoner_spell} and say #{Faker::Games::LeagueOfLegends.quote}"
    }
  )
  post.user = User.find(1)
  post.save
  puts "Post #{post.title} created !"

  puts "Add reviews to #{post.title}"
  5.times do
    review = Review.new(
      {
        rating: rand(1..5),
        content: Faker::Games::LeagueOfLegends.location
      }
    )
    review.user = User.find(1)
    review.post = post
    review.save
  end

  puts "Review for #{post.title} created !"
end

puts "Posts and reviews created !"

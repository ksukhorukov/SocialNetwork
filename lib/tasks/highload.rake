require 'parallel'

namespace :db do
  desc "Emulation of heavy load on database"
  task highload: :environment do

	Parallel.each(1..User.count, :in_processes => 100) do |i|
		(1..1000).each do |j|
			user1 = User.offset(rand(User.count)).first
			user2 = User.offset(rand(User.count)).first
			#make a post
			content = Faker::Lorem.sentence(5)
			micropost = user1.microposts.create!(content: content)
			Activity.create(category: 0, micropost_id: micropost.id, user_id: user1.id)
			#follow another user
            relationship = user1.follow!(user2)
            if relationship
              Activity.create(category: 2, relationship_id: relationship.id, user_id: user1.id)
            end
            #like some random post of another user
            micropost = user2.microposts.offset(rand(user2.microposts.count)).first
            like = user1.likes.find_by_micropost_id(micropost.id)
            unless(like)
				like = user1.likes.create(micropost_id: micropost.id)
				Activity.create(category: 1, like_id: like.id, user_id: user1.id)
			end
		end
	end

  end

end

class Like < ActiveRecord::Base
	belongs_to :user
	belongs_to :micropost

	has_one :activity

	def like!(post, user)
		create!(micropost_id: post.id, user_id: user.id)
	end

	def unlike!(post, user)
		find_by(micropost_id: post.id, user_id: user.id).destroy!
	end
end

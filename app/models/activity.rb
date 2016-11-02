class Activity < ActiveRecord::Base

	belongs_to :user
	belongs_to :like
	belongs_to :micropost
	belongs_to :relationship

	enum category: [:post, :like, :friendship] #0,1,2

  default_scope -> { order('activities.created_at DESC') }

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id).distinct
    #select distinct * from microposts where user_id in (select followed_id from relationships where follower_id = 4) or user_id = 4 or id in (select micropost_id from likes where user_id = 4);
    # select * from microposts where id in (select micropost_id from likes where user_id = 4);
  end

end

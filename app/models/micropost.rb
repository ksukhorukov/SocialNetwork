class Micropost < ActiveRecord::Base

  belongs_to :user
  has_many :likes

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  default_scope -> { order('microposts.created_at DESC') }

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id OR id IN (SELECT micropost_id FROM likes WHERE user_id = :user_id)",
          user_id: user.id)
    #select distinct * from microposts where user_id in (select followed_id from relationships where follower_id = 4) or user_id = 4 or id in (select micropost_id from likes where user_id = 4);
    # select * from microposts where id in (select micropost_id from likes where user_id = 4);
  end

  def liked?(user)
    likes.find_by_user_id(user.id)
  end
  
end

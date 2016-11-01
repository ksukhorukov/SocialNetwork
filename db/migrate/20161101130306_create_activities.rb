class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :category #enum of type
      t.integer :user_id
  	  t.integer :micropost_id # user posted something. 
  	  t.integer :relationship_id # user started to follow somebody. 
  	  t.integer :like_id # user liked something.
      t.timestamps
    end
  end
end


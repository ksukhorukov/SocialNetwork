class LikesController < ApplicationController
	before_filter :signed_in_user

	respond_to :html, :js

	def create
		#byebug
		like = current_user.likes.create(micropost_id: params[:like][:micropost_id])
		Activity.create(category: 1, like_id: like.id, user_id: current_user.id)
		redirect_to root_path
	end

	def destroy
		like = Like.find_by_id(params[:id]).destroy!
		like.activity.destroy!
		redirect_to root_path
	end

end

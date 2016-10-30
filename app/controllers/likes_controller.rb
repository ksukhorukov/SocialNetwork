class LikesController < ApplicationController
	before_filter :signed_in_user

	respond_to :html, :js

	def create
		#byebug
		current_user.likes.create(micropost_id: params[:like][:micropost_id])
		redirect_to root_path
	end

	def destroy
		Like.find_by_id(params[:id]).destroy!
		redirect_to root_path
	end

end

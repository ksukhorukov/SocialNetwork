class FeedController < ApplicationController

	def show
		@feed_items = User.find_by_id(params[:id]).feed.paginate(page: params[:page])
	end
end

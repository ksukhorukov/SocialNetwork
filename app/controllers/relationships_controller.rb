class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  respond_to :html, :js

  def create
    @user = User.find(params[:relationship][:followed_id])
    relatioship = current_user.follow!(@user)
    Activity.create(category: 2, relationship_id: relatioship.id, user_id: current_user.id)
    respond_with @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    relationship = current_user.unfollow!(@user)
    relationship.activity.destroy!
    respond_with @user
  end
end
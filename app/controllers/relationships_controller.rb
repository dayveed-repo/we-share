class RelationshipsController < ApplicationController
  after_action :check_followers

  def follow
    @rel = Relationship.find_by(followed_id: params[:id], follower_id: current_user.id)
    
    if @rel
      @rel.destroy
      ActionCable.server.broadcast("LikeChannel", {text: "follow", followers: User.find(params[:id]).followers.count, following: User.find(params[:id]).following.count})
    else
      @new_rel = Relationship.new(follower_id: current_user.id, followed_id: params[:id])
      @new_rel.save

      ActionCable.server.broadcast("LikeChannel", {text: "unfollow", followers: User.find(params[:id]).followers.count, following: User.find(params[:id]).following.count})
    end
  end

end

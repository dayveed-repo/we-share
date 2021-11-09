class RelationshipsController < ApplicationController
  def create
    @rel = Relationship.new(follower_id: current_user.id, followed_id: params[:user_id])

    if @rel.save
      flash[:notice] = "you just followed #{User.find(params[:user_id]).username}"
    end
  end

  def destroy
    @rel = Relationship.find_by(followed_id: params[:user_id], follower_id: current_user.id)
  
    if @rel.destroy
    end
  end
end

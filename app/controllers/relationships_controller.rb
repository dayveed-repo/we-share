class RelationshipsController < ApplicationController
  after_action :check_followers

  def follow
    @rel = Relationship.find_by(followed_id: params[:id], follower_id: current_user.id)
    
    if @rel
      @rel.destroy
    else
      @new_rel = Relationship.new(follower_id: current_user.id, followed_id: params[:id])

      @new_rel.save
    end
  end

end

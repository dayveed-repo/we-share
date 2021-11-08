class LikesController < ApplicationController
  def create
    @like = Like.new()

    if @like.save
      ActionCable.server.broadcast("LikeChannel", "i just liked")
    else
      redirect_to 'likes#destroy'
      # redirect_to url_for(:controller => :likes_controller, :action => :destroy)
    end

  end 

 
  def like
    if Tweet.find(params[:id]).likes.find_by(user_id: current_user.id)
      @like = Tweet.find(params[:id]).likes.find_by(user_id: current_user.id)

      if @like.destroy
        ActionCable.server.broadcast("LikeChannel", "i just unliked")
      end

    else
      @like = Like.new(likeable_id: params[:id], likeable_type: 'Tweet', user_id: current_user.id) 
      
      if @like.save
        ActionCable.server.broadcast("LikeChannel", "i just liked")
      end

    end

    redirect_back(fallback_location: root_url)
  end

  private

  def like_params
    params.permit(:likeable_id, :likeable_type, :user_id)
  end
end

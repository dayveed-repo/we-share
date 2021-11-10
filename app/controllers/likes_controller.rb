class LikesController < ApplicationController
  def like
    if Tweet.find(params[:id]).likes.find_by(user_id: current_user.id)
      @like = Tweet.find(params[:id]).likes.find_by(user_id: current_user.id)

      if @like.destroy
        # ActionCable.server.broadcast("LikeChannel", "i just unliked")
      end

    else
      @like = Like.new(likeable_id: params[:id], likeable_type: 'Tweet', user_id: current_user.id) 
      
      if @like.save
        @tweet = Tweet.find(@like.likeable_id)
        CommentNotification.with(tweet_info: "#{current_user.username} liked your tweet").deliver(@tweet.user)
      end

    end

    redirect_back(fallback_location: root_url)
  end

  private

  def like_params
    params.permit(:likeable_id, :likeable_type, :user_id)
  end
end

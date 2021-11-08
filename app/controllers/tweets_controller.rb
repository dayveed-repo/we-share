class TweetsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @tweets = Tweet.where(parent_id: nil)
        @at_index = true

        @users = User.where.not(id: current_user.id)
    end

    def new
        @tweet = Tweet.new
        @users = User.where.not(id: current_user.id)
    end

    def show
        @tweet = Tweet.find(params[:id])

        if params[:main_id]
            @main_id = params[:main_id]
        else
            @main_id = @tweet.id
        end

        if @tweet.parent
            @replies = @tweet.tweets.count
        else
            @replies = Tweet.where(main_id: @tweet.id).count
        end
    end

    def create
        @tweet = Tweet.new(tweet_params)
        
        if @tweet.save
            flash[:notice] = 'posted tweet successfully'
            if @tweet.parent
                redirect_to @tweet.parent
            else
                redirect_to @tweet
            end
        else
            flash[:alert] = 'failed to post tweet'
            render :new
        end
    end

    def destroy
        @tweet = Tweet.find(params[:id])

        if @tweet.destroy
            flash[:notice] = 'removed tweet successfully'
            redirect_to root_url
        else
            flash[:error] = 'failed to remove tweet'
        end
    end

    private

    def tweet_params
        params.require(:tweet).permit(:content, :user_id, :parent_id, :main_id)
    end
end

class UsersController < ApplicationController
  before_action :check_followers

  def show
    @user = User.find(params[:id])

    @tweets = @user.tweets
  end
end

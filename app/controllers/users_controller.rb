class UsersController < ApplicationController
  def show
    @user =User.find(params[:id])
    # blogs=Blog.find(params[:id])
  end
end

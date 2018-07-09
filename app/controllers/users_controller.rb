class UsersController < ApplicationController
  def show
    @user =User.find(params[:id])
    # @user.lists.each do |c|
    #   @array=c.movie_ids
    # @list=List.find()
    # blogs=Blog.find(params[:id])
  # end

  end
end

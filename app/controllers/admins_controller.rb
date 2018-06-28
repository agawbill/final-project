class AdminsController < ApplicationController
  def show
    @user =Admin.find(params[:id])
    # blogs=Blog.find(params[:id])
  end

  def new
    if !current_admin
      redirect_to "/"
    # blogs=Blog.find(params[:id])
  end
  end
end

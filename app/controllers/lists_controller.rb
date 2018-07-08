class ListsController < ApplicationController
  def index
  end

  def new
    @list=List.new
  end

  def create
    list=List.new(list_params)
    list.user_id=current_user.id
    if list.save
      redirect_to "/lists"
    else
      redirect_to "/"
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  def list_params
    params.require(:list).permit(:name, :movie_ids, :user_id, :private)
  end
end

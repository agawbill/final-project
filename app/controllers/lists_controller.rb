class ListsController < ApplicationController
  def index
  end

  def new
    @list=List.new
  end

  def create
    list=List.new(list_params)
    array=params[:movie_ids].split(',').map(&:to_i)
    list.movie_ids.push(array)
    list.user_id=current_user.id
    if params[:private]=true
      list.private=true
    else
      list.private=false
    end
    if list.save
      redirect_to "/users/#{current_user.id}"
    else
      redirect_to "/"
  end
  end

  def show
    @list=List.find(params[:id])
    @user =User.find(current_user.id)
  end

  def update
  end

  def destroy
  end

  private
  def list_params
    params.require(:list).permit(:name, :movie_ids, :user_id, :description, :private)
  end
end

class ListsController < ApplicationController
  respond_to :html, :json, :xml, :js
  before_action :set_list, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  def index
    # @lists=List.all.order(:cached_votes_up => desc)

  end

  def new
    @list=List.new
  end

  def create
    list=List.new(list_params)
    array=params[:movie_ids].split(',').map(&:to_i)
    list.movie_ids.push(array)
    list.user_id=current_user.id
    # end
    if list.save
      redirect_to "/users/#{current_user.id}"
    else
      redirect_to "/"
  end
  end

  def show
    @movieLists=[]
    @list=List.find(params[:id])
    @movieList=@list.movie_ids[0]
    for movie_id in @movieList do
      @movieLists.push(Tmdb::Movie.detail(movie_id))
    end


    @user =User.find(current_user.id)
    if params[:s].present?
    @movies=Tmdb::Movie.similar(params[:s])
    @pages=@movies.total_pages
    @entries=@movies.total_results
    respond_to do |format|
    format.html # show.html.erb
    format.js
    format.json { render :json => {:movies => @movies }}
  end
  end
  end

  def update
  end

  # upvote_from user
  # downvote_from user
  def upvote
    movie=params[:id]
    @list.upvote_from current_user
    redirect_to "/lists/#{movie}"
  end

  def downvote
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
      redirect_to "/"
  end

  private
  def set_list
    @list=List.find(params[:id])
  end
  def list_params
    params.require(:list).permit(:name, :movie_ids, :user_id, :description, :category, :private)
  end
end

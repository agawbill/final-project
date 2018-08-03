class UsersController < ApplicationController


  def show







  @user= User.find(params[:id])
  @public=[]
  @private=[]
  @latest=[]
  @recent=@user.lists.last
    for movie in @user.lists do
      if movie.private?
      @private.push(movie)
      else
      @public.push(movie)
      end
    end

    if @recent.category=="Movies"
      for movie in @recent.movie_ids[0]
        @latest.push(Tmdb::Movie.detail(movie))
      end
    else
      for movie in @recent.movie_ids[0]
        @latest.push(Tmdb::Person.detail(movie))
      end
    end


  end
end

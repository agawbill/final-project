class UsersController < ApplicationController


  def show

  @user= User.find(params[:id])
  @public=[]
  @private=[]
  for movie in @user.lists do
    if movie.private?
    @private.push(movie)
    else
    @public.push(movie)

  end
  end
  end
end

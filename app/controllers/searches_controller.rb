class SearchesController < ApplicationController

  # include HTTParty
  # base_uri 'api.themoviedb.org/3/movie/550?api_key=720b022cdc841c69c719e5c1b854fd67'

  def index
    @genreList=Tmdb::Genre.movie_list
    if params[:q].present? && params[:genres].present?
      @movies=Tmdb::Search.movie(params[:q])
      @results=@movies.results.find_all { |favor| favor.genre_ids.include? params[:genres].to_i }
    elsif params[:q].present?
      @movies=Tmdb::Search.movie(params[:q])
      @results=@movies.results

    # elsif params[:r].present?
    #  @actors=Tmdb::Search.person(params[:r])
    #  @results=@actors.results
   else
     @movies=[]
     @results=[]
   # end
 end
  end

#   def index
#
#   if params[:q].present?
#     @movies=Tmdb::Movie.find(q: params[:q])
#     # @results=@movies.results[0]
#   else
#     @movies=[]
#     @results=[]
#   # end
# end
# end

  def show
  if search_params = params[:search] && params[:search][:query]
    @search = Search.new(query: search_params)
    @search.perform if @search.valid?
  else
    @search = Search.new
  end
end

end

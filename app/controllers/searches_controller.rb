class SearchesController < ApplicationController

  # include HTTParty
  # base_uri 'api.themoviedb.org/3/movie/550?api_key=720b022cdc841c69c719e5c1b854fd67'

  def index
    if params[:q].present?
     @movies=Tmdb::Search.movie(params[:q])
     @results=@movies.results
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

class SearchesController < ApplicationController

  # include HTTParty
  # base_uri 'api.themoviedb.org/3/movie/550?api_key=720b022cdc841c69c719e5c1b854fd67'

  def index
    @genreList=Tmdb::Genre.movie_list
    if params[:d].present? && params[:genresD].present? && params[:ratingD].present?
      @movies=Tmdb::Search.movie(params[:d])
      solid=@movies.results.find_all{|favor| favor.genre_ids.include? params[:genresD].to_i }
      @results=solid.find_all{|favor| favor.vote_average >= params[:ratingD].to_i }
    elsif params[:q].present? && params[:genres].present? && params[:ratingQ].present?
      @movies=Tmdb::Search.movie(params[:q])
      solid=@movies.results.find_all{|favor| favor.genre_ids.include? params[:genres].to_i }
      @results=solid.find_all{|favor| favor.vote_average >= params[:ratingQ].to_i }
    elsif params[:l].present? && params[:rating].present?
      @genres=Tmdb::Genre.movies(params[:l])
      @results=@genres.results.find_all { |favor| favor.vote_average >= params[:rating].to_i}
    elsif params[:q].present? && params[:genres].present?
      @movies=Tmdb::Search.movie(params[:q])
      @results=@movies.results.find_all { |favor| favor.genre_ids.include? params[:genres].to_i }
    elsif params[:q].present? && params[:ratingQ].present?
      @movies=Tmdb::Search.movie(params[:q])
      @results=@movies.results.find_all { |favor| favor.vote_average >= params[:ratingQ].to_i }
    elsif params[:d].present? && params[:genresD].present?
      @movies=Tmdb::Search.person(params[:d])
      @results=@movies.results[0].known_for.find_all { |favor| favor.genre_ids.include? params[:genresD].to_i }
    elsif params[:d].present? && params[:ratingD].present?
      @movies=Tmdb::Search.person(params[:d])
      @results=@movies.results[0].known_for.find_all { |favor| favor.vote_average >= params[:ratingD].to_i }
    elsif params[:d].present?
      @movies=Tmdb::Search.person(params[:d])
      @results=@movies.results[0].known_for
    elsif params[:q].present?
      @movies=Tmdb::Search.movie(params[:q])
      @results=@movies.results
    elsif params[:r].present?
     @actors=Tmdb::Search.person(params[:r])
     @results=@actors.results
   elsif params[:l].present?
     @genres=Tmdb::Genre.movies(params[:l])
     @results=@genres.results
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

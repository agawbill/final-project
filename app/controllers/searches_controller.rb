class SearchesController < ApplicationController



  def index

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
    elsif params[:genresP].present? && params[:ratingP].present?
      @movies=Tmdb::Movie.popular.results
      @solid=@movies.find_all { |favor| favor.genre_ids.include? params[:genresP].to_i}
      @results=@solid.find_all { |favor| favor.vote_average >= params[:ratingP].to_i }
    elsif params[:genresT].present? && params[:ratingT].present?
      @movies=Tmdb::Movie.top_rated.results
      @solid=@movies.find_all { |favor| favor.genre_ids.include? params[:genresT].to_i}
      @results=@solid.find_all { |favor| favor.vote_average >= params[:ratingT].to_i }
    elsif params[:genresU].present? && params[:ratingU].present?
      @movies=Tmdb::Movie.upcoming.results
      @solid=@movies.find_all { |favor| favor.genre_ids.include? params[:genresU].to_i}
      @results=@solid.find_all { |favor| favor.vote_average >= params[:ratingU].to_i }
    elsif params[:genresL].present? && params[:ratingL].present?
      @movies=Tmdb::Movie.now_playing.results
      @solid=@movies.find_all { |favor| favor.genre_ids.include? params[:genresL].to_i}
      @results=@solid.find_all { |favor| favor.vote_average >= params[:ratingL].to_i }
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
    elsif params[:genresP].present?
      @movies=Tmdb::Movie.popular.results
      @results=@movies.find_all { |favor| favor.genre_ids.include? params[:genresP].to_i}
    elsif params[:genresT].present?
      @movies=Tmdb::Movie.top_rated.results
      @results=@movies.find_all { |favor| favor.genre_ids.include? params[:genresT].to_i}
    elsif params[:genresU].present?
      @movies=Tmdb::Movie.upcoming.results
      @results=@movies.find_all { |favor| favor.genre_ids.include? params[:genresU].to_i}
    elsif params[:genresL].present?
      @movies=Tmdb::Movie.now_playing.results
      @results=@movies.find_all { |favor| favor.genre_ids.include? params[:genresL].to_i}
    elsif params[:ratingP].present?
      @movies=Tmdb::Movie.popular.results
      @results=@movies.find_all { |favor| favor.vote_average >= params[:ratingP].to_i }
    elsif params[:ratingU].present?
      @movies=Tmdb::Movie.upcoming.results
      @results=@movies.find_all { |favor| favor.vote_average >= params[:ratingU].to_i }
    elsif params[:ratingL].present?
      @movies=Tmdb::Movie.now_playing.results
      @results=@movies.find_all { |favor| favor.vote_average >= params[:ratingL].to_i }
    elsif params[:ratingT].present?
      @movies=Tmdb::Movie.top_rated.results
      @results=@movies.find_all { |favor| favor.vote_average >= params[:ratingT].to_i }
    elsif params[:allPop].present?
      @results=Tmdb::Movie.popular.results
    elsif params[:d].present?
      @movies=Tmdb::Search.person(params[:d])
      @results=@movies.results[0].known_for
    elsif params[:q].present?
      @movies=Tmdb::Search.movie(params[:q], page: params[:page])
      @results=@movies.results
      @pages=@movies.total_pages
      @entries=@movies.total_results
    elsif params[:r].present?
     @actors=Tmdb::Search.person(params[:r])
     @results=@actors.results
   elsif params[:l].present?
     @genres=Tmdb::Genre.movies(params[:l])
     @results=@genres.results
   else
     @movies=[]
     @results=[]
     @popularMovies=Tmdb::Movie.popular.results
     @topRatedMovies=Tmdb::Movie.top_rated.results
     @topRatedMovies=Tmdb::Movie.top_rated.results
     @nowPlayingMovies=Tmdb::Movie.now_playing.results
     @upcomingMovies=Tmdb::Movie.upcoming.results
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

class SearchesController < ApplicationController
respond_to :html, :json, :xml, :js


  def index
    @list=List.new
    if params[:d].present? && params[:genresD].present? && params[:ratingD].present?
      array=params[:genresD].split(',').map(&:to_i)
      @movies=Tmdb::Search.movie(params[:d], page: params[:page])
      @solid=@movies.results.find_all{|favor| (favor.genre_ids-array).empty?}
      @results=@solid.find_all{|favor| favor.vote_average >= params[:ratingD].to_i }
      @pages=@movies.total_pages
      @entries=@movies.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :solid => @solid, :results => @results }}
    end
    elsif params[:q].present? && params[:genres].present? && params[:ratingQ].present?

      @movies=Tmdb::Search.movie(params[:q], page: params[:page])
      array=params[:genres].split(',').map(&:to_i)
      @solid=@movies.results.find_all{|favor| (favor.genre_ids-array).empty?}
      @results=@solid.find_all{|favor| favor.vote_average >= params[:ratingQ].to_i }
      @pages=@movies.total_pages
      @entries=@movies.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :solid => @solid, :results => @results }}
    end
    elsif params[:l].present? && params[:rating].present?
      @genres=Tmdb::Genre.movies(params[:l], page: params[:page])
      @results=@genres.results.find_all{|favor| (favor.genre_ids-array).empty?}
      @pages=@genres.total_pages
      @entries=@genres.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:genres => @genres, :results => @results }}
    end
    elsif params[:genresP].present? && params[:ratingP].present?
      array=params[:genresP].split(',').map(&:to_i)
      @movies=Tmdb::Movie.popular(page: params[:page]).results
      @solid=@movies.find_all{|favor| (favor.genre_ids-array).empty?}
      @results=@solid.find_all { |favor| favor.vote_average >= params[:ratingP].to_i }
      @pages=Tmdb::Movie.popular.total_pages
      @entries=Tmdb::Movie.popular.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :solid => @solid, :results => @results }}
    end
    elsif params[:genresT].present? && params[:ratingT].present?
      @movies=Tmdb::Movie.top_rated(page: params[:page]).results
      array=params[:genresT].split(',').map(&:to_i)
      @solid=@movies.find_all {|favor| (favor.genre_ids-array).empty?}
      @results=@movies.find_all { |favor| favor.vote_average >= params[:ratingT].to_i }
      @pages=Tmdb::Movie.top_rated.total_pages
      @entries=Tmdb::Movie.top_rated.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :solid => @solid, :results => @results }}
    end
    elsif params[:genresU].present? && params[:ratingU].present?
      @movies=Tmdb::Movie.upcoming(page: params[:page]).results
      array=params[:genresU].split(',').map(&:to_i)
      @solid=@movies.find_all {|favor| (favor.genre_ids-array).empty?}
      @results=@solid.find_all { |favor| favor.vote_average >= params[:ratingU].to_i }
      @pages=Tmdb::Movie.upcoming.total_pages
      @entries=Tmdb::Movie.upcoming.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :solid => @solid, :results => @results }}
    end
    elsif params[:genresL].present? && params[:ratingL].present?
      @movies=Tmdb::Movie.now_playing(page: params[:page]).results
      array=params[:genresL].split(',').map(&:to_i)
      @solid=@movies.find_all {|favor| (favor.genre_ids-array).empty?}
      @results=@solid.find_all { |favor| favor.vote_average >= params[:ratingL].to_i }
      @pages=Tmdb::Movie.now_playing.total_pages
      @entries=Tmdb::Movie.now_playing.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :solid => @solid, :results => @results }}
    end
    elsif params[:q].present? && params[:genres].present?
      @movies=Tmdb::Search.movie(params[:q], page: params[:page])
      array=params[:genres].split(',').map(&:to_i)
      @results=@movies.results.find_all {|favor| (favor.genre_ids-array).empty?}
      @pages=@movies.total_pages
      @entries=@movies.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :results => @results }}
    end
    elsif params[:q].present? && params[:ratingQ].present?
      @movies=Tmdb::Search.movie(params[:q], page: params[:page])
      @results=@movies.results.find_all { |favor| favor.vote_average >= params[:ratingQ].to_i }
      @pages=@movies.total_pages
      @entries=@movies.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :results => @results }}
    end
    elsif params[:d].present? && params[:genresD].present?
      @movies=Tmdb::Search.person(params[:d], page: params[:page])
      array=params[:genresD].split(',').map(&:to_i)
      @results=@movies.results[0].known_for.find_all {|favor| (favor.genre_ids-array).empty?}
      @pages=@movies.total_pages
      @entries=@movies.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :results => @results }}
    end
    elsif params[:d].present? && params[:ratingD].present?
      @movies=Tmdb::Search.person(params[:d], page: params[:page])
      @results=@movies.results[0].known_for.find_all { |favor| favor.vote_average >= params[:ratingD].to_i }
      @pages=@movies.total_pages
      @entries=@movies.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :results => @results }}
    end
    elsif params[:genresP].present?
      @movies=Tmdb::Movie.popular(page: params[:page])
      array=params[:genresP].split(',').map(&:to_i)
      @results=@movies.find_all {|favor| (favor.genre_ids-array).empty?}
      @pages=@movies.total_pages
      @entries=@movies.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :results => @results }}
    end
    elsif params[:genresT].present?
      @movies=Tmdb::Movie.top_rated(page: params[:page]).results
      array=params[:genresT].split(',').map(&:to_i)
      @results=@movies.find_all {|favor| (favor.genre_ids-array).empty?}
      @pages=@movies.total_pages
      @entries=@movies.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :results => @results }}
    end
    elsif params[:genresU].present?
      @movies=Tmdb::Movie.upcoming(page: params[:page]).results
      array=params[:genresU].split(',').map(&:to_i)
      @results=@movies.find_all {|favor| (favor.genre_ids-array).empty?}
      @pages=@movies.total_pages
      @entries=@movies.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :results => @results }}
    end
    elsif params[:genresL].present?
      @movies=Tmdb::Movie.now_playing(page: params[:page]).results
      array=params[:genresL].split(',').map(&:to_i)
      @results=@movies.find_all {|favor| (favor.genre_ids-array).empty?}
      @pages=@movies.total_pages
      @entries=@movies.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :results => @results }}
    end
    elsif params[:ratingP].present?
      @movies=Tmdb::Movie.popular(page: params[:page]).results
      @results=@movies.find_all { |favor| favor.vote_average >= params[:ratingP].to_i }
      @pages=Tmdb::Movie.popular.total_pages
      @entries=Tmdb::Movie.popular.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :results => @results }}
    end
    elsif params[:ratingU].present?
      @movies=Tmdb::Movie.upcoming(page: params[:page]).results
      @results=@movies.find_all { |favor| favor.vote_average >= params[:ratingU].to_i }
      @pages=Tmdb::Movie.upcoming.total_pages
      @entries=Tmdb::Movie.upcoming.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :results => @results }}
    end
    elsif params[:ratingL].present?
      @movies=Tmdb::Movie.now_playing(page: params[:page]).results
      @results=@movies.find_all { |favor| favor.vote_average >= params[:ratingL].to_i }
      @pages=Tmdb::Movie.now_playing.total_pages
      @entries=Tmdb::Movie.now_playing.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :results => @results }}
    end
    elsif params[:ratingT].present?
      @movies=Tmdb::Movie.top_rated(page: params[:page]).results
      @results=@movies.find_all { |favor| favor.vote_average >= params[:ratingT].to_i }
      @pages=Tmdb::Movie.top_rated.total_pages
      @entries=Tmdb::Movie.top_rated.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :results => @results }}
    end
    elsif params[:d].present?
      @movies=Tmdb::Search.person(params[:d], page: params[:page])
      @results=@movies.results
      @pages=@movies.total_pages
      @entries=@movies.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :results => @results }}
    end
    elsif params[:q].present?
      @movies=Tmdb::Search.movie(params[:q], page: params[:page])
      @results=@movies.results
      @pages=@movies.total_pages
      @entries=@movies.total_results
      @count=@results.count
      respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => {:movies => @movies, :results => @results }}
    end
    elsif params[:r].present?
     @actors=Tmdb::Search.person(params[:r], page: params[:page])
     @results=@actors.results
     @pages=@actors.total_pages
     @entries=@actors.total_results
     @count=@results.count
     respond_to do |format|
     format.html {redirect_to "shared/container"}# show.html.erb
     format.js
     format.json { render :json => {:movies => @actors, :results => @results }}
   end
   elsif params[:l].present?
     @genres=Tmdb::Genre.movies(params[:l], page: params[:page])
     @results=@genres.results
     @pages=@genres.total_pages
     @entries=@genres.total_results
     @count=@results.count
     respond_to do |format|
     format.html # show.html.erb
     format.js
     format.json { render :json => {:genres => @genres, :results => @results }}
   end
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

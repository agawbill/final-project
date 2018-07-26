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
    if list.save
      redirect_to "/users/#{current_user.id}"
    else
      flash[:error] = list.errors.full_messages.to_sentence
      redirect_to "/searches"
    end
  end

  def show
    @movieLists=[]
    @peopleLists=[]
    @list=List.find(params[:id])
    @movieList=@list.movie_ids[0]

    if @list.category == "Actors"
      for movie_id in @movieList do
      @peopleLists.push(Tmdb::Person.detail(movie_id))
      end
    elsif @list.category == "Directors"
      for movie_id in @movieList do
      @peopleLists.push(Tmdb::Person.detail(movie_id))
      end
    elsif @list.category == "Movies"
      for movie_id in @movieList do
      @movieLists.push(Tmdb::Movie.detail(movie_id))
      end
    end


    if params[:s].present?
    @movies=Tmdb::Movie.similar(params[:s])
      respond_to do |format|
      format.html
      format.js
      format.json { render :json => {:movies => @movies }}
      end
    end
    if params[:sp].present?
    @movies=Tmdb::Person.combined_credits(params[:sp])
      respond_to do |format|
      format.html
      format.js
      format.json { render :json => {:movies => @movies }}
      end
    end
  end

  def edit
    @movieNames=[]
    @list=List.find(params[:id])
    @movieIds=@list.movie_ids[0]
    if !current_user
      redirect_to "/"
    elsif current_user.id != @list.user_id
        redirect_to "/"
    end

    if @list.category=="Movies"
      for name in @movieIds do
        @movieNames.push(Tmdb::Movie.detail(name).original_title)
      end
    else
      for name in @movieIds do
        @movieNames.push(Tmdb::Person.detail(name).name)
    end
  end

    if params[:q].present? && params[:genres].present? && params[:ratingQ].present?
      @count=Tmdb::Search.movie(params[:q]).total_pages
      @solid=[]
      for i in 0...10
        @movies=Tmdb::Search.movie(params[:q], page: i+1).results
          array=params[:genres].split(',').map(&:to_i)
          for movie in @movies do
            if movie.poster_path != nil
              if array.all? {|i| movie.genre_ids.include? i }
                @solid.push(movie)
              end
            end
          end
        end
      @results=@solid.find_all{|favor| favor.vote_average >= params[:ratingQ].to_i }
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:people].present? && params[:year].present? && params[:ratingDisc].present?
      @solid=[]
      for i in 0...10
        @movies=Tmdb::Discover.movie(with_people: params[:people], primary_release_year: params[:year], page: i+1)
        for movie in @movies.results do
          if movie.poster_path != nil
            @solid.push(movie)
          end
        end
      end
      @results=@solid.find_all{|favor| favor.vote_average >= params[:ratingDisc].to_i }
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:l].present? && params[:rating].present?
      @solid=[]
      for i in 0...10
        @genres=Tmdb::Genre.movies(params[:l], page: i+1)
        for movie in @genres.results do
          if movie.poster_path != nil
            if movie.vote_average >= params[:rating].to_i
              @solid.push(movie)
            end
          end
        end
      end
      @results=@solid
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:genresP].present? && params[:ratingP].present?
      @solid=[]
      array=params[:genresP].split(',').map(&:to_i)
        for i in 0...10
        @movies=Tmdb::Movie.popular(page: i+1).results
          for movie in @movies do
            if movie.poster_path != nil
              if array.all? {|i| movie.genre_ids.include? i }
                @solid.push(movie)
              end
            end
          end
        end
      @results=@solid.find_all { |favor| favor.vote_average >= params[:ratingP].to_i }
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:genresT].present? && params[:ratingT].present?
      @solid=[]
      array=params[:genresT].split(',').map(&:to_i)
        for i in 0...10
          @movies=Tmdb::Movie.top_rated(page: i+1).results
          for movie in @movies do
            if movie.poster_path != nil
              if array.all? {|i| movie.genre_ids.include? i }
                @solid.push(movie)
              end
            end
          end
        end
      @results=@solid.find_all { |favor| favor.vote_average >= params[:ratingT].to_i }
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:genresU].present? && params[:ratingU].present?
      @solid=[]
      array=params[:genresU].split(',').map(&:to_i)
        for i in 0...10
          @movies=Tmdb::Movie.upcoming(page: i+1).results
          for movie in @movies do
            if movie.poster_path != nil
              if array.all? {|i| movie.genre_ids.include? i }
                @solid.push(movie)
              end
            end
          end
        end
      @results=@solid.find_all { |favor| favor.vote_average >= params[:ratingU].to_i }
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:genresL].present? && params[:ratingL].present?
      @solid=[]
      array=params[:genresL].split(',').map(&:to_i)
      for i in 0...10
        @movies=Tmdb::Movie.now_playing(page: i+1).results
        for movie in @movies do
          if movie.poster_path != nil
            if array.all? {|i| movie.genre_ids.include? i }
              @solid.push(movie)
            end
          end
        end
      end
      @results=@solid.find_all { |favor| favor.vote_average >= params[:ratingL].to_i }
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:q].present? && params[:genres].present?
      @solid=[]
      array=params[:genres].split(',').map(&:to_i)
      for i in 0...10
        @movies=Tmdb::Search.movie(params[:q], page: i+1)
        for movie in @movies do
            if array.all? {|i| movie.genre_ids.include? i }
              if movie.poster_path != nil
              @solid.push(movie)
            end
          end
        end
      end
      @results=@solid
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:q].present? && params[:ratingQ].present?
      @solid=[]
      for i in 0...10
        @movies=Tmdb::Search.movie(params[:q], page: i+1)
        for movie in @movies.results do
          if movie.poster_path != nil
            if movie.vote_average >= params[:ratingQ].to_i
              @solid.push(movie)
            end
          end
        end
      end
      @results=@solid
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:people].present? && params[:year].present?
      @solid=[]
      for i in 0...10
        @movies=Tmdb::Discover.movie(with_people: params[:people], primary_release_year: params[:year], page: i+1)
        for movie in @movies.results do
          if movie.poster_path != nil
            @solid.push(movie)
          end
        end
      end
      @results=@solid
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:people].present? && params[:ratingDisc].present?
      @solid=[]
      for i in 0...10
        @movies=Tmdb::Discover.movie(with_people: params[:people], page: i+1)
          for movie in @movies.results do
            if movie.poster_path != nil
              if movie.vote_average >= params[:ratingDisc].to_i
                @solid.push(movie)
              end
          end
        end
      end
      @results=@solid
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:year].present? && params[:ratingDisc].present?
      @solid=[]
      for i in 0...10
        @movies=Tmdb::Discover.movie(primary_release_year: params[:year], page: i+1)
        for movie in @movies.results do
          if movie.poster_path != nil
            if movie.vote_average >= params[:ratingDisc].to_i
              @solid.push(movie)
            end
          end
        end
      end
      @results=@solid
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:genresP].present?
      @solid=[]
      array=params[:genresP].split(',').map(&:to_i)
      for i in 0...10
        @movies=Tmdb::Movie.popular(page: i+1)
        for movie in @movies do
          if movie.poster_path != nil
            if array.all? {|i| movie.genre_ids.include? i }
              @solid.push(movie)
            end
          end
        end
      end
      @results=@solid
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:genresT].present?
      @solid=[]
      array=params[:genresT].split(',').map(&:to_i)
      for i in 0...10
        @movies=Tmdb::Movie.top_rated(page: i+1).results
        for movie in @movies do
          if movie.poster_path != nil
            if array.all? {|i| movie.genre_ids.include? i }
              @solid.push(movie)
            end
          end
        end
      end
      @results=@solid
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:genresU].present?
      @solid=[]
      array=params[:genresU].split(',').map(&:to_i)
      for i in 0...10
        @movies=Tmdb::Movie.upcoming(page: i+1).results
        for movie in @movies do
          if movie.poster_path != nil
            if array.all? {|i| movie.genre_ids.include? i }
              @solid.push(movie)
            end
          end
        end
      end
      @results=@solid
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:genresL].present?
      @solid=[]
      array=params[:genresL].split(',').map(&:to_i)
        for i in 0...10
          @movies=Tmdb::Movie.now_playing(page: i+1).results
          for movie in @movies do
            if movie.poster_path != nil
              if array.all? {|i| movie.genre_ids.include? i }
                @solid.push(movie)
              end
            end
          end
        end
      @results=@solid
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:ratingP].present?
      @solid=[]
        for i in 0...10
          @movies=Tmdb::Movie.popular(page: params[:page]).results
          for movie in @movies do
            if movie.poster_path != nil
              if movie.vote_average >= params[:ratingP].to_i
                @solid.push(movie)
              end
            end
          end
        end
      @results=@solid
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:ratingU].present?
      @solid=[]
      for i in 0...10
        @movies=Tmdb::Movie.upcoming(page: i+1).results
        for movie in @movies do
          if movie.poster_path != nil
            if movie.vote_average >= params[:ratingU].to_i
              @solid.push(movie)
            end
          end
        end
      end
      @results=@solid
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:ratingL].present?
      @solid=[]
      for i in 0...10
        @movies=Tmdb::Movie.now_playing(page: i+1).results
        for movie in @movies do
          if movie.poster_path != nil
            if movie.vote_average >= params[:ratingL].to_i
              @solid.push(movie)
            end
          end
        end
      end
      @results=@solid
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:ratingT].present?
      @solid=[]
      for i in 0...10
        @movies=Tmdb::Movie.top_rated(page: i+1).results
        for movie in @movies do
          if movie.poster_path != nil
            if movie.vote_average >= params[:ratingT].to_i
              @solid.push(movie)
            end
          end
        end
      end
      @results=@solid
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:d].present?
      @solid=[]
      for i in 0...10
        @movies=Tmdb::Search.person(params[:d], page: i+1).results
        for person in @movies do
          if person.known_for.length > 2 && person.profile_path != nil
            @solid.push(person)
          end
        end
      end
      @results=@solid
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:q].present?
      @solid=[]
      for i in 0...10
        @movies=Tmdb::Search.movie(params[:q], page: i+1).results
        for movie in @movies do
          if movie.poster_path != nil
            @solid.push(movie)
          end
        end
      end
      @results=@solid
      respond_to do |format|
        format.html
        format.js
        format.json { render :json => {:results => @results }}
      end
    elsif params[:r].present?
      @solid=[]
      for i in 0...10
       @actors=Tmdb::Search.person(params[:r], page:i+1).results
       for person in @actors do
         if person.known_for.length >2 && person.profile_path != nil
           @solid.push(person)
         end
       end
     end
     @results=@solid
     respond_to do |format|
       format.html
       format.js
       format.json { render :json => {:results => @results }}
     end
   elsif params[:l].present?
     @solid=[]
     for i in 0...10
       @genres=Tmdb::Genre.movies(params[:l], page: i+1).results
       for movie in @genres do
         if movie.poster_path != nil
           @solid.push(movie)
         end
       end
     end
     @results=@solid
     respond_to do |format|
       format.html
       format.js
       format.json { render :json => {:results => @results }}
     end
   elsif params[:directorDiscover].present?
     @solid=[]
     for i in 0...10
       @movies=Tmdb::Search.person(params[:directorDiscover], page: i+1).results
       for person in @movies do
         if person.known_for.length >2 && person.profile_path!=nil
           @solid.push(person)
         end
       end
     end
     @results=@solid
     respond_to do |format|
       format.html
       format.js
       format.json { render :json => {:results => @results }}
     end
   elsif params[:actorDiscover].present?
     @solid=[]
     for i in 0...10
       @movies=Tmdb::Search.person(params[:actorDiscover], page: i+1).results
       for person in @movies do
         if person.known_for.length >2 && person.profile_path!=nil
           @solid.push(person)
         end
       end
     end
     @results=@solid
     respond_to do |format|
       format.html
       format.js
       format.json { render :json => {:results => @results }}
     end
   elsif params[:people].present?
     @solid=[]
     for i in 0...10
       @movies=Tmdb::Discover.movie(with_people: params[:people], page: i+1).results
       for movie in @movies do
         if movie.poster_path != nil
           @solid.push(movie)
         end
       end
     end
     @results=@solid
     respond_to do |format|
       format.html
       format.js
       format.json { render :json => {:results => @results }}
     end
   elsif params[:year].present?
     @solid=[]
     for i in 0...10
       @movies=Tmdb::Discover.movie(primary_release_year: params[:year], page: i+1).results
       for movie in @movies do
         if movie.poster_path != nil
           @solid.push(movie)
         end
       end
     end
     @results=@solid
     respond_to do |format|
       format.html
       format.js
       format.json { render :json => {:results => @results }}
     end
   else
     @movies=[]
     @results=[]
     @popularMovies=Tmdb::Movie.popular.results
     @topRatedMovies=Tmdb::Movie.top_rated.results
     @nowPlayingMovies=Tmdb::Movie.now_playing.results
     @upcomingMovies=Tmdb::Movie.upcoming.results
   end
  end


  def update
    list=List.find(params[:id])
    array=params[:movie_ids].split(',').map(&:to_i)
    list.update(list_params)
    list.movie_ids[0]=array
    if list.update(list_params)
      redirect_to "/lists/#{params[:id]}"
    else
      render @list
    end
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

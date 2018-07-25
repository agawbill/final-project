class SearchesController < ApplicationController
respond_to :html, :json, :xml, :js


  def index
    @current_admin=current_admin
    @list=List.new
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


end

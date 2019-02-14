class MoviesController < ApplicationController

  def movie_params
    puts "#{params}"
    params.require(:movie).permit(:title, :rating, :description, :release_date)
    
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.get_rattings
    
    puts "#{params}"
    @movies = Movie.all
    if !params.has_key?(:sort) && !params.has_key?(:ratings)
      if session.has_key?(:sort) && session.has_key?(:ratings) 
        redirect_to movies_path(:sort_by=>session[:sort_by], :ratings=>session[:ratings]) and return
      end
    end
    session[:sort] = params[:sort] if params[:sort]
    session[:ratings] = params[:ratings] if params[:ratings]
    @movies = @movies.where(:rating =>session[:ratings].keys) if session[:ratings]  
    @movies = @movies.order(session[:sort]) if session[:sort]
    
    puts "#{@movies.first}"
  end

  def new
    puts "#{params}"
    # default: render 'new' template
  end

  def create
    puts "#{params}"
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    puts "#{params}"
    @movie = Movie.find params[:id]
  end
  def wrh
    redirect_to :back
  end
  def update
    puts "#{params}"
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    puts "#{params}"
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  
  #HW4 code
  def search
    @similar_movies = Movie.similar_movies(params[:title])
    @movie = Movie.find_by(title: params[:title])
    
    if @similar_movies.nil?
      redirect_to movies_path
      flash[:notice] = "'#{@movie.title}' has no director info"
    end
  end
  
  def index
    @movies = Movie.all
  end
  
  #HW2 index, allows sorting
  def index
    @movies = Movie.all
    @all_ratings = Movie.all_ratings
    @self_ratings = Movie.with_ratings
    
    #should it reload the page
    reload_page = false
    
    #how to sort the movies based on user selection
    #get the requested sort method from the URI route
    @sort_method = params[:sort_by] #params are provided by user
    if(@sort_method == nil) 
        @sort_method = session[:sort_by] #if no sort method pull session parameter
        if (@sort_method == nil) #if still nill then set to default title sort
          session[:sort_by] = "title"
        end
        
      reload_page = true
    else
      session[:sort_by] = @sort_method 
    end
    
    #what movies to upload based on ratings to show
    @ratings_to_show = params[:ratings] #get the requested filter from the URI route
    
      #Caveat for user previous session
    if(@ratings_to_show == nil || @ratings_to_show.empty?) #if empty or nill
      @ratings_to_show = session[:ratings] #set to previous session 
      if (@ratings_to_show == nil) # if session is empty the set to all movies defualt
        session[:ratings] = @all_ratings
      end
      reload_page = true
      
    else
      if(@ratings_to_show.kind_of?(Hash))
        @ratings_to_show = @ratings_to_show.keys
      end
      session[:ratings] = @ratings_to_show
    end
    
    #call the sort def to set appropriate movie path
    sort()
    
    #part 3
    if reload_page
      flash.keep 
      redirect_to movies_path(:sort_by => @sort_method, :ratings => @ratings_to_show)
    end
  end
  
  #HW 2 sort method
  def sort
    if@sort_method == "title"
      @title_header = 'hilite'
      @movies = Movie.where(rating: [@ratings_to_show]).order("title ASC")
    elsif @sort_method == "release_date_sort"
      @release_header ='hilite'
      @movies = Movie.where(rating: [@ratings_to_show]).order("release_date ASC")
    else
      @movies = Movie.all
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  
  #HW4 added param :director otherwise would be scrubbed  
  def movie_params
    params.require(:movie).permit(:title, :rating, :director, :description, :release_date)
  end
end

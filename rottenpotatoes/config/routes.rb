Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  #my code below
  # the get '' contains the incoming request
  #the as: names a def in the controllers file
  #to: is the controller and def
  #get 'similar_movies/:title', to: 'movies#similar_director', as: :movie_similar
  #get 'similar_movies/:id', to: 'movies#similar_director', as: 'movie'
  
  get 'similar_movies/:title' => 'movies#search', as: :search_similar_movies
end
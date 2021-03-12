Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  #my code below
  get 'similar_movies(/:id)', to: 'movies#similar_director', as: :movie_similar
  
end
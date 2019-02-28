Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get 'similar_movies/:title' => 'movies#find_same_director', as: :find_same_director_movies
  # .    input to the method .  method defined in controller
end

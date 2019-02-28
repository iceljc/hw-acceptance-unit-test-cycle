class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.similar_movies(movie_title)
    director = Movie.find_by(title: movie_title).director
    if director.blank? or director.nil?
    	return nil
    end

    # collect all movies with the same director
    Movie.where(director: director)
  end
  
end

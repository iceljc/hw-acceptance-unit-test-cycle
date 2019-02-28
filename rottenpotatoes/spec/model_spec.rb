require 'rails_helper'

RSpec.describe Movie, type: :model do
    
    it 'should find similar movies' do
        
        movie1 = Movie.create(:title => 'fake', :director => 'fake_director')
        movie2 = Movie.create(:title => 'fake2', :director => 'fake_director')
        
        result = Movie.similar_movies(movie1.title)
        expect(result).to eq([movie1,movie2])
    end
    
    it 'should not find similar movies when directors are different' do
        movie1 = Movie.create(:title => 'fake', :director => 'fake_director')
        movie2 = Movie.create(:title => 'fake2', :director => 'fake_director2')
        
        result = Movie.similar_movies(movie1.title)
        
        expect(result).to eq([movie1]) 
    end
    
    
    it 'should return nil when the director is empty' do
        movie = Movie.create(:title => 'fake', :director => '')
        
        result = Movie.similar_movies(movie.title)
        expect(result).to eq(nil)
    end
    
end
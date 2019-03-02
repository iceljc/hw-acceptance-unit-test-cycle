require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe 'Search movies by the same director' do
    it 'should call Movie.similar_movies' do
      expect(Movie).to receive(:similar_movies).with('Aladdin')
      get :find_same_director, { title: 'Aladdin' }
    end

    it 'should assign similar movies if director exists' do
      movie1 = Movie.create(:title => 'fake', :director => 'ruby')
      movie2 = Movie.create(:title => 'fake2', :director => 'ruby')
      movies = [movie1, movie2]
      Movie.stub(:similar_movies).with('fake').and_return(movies)
      get :find_same_director, { title: 'fake' }
      expect(assigns(:similar_movies)).to eq(movies)
    end

    it "should redirect to home page if director isn't known" do
      Movie.stub(:similar_movies).with('No name').and_return(nil)
      get :find_same_director, { title: 'No name' }
      expect(response).to redirect_to(movies_path)
    end
  end
  
  describe 'show' do
       it 'it should present the movie given its id' do
           @id = "1"
          # @movie = Movie.create(:id => @id, :title => 'fake', :director => 'ruby')
           @movie = double("test_movie", title: 'fake', show: 1)
           expect(Movie).to receive(:find).with(@id).and_return(@movie)
           get :show, {id: 1}
           expect(response).to render_template('show')
       end
  end
  
  describe 'destroy' do
      it 'it should delete a movie given its id' do
          @id = "1"
        #   @movie = Movie.create(:id => @id, :title => 'fake', :director => 'ruby')
          @movie = double("test_movie", title: "ruby", destroy: 1)
          expect(Movie).to receive(:find).with(@id).and_return(@movie)
          get :destroy, {id: 1}
          expect(response).to redirect_to(movies_path)
      end
  end
  
  describe 'index' do
    it 'it should highlight the title header' do
      get :index, {sort: 'title'}
      expect(assigns(:title_header)).to eq('hilite')
    end
    
    it 'it should highlight the date header' do
      get :index, {sort: 'release_date'}
      expect(assigns(:date_header)).to eq('hilite')
    end
  end
  
  describe 'edit' do
    it 'it should edit the selected movie' do
      @id = "1"
      # @movie = Movie.create(:id => @id, :title => 'fake', :director => 'ruby')
      @movie = double("test_movie", title: "ruby", edit: 1)
      expect(Movie).to receive(:find).with(@id).and_return(@movie)
      get :edit, {id: 1}
      expect(response).to render_template('edit')
    end
  end
  
  describe 'update' do
    it 'it should update the selected movie info' do
      @id = "1"
      @movie = Movie.create(:id => @id, :title => 'fake', :director => 'ruby')
      # @movie = double("test_movie", title: "ruby", update: 1)
      movie_p = {:movie=>{:id=>1, :title=>'fake', :director=>'ruby'}}
      expect(Movie).to receive(:find).with(@id).and_return(@movie)
      get :update, {id: 1, movie: movie_p}
      expect(response).to redirect_to(movie_path(@movie))
    end
  end
  
  describe 'create' do
    it 'it should create a new movie' do
      movie_p = {:movie=>{:id=>1, :title=>'fake', :director=>'ruby'}}
      get :create, {movie: movie_p}
      expect(response).to redirect_to(movies_path)
    end
  end
  
  
#   describe 'new' do
#       it 'given nothing' do
#       end
#   end
          

  
end

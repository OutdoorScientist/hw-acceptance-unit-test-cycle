require 'rails_helper'



describe MoviesController do
    describe 'Searching for movies with the same director' do
        
        it 'should return to the homepage if no director infor exist' do
            
        end   
        
        it 'should search for similar_movies if director given' do
            movie_01 = Movie.create!(title: 'iRobot', director: 'Alex Proyas')
            movie_02 = Movie.create!(title: 'Joy', director: 'Alex Proyas')
            #get :search_similar_movies, {title: 'Star Wars'}
            #expect((@similar_movies)).to eq ['Star Wars', 'THX-1138']
            expect((@similar_movies)).to eq nil
        end
        
        #it "should display 'THX-1138' for 'Star Wars'" do
         #end
        
    end
end
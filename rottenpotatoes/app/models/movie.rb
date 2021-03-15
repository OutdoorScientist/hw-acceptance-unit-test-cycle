class Movie < ActiveRecord::Base
    
    def self.all_ratings
        ['G','PG','PG-13','R']
    end
    
    def self.with_ratings()
    end
    
    #HW4 cucumber scenario 2
    
    def self.similar_movies movie_title
    director = Movie.find_by(title: movie_title).director
    #Where it is determined if a director exist
    return nil if director.blank? or director.nil?
    Movie.where(director: director)
    end
    
end

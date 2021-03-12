class Movie < ActiveRecord::Base
    def self.similar_movies director
        Movie.where(:director=> director)
    end
end

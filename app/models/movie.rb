class Movie < ActiveRecord::Base
    def sort attri
        @movies.sort_by! do|p|
            p[attri]
        end
    end
        
end

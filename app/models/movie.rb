class Movie < ActiveRecord::Base
    def self.get_rattings
		a = Array.new
		self.select(:rating).group(:rating).each do |movie|
			a << movie.rating
		end
		return a
	end
end

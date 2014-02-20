class Time
	def yesterday
  	Time.at(self.to_i-86400)
	end
end

class Array
	def blank?
		length == 0
	end
end
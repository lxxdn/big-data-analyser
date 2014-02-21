require './lib/time.rb'
require 'byebug'

USER_GROUP_NUMBER = 1024

# This function separates last 7 log files into small temp files
# save into temp folder
def file_separator(log_dir_path=Dir.pwd, temp_dir_path=File.join(Dir.pwd, "temp"))
	# create folder if it does not exist
	Dir.mkdir(temp_dir_path) if Dir[temp_dir_path].blank?

	current_date = Time.now

	7.times do

		date_str = current_date.strftime("%Y%m%d")
		log_file_name = "listen-#{current_date.strftime("%Y%m%d")}.log"
		# byebug
		one_day_dir_path = File.join(temp_dir_path,date_str )
		Dir.mkdir(one_day_dir_path) if Dir[one_day_dir_path].blank?

		begin
   		File.open(File.join(log_dir_path,log_file_name), "r") do |file|
	   		while(line = file.gets)
	   			# if this line does not respect the format
	   			next unless line =~ (/(\d+)\|(\d+)\|(\w\w)$/)

		  		sng_id, user_id, country = line.scan(/(\d+)\|(\d+)\|(\w\w)$/).flatten

		  		write_country_file(country, sng_id, current_date, one_day_dir_path)
		  		write_user_file(user_id, sng_id, current_date,one_day_dir_path)
		 		end
		 	end
		rescue Exception => e
      puts "Error!! #{log_dir_path}#{log_file_name} does not exist"
      puts e
		end
		current_date = current_date.yesterday
	end

end

def write_country_file(key_word, sng_id, current_date, dir_path)
	begin
		File.open(File.join(dir_path, "#{key_word}-#{current_date.strftime("%Y%m%d")}.tmp"),"a") do |file|
			file.puts sng_id
		end

		puts "********** #{key_word} #{sng_id} **********"

	rescue Exception => e
		puts e
	end
end

def write_user_file(user_id, sng_id, current_date, dir_path)
	begin
		group_id = user_id.to_i % USER_GROUP_NUMBER
		File.open(File.join(dir_path, "#{group_id}-#{current_date.strftime("%Y%m%d")}.tmp"),"a") do |file|
			file.puts "#{user_id}|#{sng_id}"
		end

		puts "********** #{user_id} #{sng_id} **********"

	rescue Exception => e
	end
end

file_separator "test"
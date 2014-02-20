require './lib/time.rb'

# This function separates last 7 log files into small temp files
# save into temp folder
def file_separator(log_dir_path=Dir.pwd, temp_dir_path=File.join(Dir.pwd, "temp"))
	# create folder if it does not exist
	Dir.mkdir(temp_dir_path) if Dir[temp_dir_path].nil?

	current_date = Time.now
	7.times do
		log_file_name = "listen-" + current_date.strftime("%Y%m%d") + ".log"

		begin
   		file = File.open(File.join(log_dir_path,log_file_name), "r")
   		file.each_line do |line|
   			# if this line does not respect the format
   			next unless line =~ (/(\d+)\|(\d+)\|(\w\w)$/)
	  		sng_id, user_id, country = line.scan(/(\d+)\|(\d+)\|(\w\w)$/).flatten
	  		write_file(country, sng_id, current_date, temp_dir_path)
	  		# write_file(user_id, sng_id, current_date)
	 		end
		rescue Exception => e
      puts "Error!! #{log_dir_path}#{log_file_name} does not exist"
    ensure
    	file.close unless file.nil?
		end
		current_date = current_date.yesterday
	end
end

def write_file(key_word, sng_id, current_date, dir_path)
	begin
		file = File.open(File.join(dir_path, key_word+"_"+current_date.strftime("%Y%m%d")+".log"),"a")
		file.puts sng_id
		puts "**********" + key_word + " " + sng_id
		file.close
	rescue Exception => e
		puts e
	ensure
  	file.close unless file.nil?
	end
end

file_separator "test"
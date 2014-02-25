require "./analyser.rb"

if ARGV.length > 2
	puts 'Wrong argument number!! take log_dir_path and temp_dir_path'
	exit
end

# log file path
log_dir_path= ARGV[0].nil? ? File.join(Dir.pwd, "log") : ARGV[0]

# temp file path where it puts temp files
temp_dir_path=ARGV[1].nil? ? File.join(Dir.pwd, "temp") : ARGV[1]

analyser = Analyser.new(log_dir_path, temp_dir_path)
analyser.analyse
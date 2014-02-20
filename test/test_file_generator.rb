# This file will generate a test file which is about 30M
# The first argument 'filename' is optional

if ARGV.length > 1
	puts 'Wrong argument number'
	exit
end

file_name = ARGV[0].nil? ? "listen-#{Time.now.strftime("%Y%m%d")}.log" : ARGV[0]
locales = ["AF", "AR", "AZ", "BG", "BN", "CA", "CS", "CY", "DE", "EL", "EN", "EO", "ES", "ET", "EU", "FA", "FI", "FR", "GL", "HE", "HI", "HU", "ID", "IT", "KN", "KO", "LO", "LT", "LV", "MK", "MN", "MS", "NB", "NE", "NN", "PL", "PT", "RM", "RO", "RU", "SK", "SL", "SV", "SW", "TH", "TL", "TR", "UK", "UZ", "VI", "WO", "ZH"]

File.open(file_name, 'w') do |f|
	1.5e4.to_i.times do
		if Random.rand(100) == 1
			f.puts "error message\n"
		else
			f.puts "#{Random.rand(1e8.to_i).to_s}|#{Random.rand(1e8.to_i).to_s}|#{locales[Random.rand(locales.length)]}"
		end
	end
end



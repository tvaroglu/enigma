require_relative 'file_handler'
in_file, out_file, key, date = ARGV

FileHandler.write_message('./lib/'+in_file)
puts FileHandler.encrypt('./lib/'+in_file, './lib/'+out_file, key, date)

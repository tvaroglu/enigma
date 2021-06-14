require_relative 'file_handler'
in_file, out_file, key, date = ARGV

puts FileHandler.encrypt('./lib/'+in_file, './lib/'+out_file, key, date)

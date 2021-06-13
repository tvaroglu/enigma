require_relative 'file_handler'
in_file, out_file, key, date = ARGV

puts FileHandler.decrypt('./lib/'+in_file, './lib/'+out_file, key, date)

require_relative 'file_handler'
in_file, out_file, date = ARGV

puts FileHandler.crack('./lib/'+in_file, './lib/'+out_file, date)

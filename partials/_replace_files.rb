#Replace static directories  
puts "\n ======================================"
puts "Replacing static files from test_dir".magenta

puts "Replacing app files"  
directory File.join(@static_files, 'app'), "app"

puts "Replacing public files"
directory File.join(@static_files, 'public'), "public"  


# def file_is_child?(parent_dir, dir_entry)
# 	File.path(dir_entry) =~ Regexp.new("\A#{parent_dir.path}")
# end
# 
# Dir.foreach(@static_files) do |file_name| 
# 	dir_entry = File.join(@static_files, file_name)
# 	puts "#{file_name} is a directory? #{File.directory?(dir_entry)}"
# 	puts "#{file_name} is a child of this dir? #{file_is_child?(File.new(@static_files), dir_entry)}"
# end  


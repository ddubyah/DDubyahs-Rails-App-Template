#
# Based on the greendog-rails-template
#
# Usage:
#   rails new appname -d mysql -m /path/to/template.rb
#
# Also see http://textmate.rubyforge.org/thor/Thor/Actions.html


%w{colored bundler compass html5-boilerplate haml}.each do |component|
  unless Gem.available?(component)
    run "gem install #{component}"
    Gem.refresh
    Gem.activate(component)
  end
end

require "rails"
require "colored"
require "bundler"
require "haml"

# Directories for template partials and static files
@template_root = File.expand_path(File.join(File.dirname(__FILE__)))
@partials     = File.join(@template_root, 'partials')
@static_files = File.join(@template_root, 'files')

[@template_root,@partials,@static_files].each do |item|
	puts "path set #{item}".red
end                           

# Copy a static file from the template into the new application
def copy_static_file(path)
  # puts "Installing #{path}...".magenta
  remove_file path
  file path, File.read(File.join(@static_files, path))
  # puts "\n"
end

# From "Suspenders" by thoughtbot
def download_file(uri_string, destination)
  uri = URI.parse(uri_string)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true if uri_string =~ /^https/
  request = Net::HTTP::Get.new(uri.path)
  contents = http.request(request).body
  path = File.join(destination_root, destination)
  File.open(path, "w") { |file| file.write(contents) }
end          

puts "\n========================================================="
puts " DDubyah's RAILS 3 TEMPLATE".yellow.bold
puts "=========================================================\n"


copy_static_file 'Gemfile' 
apply "#{@partials}/_git.rb"
apply "#{@partials}/_rvm.rb"      

# apply jquery   
puts "applying jquery".yellow
yes? "Continue?"
generate 'jquery:install'    
#run "rails g jquery:install" 
yes? "Continue?" 

apply "#{@partials}/_boilerplate.rb"    
apply "#{@partials}/_replace_files.rb"     

route "root :to => 'pages#home'"     
remove_file 'public/index.html'

# Set up rvm private gemset

puts "Setting up RVM gemset and installing bundled gems (may take a while) ... ".magenta

# Need to strip colors in case rvm_pretty_print_flag is enabled in user's .rvmrc
rvm_list = `rvm list`.gsub(Regexp.new("\e\\[.?.?.?m"), '')

# ask if we'd like to create a custom gemset

make_gemset = yes?("Would you like to create and initialise a custom gemset? [yn]".yellow)
puts "making gemset? #{make_gemset}".yellow
if (make_gemset)  
	puts "Making gemset".magenta
 	current_ruby = rvm_list.match(/=> ([^ ]+)/)[1]
	desired_ruby = ask("Which RVM Ruby would you like to use? [#{current_ruby}]".red)
	desired_ruby = current_ruby if desired_ruby.blank?

	gemset_name = ask("What name should the custom gemset have? [#{@app_name}]".red)
	gemset_name = @app_name if gemset_name.blank?

	# Create the gemset
	run "rvm #{desired_ruby} gemset create #{gemset_name}"

	# Let us run shell commands inside our new gemset. Use this in other template partials.
	@rvm = "rvm use #{desired_ruby}@#{gemset_name}"

	# Create .rvmrc
	file '.rvmrc', @rvm
	puts "                  #{@rvm}".yellow

	# Make the .rvmrc trusted
	run "rvm rvmrc trust #{@app_path}"

	# Since the gemset is likely empty, manually install bundler so it can install the rest
	run "#{@rvm} gem install bundler"

	# Install all other gems needed from Gemfile
	run "#{@rvm} exec bundle install" 
else
	run "exec bundle install"
end

puts "\n"
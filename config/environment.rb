# Load the rails application
require File.expand_path('../application', __FILE__)

#REF http://blog.masayuki0812.net/2011/09/incompatible-character-encodings-ascii.html
#22/10/2013 12:23:49
require 'encoding_patch'

# Initialize the rails application
JQM1::Application.initialize!

#REF http://www.williambharding.com/blog/rails/automatically-reload-modules-on-change-in-rails/
#Mentined in => http://stackoverflow.com/questions/1114388/rails-reloading-lib-files-without-having-to-restart-server answered Jul 11 '09 at 18:54
#config.load_paths += %W( #{RAILS_ROOT}/lib )
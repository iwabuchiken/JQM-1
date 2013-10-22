# Load the rails application
require File.expand_path('../application', __FILE__)

#REF http://blog.masayuki0812.net/2011/09/incompatible-character-encodings-ascii.html
#22/10/2013 12:23:49
require 'encoding_patch'

# Initialize the rails application
JQM1::Application.initialize!

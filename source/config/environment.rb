# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'
require 'twitter'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

configure do
  # By default, Sinatra assumes that the root is the file that calls the configure block.
  # Since this is not the case for us, we set it manually.
  set :root, APP_ROOT.to_path
  # See: http://www.sinatrarb.com/faq.html#sessions
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET'] || 'this is a secret shhhhh'

  # Set the views to
  set :views, File.join(Sinatra::Application.root, "app", "views")
end

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')

# env_config = YAML.load_file(APP_ROOT.join('config', 'twitter.yaml'))

# env_config.each do |key, value|
#   ENV[key] = value
# end

$client = Twitter::REST::Client.new do |config|
  config.consumer_key = "DR611JwSI0kT8oBa0DppCQ"
  config.consumer_secret = "2xHZHnVKvOPdPwT7Pusu8Y61yME2t7kADBPUfdrl8"
  config.access_token = "1398484105-aRZUMcX0ec0HVQYEUMGEGU2wBwUJZZCz9zm1ckq"
  config.access_token_secret = "wR6e1d777xGN642gFN1NxcktPrYQoGb5bvR9soR9b5iOI"
end
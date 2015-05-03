APP_ROOT = File.expand_path('../../', __FILE__)
$: << File.join(APP_ROOT, 'lib')

require 'bundler/setup'
require 'active_record'
require 'yaml'
require 'logger'

log_path = File.join(APP_ROOT, 'log/hookline.log')
LOGGER = Logger.new(log_path)

config_filename = File.expand_path('../config.yml', __FILE__)
config = YAML.load(File.read(config_filename))

connection_settings = config[:database][:production]
ActiveRecord::Base.establish_connection(connection_settings)

track_directory = config[:track_directory]
unless File.directory?(track_directory)
  raise "Please set :track_directory in config.yml and ensure it exists"
  exit 1
end
TRACK_DIRECTORY = File.expand_path(track_directory)

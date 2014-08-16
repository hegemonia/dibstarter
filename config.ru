require 'rack'
require ::File.expand_path('../config/environment',  __FILE__)

use Rack::Static, :urls => ["/public"]

run Rails.application

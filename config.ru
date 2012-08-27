# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run TaksBoard::Application

#unicorn gc setting
require 'unicorn/oob_gc'
use Unicorn::OoGC, 10


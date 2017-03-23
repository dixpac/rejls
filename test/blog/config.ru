# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

#class App
#  def call(env)
#    raise "wait a minute"
#    message = "rock on!"
#    [
#      200,
#      {"Content-Type" => "text/plain"},
#      [message]
#    ]
#  end
#end

#class Logger
#  def initialize(app)
#    @app = app
#  end
#
#  def call(env)
#    puts "#{env["REQUEST_METHOD"]} #{env["PATH_INFO"]}"
#    @app.call(env)
#  end
#end

#use Rack::CommonLogger
#use Rack::ShowExceptions
#run App.new




















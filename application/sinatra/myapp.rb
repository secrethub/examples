# myapp.rb
require 'sinatra'

port = ENV['PORT'] || 4567
puts "STARTING SINATRA on port #{port}"
set :port, port
set :bind, '0.0.0.0'

if ENV['DEMO_USERNAME'] && ENV['DEMO_PASSWORD']
  status = 200
  content = "Welcome " + ENV['DEMO_USERNAME']
else
  status = 500
  content = 'not all variables are set'
end

get '/' do
  status status
  body content
end

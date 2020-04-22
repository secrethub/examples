class ApplicationController < ActionController::API
  def index
    if ENV['DEMO_USERNAME'] && ENV['DEMO_PASSWORD']
      render status: 200, html: "Welcome " + ENV['DEMO_USERNAME']
    else
      render status: 500, html: 'not all variables are set'
    end
  end
end

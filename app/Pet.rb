require "erb"
require './app/lib/controller'

class Pet
  include Controller
  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
    @health = 50
    @food = 50
    @energy = 50
    @happiness = 50
    @cleanness = 50
    #$stats = %w[health hunger sleeping stamina mood agility intelect purity speed]
  end

  #----------user actions----------
  def response
    case @request.path
    when '/'
      Rack::Response.new(render("create_pet.html.erb"))

    when '/initialize'
      Rack::Response.new do |response|
        response.set_cookie('health', @health)
        response.set_cookie('food', @food)
        response.set_cookie('energy', @energy)
        response.set_cookie('happiness', @happiness)
        response.set_cookie('cleanness', @cleanness)
        response.set_cookie('name', @request.params['name'])
        response.redirect('/start')
      end

    when '/exit'
      Rack::Response.new('Game Over', 404)
      Rack::Response.new(render("exit.html.erb"))

    when '/start'
      if get("health") <= 0 || get("energy") <= 0 || get("food") <= 0 || get("happiness") <= 0 || get("cleanness") <= 0
        Rack::Response.new('Game Over', 404)
        Rack::Response.new(render("game_over.html.erb"))
      elsif get("health") >= 100 || get("food") >= 100
        Rack::Response.new(render("win.html.erb"))
      else
        Rack::Response.new(render("index.html.erb"))
      end
    

    when '/change'
      return Controller.change_params(@request, 'health') if @request.params['health']
      return Controller.change_params(@request, 'food') if @request.params['food']
      return Controller.change_params(@request, 'energy') if @request.params['energy']
      return Controller.change_params(@request, 'happiness') if @request.params['happiness']
      return Controller.change_params(@request, 'cleanness') if @request.params['cleanness']
    else
      Rack::Response.new('Not Found', 404)
    end
  end

  def render(template)
    path = File.expand_path("../view/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end

  def name
    name = @request.cookies['name'].delete(' ')
    name.empty? ? 'Dulatan' : @request.cookies['name']
  end

  def get(attr)
    @request.cookies["#{attr}"].to_i
  end
end

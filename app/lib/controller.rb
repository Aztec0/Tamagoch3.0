module Controller
    def self.change_params(req, name)
      Rack::Response.new do |response|
        case name
        when 'health'
          response.set_cookie('health', req.cookies['health'].to_i + 1)
          response.set_cookie('food', req.cookies['food'].to_i + 10)
          response.set_cookie('energy', req.cookies['energy'].to_i - 5)
        when 'food'
          response.set_cookie('food', req.cookies['food'].to_i + 10)
          response.set_cookie('energy', req.cookies['energy'].to_i + 3)
          response.set_cookie('cleanness', req.cookies['cleanness'].to_i - 5)
        when 'energy'
          response.set_cookie('energy', req.cookies['energy'].to_i + 20)
          response.set_cookie('happiness', req.cookies['hapinness'].to_i + 10)
          response.set_cookie('health', req.cookies['health'].to_i - 5)
          response.set_cookie('cleanness', req.cookies['cleanness'].to_i - 5)
          response.set_cookie('food', req.cookies['food'].to_i - 5)
        when 'happiness'
          response.set_cookie('happiness', req.cookies['hapinness'].to_i + 10)
          response.set_cookie('cleanness', req.cookies['cleanness'].to_i - 5)
          response.set_cookie('sleep', req.cookies['cleanness'].to_i - 5)
  
        when 'cleanness'
          response.set_cookie('cleanness', req.cookies['cleanness'].to_i - 5)
          response.set_cookie('energy', req.cookies['energy'].to_i - 5)
          response.set_cookie('health', req.cookies['health'].to_i + 1)
        when 'spotting'
          response.set_cookie('sleep', req.cookies['sleep'].to_i + 10)
          response.set_cookie('stamina', req.cookies['stamina'].to_i + 10)
  
        end
  
        response.redirect('/start')
      end
    end
end
  
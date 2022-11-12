module Controller
    def self.change_params(req, name)
      Rack::Response.new do |response|
        case name
        when 'health'
          response.set_cookie('health', req.cookies['health'].to_i + rand(0..10))
          response.set_cookie('food', req.cookies['food'].to_i + rand(0..10))
          response.set_cookie('energy', req.cookies['energy'].to_i - rand(0..5))
        when 'food'
          response.set_cookie('food', req.cookies['food'].to_i + rand(0..10))
          response.set_cookie('cleanness', req.cookies['cleanness'].to_i - rand(0..10))
          response.set_cookie('energy', req.cookies['energy'].to_i - rand(0..5))
        when 'energy'
          response.set_cookie('energy', req.cookies['energy'].to_i + rand(0..20))
          response.set_cookie('happiness', req.cookies['happiness'].to_i - rand(0..10))
          response.set_cookie('health', req.cookies['health'].to_i + rand(-5..5))
          response.set_cookie('cleanness', req.cookies['cleanness'].to_i - rand(0..10))
          response.set_cookie('food', req.cookies['food'].to_i - rand(0..10))
        when 'happiness'
          response.set_cookie('happiness', req.cookies['happiness'].to_i + rand(0..10))
          response.set_cookie('cleanness', req.cookies['cleanness'].to_i - rand(0..5))
          response.set_cookie('energy', req.cookies['energy'].to_i - rand(0..5))
        when 'cleanness'
          response.set_cookie('cleanness', req.cookies['cleanness'].to_i + rand(0..10))
          response.set_cookie('health', req.cookies['health'].to_i + rand(0..10))
          response.set_cookie('energy', req.cookies['energy'].to_i - rand(0..5))
        when 'spotting'
            response.set_cookie('cleanness', req.cookies['cleanness'].to_i + rand(-10..10))
            response.set_cookie('energy', req.cookies['energy'].to_i + rand(-10..10))
            response.set_cookie('health', req.cookies['health'].to_i + rand(-10..10))  
            response.set_cookie('food', req.cookies['food'].to_i + rand(-10..10))
            response.set_cookie('happiness', req.cookies['happiness'].to_i + rand(-10..10))
        end
  
        response.redirect('/start')
      end
    end
end
  
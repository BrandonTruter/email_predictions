require 'erb'

class EmailPredictor
  
  def self.call(env)
    new(env).response.finish
  end
  
  def initialize(env)
    @request = Rack::Request.new(env)
  end
    
  def response
    case @request.path
    when '/' then Rack::Response.new(render("index.html.erb"))
    when '/search'
      Rack::Response.new do |response|
        fname = @request.params["first_name"]
        lname = @request.params["last_name"]
        domain = @request.params["domain"]
        name = "#{fname}, #{lname} @ #{domain}"
        response.set_cookie("greet", name)
        response.redirect("/")
      end
    else Rack::Response.new("Not Found", 404)  # ../../public/404.html
    end
  end
  
  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end
  
  def greet_name
    @request.cookies["greet"] || "Sovtech"
  end
  
end


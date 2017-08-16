require 'erb'

class App
  
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
    else Rack::Response.new(render_error("404.html"))
    # else Rack::Response.new("Not Found", 404)  # 
    end
  end
  
  def render(template)
    path = File.expand_path("../app/views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end
  
  def render_error(template)
    path = File.expand_path("../public/html/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end
  
  def greet_name
    @request.cookies["greet"] || "Sovtech"
    # (@request.params && @request.cookies["greet"]) ? @request.cookies["greet"] : "Sovtech"
  end
  
end


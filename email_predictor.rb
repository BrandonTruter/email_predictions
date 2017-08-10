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
        domain = @request.params["domain"]
        lname = @request.params["last_name"]
        fname = @request.params["first_name"]
        name = "#{fname} #{lname} @ #{domain.empty? ? 'Sovtech' : domain}"
        # name = (fname.present? && domain.present?) ? display_name : 'Sovtech'
        response.set_cookie("greet", name)
        response.redirect("/")
      end
    else Rack::Response.new(render_error("404.html"))
    # else Rack::Response.new("Not Found", 404)  # 
    end
  end
  
  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__)
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


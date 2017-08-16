require './app'


use Rack::Reloader, 0
# run EmailPredictor

run Rack::Cascade.new([Rack::File.new("./app/public"), App])
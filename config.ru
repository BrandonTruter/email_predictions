require './email_predictor'


use Rack::Reloader, 0
# run EmailPredictor

run Rack::Cascade.new([Rack::File.new("public"), EmailPredictor])
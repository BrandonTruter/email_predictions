require './email_predictor'

use Rack::Reloader, 0

run Rack::Cascade.new([Rack::File.new("public"), EmailPredictor])
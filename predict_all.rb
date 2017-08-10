require './lib/email_prediction'
require 'optparse'

def process_advisor(name, domain)
  prediction = EmailPrediction.new(name, domain)
  prediction.display_predictions
end

def process_all(name, domain)
  prediction = EmailPrediction.new(name, domain)
  prediction.display_all
end

def predict
  options = {}
  OptionParser.new do |opts|
    opts.on('-a', '--all all', Array, 'Display all existing predictions') do |a|
      options[:all] = ''
    end
  end.parse!

  if options[:all]
    process_all "", ""
  else
    process_advisor ARGV[0], ARGV[1]
  end
end

predict

require 'optparse'
require './lib/predict_email'

def process_advisor(name, domain)
  predictor = PredictEmail.new(name, domain)
  predictor.to_s
end

def process_all
  predictor = PredictEmail.new('', '')
  predictor.all
end

def process_default
  predictor = PredictEmail.new('', '')
  predictor.defaults
end

def process_with_email(emails)
  predictor = PredictEmail.new("Brandon Truter", emails)
  predictor.email_output
end

def process_test
  PredictEmail.new("Brandon Truter", "paydna.co.za")
end


def predict_default
  predictor = PredictEmail.new('', '')
  predictor.default_predictions
end


def predict
  options = {}
  OptionParser.new do |opts|
    opts.on('-t', '--test', Array, 'Test search') do
      options[:test] = ''
    end
    
    opts.on('-d', '--default', Array, 'Default search') do
      options[:default] = ''
    end
    
    opts.on('-a', '--all', Array, 'All search') do
      options[:all] = ''
    end
    
    opts.on('-e', '--email email', Array, 'Email search') do |e|
      options[:email] = e
    end
  end.parse!


  if options[:email]
    process_with_email options[:email]

  elsif options[:default]  
    predict_default
  
  elsif options[:all]  
    process_all
    
  elsif options[:test]
    process_test
  else
    if ARGV[0]
      process_advisor ARGV[0], ARGV[1]
    else
      process_default
    end
  end
end


predict


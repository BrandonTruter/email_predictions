require 'optparse'
require './lib/dependencies'

class Predictions
  
  def process_email(emails)
    emails.each {|email| puts "PREDICTION: #{email}"}
  end

  def process_test
    EmailPredictor.new("Test Second", "test.com")
  end

  def process_advisor(name, domain)
    EmailPredictor.new(name, domain)
  
    # prediction = EmailPrediction.new(name, domain)
    # prediction.display_predictions
  end

  def process_all(name, domain)
    EmailPredictor.new(name, domain, 'all')
  
    # prediction = EmailPrediction.new(name, domain)
    # prediction.display_all
  end


  def predict_all
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
  
  
  def run
    options = {}
    OptionParser.new do |opts|

      opts.on('-a', '--all all', Array, 'Use all possible predictions') do |a|
        options[:all] = a
      end
    
      opts.on('-t', '--test test', Array, 'Use a Test search') do |t|
        options[:test] = t
      end
    
      opts.on('-e', '--email email', Array, 'Search with a single email') do |e|
        options[:email] = e
      end
    end.parse!

    if options[:email]
      predict_with_email options[:email]
    elsif options[:test]
      process_test options[:email]  
    elsif options[:all]
      process_all ARGV[0], ARGV[1]
    else
      process_advisor ARGV[0], ARGV[1]
    end
  end
end

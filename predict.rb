require 'optparse'
require './lib/dependencies'

def process_advisor(name, domain)
  EmailPredictor.new(name, domain)
end

def process_all(name, domain)
  EmailPredictor.new(name, domain, 'all')
end

def process_test
  EmailPredictor.new("Test Second", "test.com")
end

def predict
  options = {}
  OptionParser.new do |opts|
    opts.on('-a', '--all all', Array, 'Use all possible predictions') do |a|
      options[:all] = a
    end
    opts.on('-t', '--test test', Array, 'Use a Test search') do |t|
      options[:test] = t
    end
  end.parse!

  if options[:test]
    process_test options[:email]  
  elsif options[:all]
    process_all ARGV[0], ARGV[1]
  else
    process_advisor ARGV[0], ARGV[1]
  end
end


predict


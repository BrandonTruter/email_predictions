class Predictor
  
  def process_advisor(name, domain)
    EmailPredictor.new(name, domain, '')
  end

  def process_all
    EmailPredictor.new('', '', 'all')
  end

  def process_default
    EmailPredictor.new('', '', 'default')
  end
  
  def process_none
    EmailPredictor.new('', '', 'none')
  end

  def run
    options = {}
    OptionParser.new do |opts|
      opts.on('-d', '--default', Array, 'Default search') do
        options[:default] = ''
      end
  
      opts.on('-a', '--all', Array, 'All search') do
        options[:all] = ''
      end
    end.parse!

    if options[:default]
      process_default
    elsif options[:all]  
      process_all
    else
      if ARGV[0] # && ARGV[1]
        process_advisor ARGV[0], ARGV[1]
      else
        process_none
      end
    end
  end
  
end


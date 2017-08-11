class Predictor  
  attr_accessor :data, :advisor, :name, :domain, :pattern
  
  def initialize(*params)
    @data = params
    load_defaults(params)
  end
  
  def load_defaults(params)
    self.data = @data
    @new_advisors = _new_advisors
    @existing_advisors = _set_existing
    
    if params.is_a?(Advisor)
      load_advisor
      
    elsif params.is_a?(Pattern)
      self.pattern = params
      puts "Pattern"
      # load_pattern
      
    else
      load_paramaters
    end
  end
  
  def predict_patterns(name, domain)
    pattern_predictions = []
    if name.include? (" ")
      fullname = name.split(" ")
      first_name = fullname[0].downcase
      last_name = fullname[1].downcase
      first_initial = first_name[0].downcase
      last_initial = last_name[0].downcase
      pattern_predictions << first_name_last_name if email == "#{first_name}.#{last_name}@#{domain}"
      pattern_predictions << first_name_last_initial if email == "#{first_name}.#{last_initial}@#{domain}"
      pattern_predictions << first_initial_last_name if email == "#{first_initial}.#{last_name}@#{domain}"
      pattern_predictions << first_initial_last_initial if email == "#{first_initial}.#{last_initial}@#{domain}"
    end
    pattern_predictions
  end
  
  def load_advisor
    puts "Advisor"
    self.advisor = @data
    @email = advisor.email
    @domain = advisor.domain
    @last_name = advisor.last_name
    @first_name = advisor.first_name
    @name = "#{@first_name} #{@last_name}"
    # [#<Advisor:0x007fa5a8be0988 @domain="apple.com", @last_name="jobs", @first_name="steve", @name="steve jobs">]
  end
  
  def run_all
    # 
  end
  
  def run_predictions
    load_patterns(advisor) if advisor
    generate_advisor(name, domain)
  end
  
  def load_pattern
    puts "Pattern"
    @pattern = Pattern.new(advisor)
    self.pattern.generate_patterns
  end
  
  def load_paramaters
    puts "PARAMS: #{@data}"
    @first_name = @data[0]
    @last_name = @data[1]
    @domain = @data[2]
    self.domain = @domain
    self.name = "#{@first_name} #{@last_name}"
  end
  
  def store_pattern(pattern)
    pattern = Pattern.new(pattern, name, domain)
    pattern.store_pattern(pattern)
  end
  
  def fetch_pattern(pattern, name, domain)
    pattern = Pattern.new(pattern, name, domain)
    pattern.fetch_pattern(pattern, name, domain)
  end

  def render_pattern
    @patterns.uniq.each {|pattern| puts pattern }
  end
  
  def predict_pattern
    company_collection = @existing_advisors.map { |advisor| parse_domain(advisor[1])}.uniq
    filter_companies(company_collection)
  end

  def generate_advisor(name, domain)
    @advisor = Advisor.new(name, domain)
    puts "Predicting advisor email ...."
    puts "#{name} ~> #{domain}"
    puts "...."
  end
  
  def to_s
    if @patterns
      @patterns.uniq.each {|predicted_pattern| puts predicted_pattern }
    else
      puts "No available predictions for #{display_name}"
    end
  end

  def name
    @name || "?"
  end
  
  def predicted?
    predict(@name, @domain)
  end

  private
  
  def _set_existing
     {
      "John Ferguson" => "john.ferguson@sovtech.com",
      "Damon Awsom" => "dd.awsom@sovtech.com",
      "Linda Li" => "linda.li@sovtech.com",
      "Larry Page" => "larry.p@google.com",
      "Sergey Brin" => "s.brin@google.com",
      "Steve Jobs" => "s.j@apple.com"
    }
  end
  
  def _new_advisors
    { "Peter Wong" => "alphasights.com",
      "Craig Silverstein" => "google.com",
      "Steve Wozniak" => "apple.com",
      "Barack Obama" => "whitehouse.gov"
    }
  end
end


=begin

  def filter_companies(*companies)
    companies.each do |company_name|
      if @domain.include? company_name
        get_patterns(company_name, companies)
      end
    end
  end
  
  def get_patterns(company_name, *advisors)
    advisors.each do |advisor|
      advisor_email = advisor[1]
      advisor_domain = find_domain(advisor_email)
      if advisor_domain == company_name
        @patterns << check_patterns(advisor[0], advisor_domain, advisor_email)
      end
    end
  end
  
  def check_patterns(name, domain, email)
    pattern_predictions = []
    if name.include? (" ")
      fullname = name.split(" ")
      first_name = fullname[0].downcase
      last_name = fullname[1].downcase
      first_initial = first_name[0].downcase
      last_initial = last_name[0].downcase
      pattern_predictions << first_name_last_name if email == "#{first_name}.#{last_name}@#{domain}"
      pattern_predictions << first_name_last_initial if email == "#{first_name}.#{last_initial}@#{domain}"
      pattern_predictions << first_initial_last_name if email == "#{first_initial}.#{last_name}@#{domain}"
      pattern_predictions << first_initial_last_initial if email == "#{first_initial}.#{last_initial}@#{domain}"
    end
    pattern_predictions
  end
  
  def create_all_predictions
    @domain.reduce([]) do |predictions, domain|
      substitute_pattern_placeholders_with_correct_values(domain)
      separate_each_prediction(predictions)
    end
  end

  def separate_each_prediction(predictions)
    predictions << @prediction_patterns.split("\n")
    predictions.flatten
  end
  
=end


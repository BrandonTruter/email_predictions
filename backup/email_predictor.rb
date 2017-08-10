class EmailPredictor
  attr_accessor :advisor, :pattern, :predictions

  def initialize(name='', domain='')
    unless name.present? && domain.present?
      load_default_prediction
    else
      load_instance_variables(name, domain)
    end
  end

  def do_predictions(first_name, last_name, domain)
    name_predictions = <<PATTERN
      {first_name}.{last_name}
      {first_initial}.{last_name}
      {first_name}.{last_initial}
      {first_initial}.{last_initial}
PATTERN

    predictions = name_predictions.gsub('{first_name}', first_name).gsub('{last_name}', last_name).gsub('{first_initial}', first_name[0]).gsub('{last_initial}', last_name[0]).split($/)

    domain = ['@'].product domain.split
    name_and_domains = predictions.product domain
    name_predictions = name_and_domains.map {|email| email.join }
  end

  def predict_all
    @predictions = []
    puts "Available options for"
    companies = @old_advisors.map { |advisor| find_domain(advisor[1]) }.uniq
    companies.each do |company_name|
      @new_advisors.each do |name, email|
        domain = find_domain(email)
        if domain == company_name
          if name.include? (" ")
            fullname = name.split(" ")
            first_name = fullname[0].downcase
            last_name = fullname[1].downcase
            first_initial = first_name[0].downcase
            last_initial = last_name[0].downcase
            domain = email.rpartition(?@).last.rpartition(?.).first
            first_name_last_name = "#{first_name}.#{last_name}@#{domain}"
            first_name_last_initial = "#{first_name}.#{last_initial}@#{domain}"
            first_initial_last_name = "#{first_initial}.#{last_name}@#{domain}"
            first_initial_last_initial = "#{first_initial}.#{last_initial}@#{domain}"
            @predictions << first_name_last_name if email == first_name_last_name
            @predictions << first_name_last_initial if email == first_name_last_initial
            @predictions << first_initial_last_name if email == first_initial_last_name
            @predictions << first_initial_last_initial if email == first_initial_last_initial
          end
        end
      end
    end
    @predictions.each {|prediction| puts prediction }
  end
  
  def check_patterns(*advisors)
    advisors.each do |advisor|
      email = advisor[1]
      domain = email.rpartition(?@).last.rpartition(?.).first
      predict_patterns(advisor[0], domain, email)
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
  
  def load_patterns
    @pattern = Pattern.new(advisor)
    self.pattern.generate_patterns
  end
  
  def all_predictions
    predict_all
  end
  
  def predict_all
    predictor = Predictor.new(@first_name, @last_name, @domain)
    # predictions = predictor.create_all_predictions
    predictor.run_all
  end
  
  private
  
  def find_domain(email)
    email.rpartition(?@).last.rpartition(?.).first
  end
  
  def load_default_prediction
    @old_advisors = { "John Ferguson" => "john.ferguson@alphasights.com",
                      "Damon Aw" => "damon.aw@alphasights.com",
                      "Linda Li" => "linda.li@alphasights.com",
                      "Larry Page" => "larry.p@google.com",
                      "Sergey Brin" => "s.brin@google.com",
                      "Steve Jobs" => "s.j@apple.com" 
                    }
                    
    @new_advisors = { "Peter Wong" => "alphasights.com",
                      "Craig Silverstein" => "google.com",
                      "Steve Wozniak" => "apple.com",
                      "Barack Obama" => "whitehouse.gov" 
                    }
  end
  
  private_class_method
  
  def load_instance_variables(name, domain)
    @advisor = Advisor.new(name, domain)
    @domain = domain
    @name = name
    if name.include? (" ")
      fullname = name.split(" ")
      @first_name = fullname[0].downcase
      @last_name = fullname[1].downcase
      @first_initial = @first_name[0].chars.first
      @last_initial = @last_name[0].chars.first
    end
  end
  
end

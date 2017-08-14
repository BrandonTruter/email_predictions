class EmailPredictor
  
  def initialize(name, domain, type='none')
    load_instance_variables(name, domain)
    generate_prediction(type)
  end
  
  def load_instance_variables(name, domain)
    @name = name
    @domain = domain
    if @name.include? (" ")
      fullname = name.split(" ")
      @first_name = fullname[0].downcase
      @last_name = fullname[1].downcase
      @first_initial = @first_name[0].downcase
      @last_initial = @last_name[0].downcase
    end
    @patterns = []
    @existing_advisors = _existing_advisors
    @company_names = @existing_advisors.map { |advisor| retrieve_domain(advisor[1])}.uniq
  end
  
  def generate_prediction(type)
    case type
    when 'all'
      process_all
    when 'none'
      process_unknown
    when 'default'
      process_defaults
    else
      process_advisor
    end
  end
  
  def process_unknown
    puts ""
    puts "unknown request (invalid args)"
    puts ""
    puts "Processing defaults"
    process_defaults
  end
  
  # Predicting ALL Advisors
  
  def process_all
    @all_patterns = []
    _existing_advisors.each do |name, email|
      domain = find_domain(email)
      if name.include? (" ")
        fullname = name.split(" ")
        first_name = fullname[0].downcase
        last_name = fullname[1].downcase
        first_initial = first_name[0].downcase
        last_initial = last_name[0].downcase
      end

      pattern_predictions = []
      pattern_predictions << "#{first_name}.#{last_name}@#{domain}"
      pattern_predictions << "#{first_name}.#{last_initial}@#{domain}"
      pattern_predictions << "#{first_initial}.#{last_name}@#{domain}"
      pattern_predictions << "#{first_initial}.#{last_initial}@#{domain}"
    
      @all_patterns << [pattern_predictions, name]
    end
    
    display_all
  end
  
  def display_all
    puts ""
    puts "Running all predictions"
    puts ""
    puts ""
    @all_patterns.each do |predictions, name|
      puts "... #{name} ..."
      puts ""
      predictions.each {|predicted_patterns| puts "#{predicted_patterns}.com" }
      puts ""
    end
    puts ""
  end
  
  
  # Predicting Default Advisors
  
  def process_defaults
    @default_patterns = []
  
    _new_advisors.each do |advisor_name, advisor_domain|
      advisor_company = find_domain(advisor_domain)
      if advisor_name.include? (" ")
        fullname = advisor_name.split(" ")
        advisor_first_name = fullname[0].downcase
        advisor_last_name = fullname[1].downcase
        advisor_first_initial = advisor_first_name[0].downcase
        advisor_last_initial = advisor_last_name[0].downcase
      end

      _existing_advisors.each do |name, email|
        company_name = find_domain(email)
        if advisor_company == company_name
          if name.include? (" ")
            fullname = name.split(" ")
            first_name = fullname[0].downcase
            last_name = fullname[1].downcase
            first_initial = first_name[0].downcase
            last_initial = last_name[0].downcase
          end

          prediction = ""
          first_name_last_name = "#{advisor_first_name}.#{advisor_last_name}@#{company_name}"
          first_name_last_initial = "#{advisor_first_name}.#{advisor_last_initial}@#{company_name}"
          first_initial_last_name = "#{advisor_first_initial}.#{advisor_last_name}@#{company_name}"
          first_initial_last_initial = "#{advisor_first_initial}.#{advisor_last_initial}@#{company_name}"
          prediction = first_name_last_name if email == "#{first_name}.#{last_name}@#{company_name}.com"
          prediction = first_name_last_initial if email == "#{first_name}.#{last_initial}@#{company_name}.com"
          prediction = first_initial_last_name if email == "#{first_initial}.#{last_name}@#{company_name}.com"
          prediction = first_initial_last_initial if email == "#{first_initial}.#{last_initial}@#{company_name}.com"
                    
          @default_patterns << prediction unless prediction == @default_patterns.last
        end
      end
    end
    
    display_defaults
  end
  
  def display_defaults
    puts ""
    puts "Default Predictions"
    @default_patterns.each do |predicted_pattern|
      puts ""
      puts "#{predicted_pattern}.com"
      puts "..."
    end
    puts ""
  end
  
  
  # Predicting Filtered Advisors
  
  def process_advisor
    @advisor = Advisors.new(@name, @domain)
    check_patterns
    display_predictions
  end
  
  def check_patterns
    matching_domain = false
    
    @company_names.each do |company_name|
      if @domain.include? company_name
        @company = company_name
        matching_domain = true
      end
    end
    
    if matching_domain
      @existing_advisors.each do |advisor|
        advisor_name = advisor[0]
        advisor_email = advisor[1]
        advisor_company = find_domain(advisor_email)
        if advisor_company == @company
          @patterns << predict_patterns(advisor_name, advisor_company, advisor_email)
        end
      end
    end
  end
  
  def predict_patterns(name, domain, email)
    if name.include? (" ")
      fullname = name.split(" ")
      first_name = fullname[0].downcase
      last_name = fullname[1].downcase
      first_initial = first_name[0].downcase
      last_initial = last_name[0].downcase
    end
    pattern_predictions = []
    pattern_predictions << first_name_last_name if email == "#{first_name}.#{last_name}@#{@domain}"
    pattern_predictions << first_name_last_initial if email == "#{first_name}.#{last_initial}@#{@domain}"
    pattern_predictions << first_initial_last_name if email == "#{first_initial}.#{last_name}@#{@domain}"
    pattern_predictions << first_initial_last_initial if email == "#{first_initial}.#{last_initial}@#{@domain}"
    
    @no_prediction = pattern_predictions.empty? ? true : false
    
    pattern_predictions
  end
  
  def display_predictions
    if @no_prediction
      empty_prediction
    else
      @patterns.uniq.each {|predicted_pattern| puts predicted_pattern }
    end
  end
    
    
  private
  
  def retrieve_domain(email)
    email.rpartition(?@).last.rpartition(?.).first
  end
  
  def to_s
    if @patterns
      @patterns.uniq.each {|predicted_pattern| puts predicted_pattern }
    else
      puts "No available predictions for #{display_name}"
    end
  end
  
  def existing_domain?
    existing_advisor = false
    companies = @existing_advisors.map { |advisor| advisor[1].rpartition(?@).last.rpartition(?.).first }.uniq
    companies.each do |company_name|
      if @domain.include? company_name
        existing_advisor = true
        @company = company_name
      end
    end
    return existing_advisor
  end

  def display_name
    "#{@name}, #{@domain}"
  end
  
  def find_domain(email)
    email.rpartition(?@).last.rpartition(?.).first
  end

  def first_name_last_name
    "#{@first_name}.#{@last_name}@#{@domain}"
  end

  def first_name_last_initial
    "#{@first_name}.#{@last_initial}@#{@domain}"
  end
  
  def first_initial_last_name
    "#{@first_initial}.#{@last_name}@#{@domain}"
  end

  def first_initial_last_initial
    "#{@first_initial}.#{@last_initial}@#{@domain}"
  end
  
  def _existing_advisors
     {
       "John Ferguson" => "john.ferguson@sovtech.com", 
       "Damon Aw" => "damon.aw@sovtech.com",
       "Linda Li" => "linda.li@sovtech.com",
       "Larry Page" => "larry.p@google.com",
       "Sergey Brin" => "s.brin@google.com",
       "Steve Jobs" => "s.j@apple.com"
    }
  end
  
  def _new_advisors
    { "Peter Wong" => "sovtech.com",
      "Craig Silverstein" => "google.com",
      "Steve Wozniak" => "apple.com",
      "Barack Obama" => "whitehouse.gov"
    }
  end
  
end
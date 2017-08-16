class EmailPredictor
  
  def initialize(name, domain)
    load_instance_variables(name, domain)
    generate_predictions
    display_predictions
  end
  
  def load_instance_variables(name, domain)
    @name = name
    @domain = domain
    @patterns = []
    if @name.include? (" ")
      fullname = name.split(" ")
      @first_name = fullname[0].downcase
      @last_name = fullname[1].downcase
      @first_initial = @first_name[0].downcase
      @last_initial = @last_name[0].downcase
    end
    @existing_advisors = _existing_advisors
    @company_names = @existing_advisors.map { |advisor| retrieve_domain(advisor[1])}.uniq
  end
  
  def generate_predictions
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
    puts ""
    if @no_prediction
      puts "No available predictions"
    else
      @patterns.uniq.each {|predicted_pattern| puts predicted_pattern }
    end
    puts ""
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
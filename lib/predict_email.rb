require_relative './advisor'
# require './advisor'

class PredictEmail
  
  def initialize(name, domain, type='none')
    generate_advisor(name, domain)
    generate_prediction(type)
  end
  
  def generate_advisor(name, domain)
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
    
    @existing_advisors = {
      "John Ferguson" => "john.ferguson@sovtech.com",
      "Damon Awsom" => "dd.awsom@sovtech.com",
      "Linda Li" => "linda.li@sovtech.com",
      "Larry Page" => "larry.p@google.com",
      "Sergey Brin" => "s.brin@google.com",
      "Steve Jobs" => "s.j@apple.com"
    }
    
    @advisor = Advisor.new(@name, @domain)
    puts "Predicting email for: #{@name} ~> #{@domain} ...."
  end


  def email_output(*emails)
    emails.each {|email| puts "PREDICTION: #{email}"}
  end

  def existing_domain?
    existing_advisor = false
    companies = @existing_advisors.map { |advisor| advisor[1].rpartition(?@).last.rpartition(?.).first }.uniq
    companies.each do |company_name|
      if @domain.include? company_name
        existing_advisor = true
        @company = company_name
      end
      # existing_advisor = true if @domain.include? company_name
    end
    return existing_advisor
  end
  
  
  def generate_prediction(type)
    if type == 'all'
      default_patterns
      
    elsif type == 'default'
      default_predictions
      
    else
      if existing_domain?
        predicted_patterns 
      else
        default_patterns
      end
    end
  end

  def predicted_patterns
    @existing_advisors.each do |advisor|
      advisor_name = advisor[0]
      advisor_email = advisor[1]
      advisor_company = find_domain(advisor_email)
      if advisor_company == @company
        @patterns << check_patterns(advisor_name, advisor_company, advisor_email)
      end
    end
    # render_predictions
    # @patterns.uniq.each {|predicted_pattern| puts predicted_pattern }
  end
  
  
  def check_patterns(name, domain, email)
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
    pattern_predictions
  end
  
  
  def all
    # patterns = []
    new_advisors = {"Peter Wong" => "alphasights.com",
                    "Craig Silverstein" => "google.com",
                    "Steve Wozniak" => "apple.com",
                    "Barack Obama" => "whitehouse.gov"}
    new_advisors.each do |advisor| 
      name = advisor[0]
      email = advisor[1]
      domain = find_domain(email)
      puts "Processing: #{name}, #{email}, #{domain}"
      # patterns << check_patterns(name, email, domain)
      # patterns << PatternDetector.new(name, email, domain)
    end
    # patterns.each {|predicted_email| puts predicted_email}
  end
  
  
  def to_s
    if @patterns
      @patterns.uniq.each {|predicted_pattern| puts predicted_pattern }
    else
      puts "No available predictions for #{display_name}"
    end
  end
  
  def defaults
     puts ""
     puts "processing ...."
     puts ""
     
     # Peter Wong @ alphasights.com
     # ...
     # peter.wong@alphasights.com
     #
     # Craig Silverstein @ google.com
     # ...
     # craig.s@google.com
     # c.silverstein@google.com
     #
     # Steve Wozniak @ apple.com
     # ...
     # s.w@apple.com
     #
     # Barack Obama @ whitehouse.gov
     # ...
     # No prediction was possible
     
  end
  
  
  def default_predictions
    puts ""
    puts "processing ...."
    puts ""
    
  end
  
  
  private
  
  def display_name
    "#{@name}, #{@domain}"
  end
  
  def find_domain(email)
    email.rpartition(?@).last.rpartition(?.).first
  end

  def default_patterns
    @patterns = []
    @patterns << first_name_last_name
    @patterns << first_name_last_initial
    @patterns << first_initial_last_name
    @patterns << first_initial_last_initial
    @patterns.each {|predicted_email| puts predicted_email}
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
  
  def generate_existing_advisors
    @existing_advisors = {
      "John Ferguson" => "john.ferguson@sovtech.com",
      "Damon Awsom" => "dd.awsom@sovtech.com",
      "Linda Li" => "linda.li@sovtech.com",
      "Larry Page" => "larry.p@google.com",
      "Sergey Brin" => "s.brin@google.com",
      "Steve Jobs" => "s.j@apple.com"
    }
  end
  
end


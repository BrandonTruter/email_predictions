class EmailPredictor
  
  def initialize(name, domain, type='none')
    generate_variables(name, domain)
    generate_existing_advisors
    generate_prediction(type)
  end
  
  def generate_variables(name, domain)
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
    @advisor = Advisor.new(@name, @domain)
    detailed_output
  end
  
  def detailed_output
    puts "________________________________________"
    puts ""
    puts "........ #{@name} ; #{@domain} ........"
    puts "...................................................."
    puts ""
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

  def generate_prediction(type)
    if type == 'all'
      default_patterns
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
    render_predictions
  end
  
  def render_predictions
    @patterns.uniq.each do |predicted_pattern|
      puts predicted_pattern
    end
  end
  
  def valid_email?(email_address)
    !!(email_address =~ /.+\@.+\..+/)
  end

  def get_domain(email_address)
    email_address.gsub(/.+@([^.]+).+/, '\1') 
  end

  def check_patterns(name, domain, email)
    pattern_types = []
    pattern_predictions = []
    if name.include? (" ")
      fullname = name.split(" ")
      first_name = fullname[0].downcase
      last_name = fullname[1].downcase
      first_initial = first_name[0].downcase
      last_initial = last_name[0].downcase
      pattern_predictions << first_name_last_name if email ==  "#{first_name}.#{last_name}@#{@domain}"
      pattern_predictions << first_name_last_initial if email ==  "#{first_name}.#{last_initial}@#{@domain}"
      pattern_predictions << first_initial_last_name if email ==  "#{first_initial}.#{last_name}@#{@domain}"
      pattern_predictions << first_initial_last_initial if email ==  "#{first_initial}.#{last_initial}@#{@domain}"
    end
    pattern_predictions
  end  
  
  def default_patterns
    @patterns = []
    @patterns << first_name_last_name
    @patterns << first_name_last_initial
    @patterns << first_initial_last_name
    @patterns << first_initial_last_initial
    @patterns.each {|predicted_email| puts predicted_email}
  end
  
  def do_predicted_emails
    predicted_patterns = []
    @existing_advisors.each do |advisor|
      advisor_name = advisor[0]
      advisor_email = advisor[1]
      advisor_company = find_domain(advisor_email)
      if advisor_company == @company
        @pattern = PatternDetector.new(advisor_name, advisor_email, advisor_company)
        predicted_patterns << @pattern.to_s
      end
    end
    predicted_pattern || @pattern.each {|predicted_pattern| predicted_pattern.to_s }
  end
  
  def find_domain(email)
    email.rpartition(?@).last.rpartition(?.).first
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
  
  def display_results
    if @patterns.empty?
      @patterns = []
      @patterns << first_name_last_name
      @patterns << first_name_last_initial
      @patterns << first_initial_last_name
      @patterns << first_initial_last_initial
    end
    @patterns.each {|predicted_email| puts predicted_email}
  end
  
  private
  
  def to_s
    puts "ADVISOR: #{display_name}"    
  end
  
  def display_name
    "#{@name}, #{@domain}"
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
end
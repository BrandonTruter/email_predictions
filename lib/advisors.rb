class Advisors
  attr_accessor :name, :first_name, :last_name, :domain, :patterns, :client_base 
  
  def initialize(name, domain)
    load_defaults(name, domain)
  end
  
  def find_all(*advisors)
    advisors.each {|advisor| find(advisor[0], advisor[1]) }
    display_patterns
  end
  
  def find(name, email)
    @patterns = []
    if name.include? (" ")
      fullname = name.downcase.split(" ")
      first_name = fullname[0].downcase
      last_name = fullname[1].downcase
      self.first_name = first_name
      self.last_name = last_name
      self.name = fullname
      advisor_domain = find_domain(email)
      self.domain = advisor_domain
      companies = @existing_advisors.map { |advisor| find_domain(advisor[1]) }.uniq
      companies.each do |company_name|
        if @domain.include? company_name
          check_patterns(company_name, companies)
        end
      end
    end
  end
  
  def check_patterns(company_name, *advisors)
    advisors.each do |advisor|
      advisor_email = advisor[1]
      advisor_domain = find_domain(advisor_email)
      if advisor_domain == company_name
        @patterns << predict_patterns(advisor[0], advisor_domain, advisor_email)
      end
    end
  end

  def predict_patterns(name, domain, email)
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
    self.patterns = pattern_predictions
    pattern_predictions
  end
  
  def load_defaults(name, domain)
    @domain = domain
    @last_name = last_name
    @first_name = first_name
    @name = "#{first_name} #{last_name}"
    @existing_advisors = _existing_advisors
    @new_advisors = _new_advisors
    set_defaults
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

  def find_domain(email)
    email.rpartition(?@).last.rpartition(?.).first
  end
  
  def find_domain(email)
    email.rpartition(?@).last.rpartition(?.).first
  end
  
  def parse_domain(email)
    email.rpartition(?@).last.rpartition(?.).first
  end
  
  def set_defaults
    self.client_base = @existing_advisors
    self.first_name = @first_name
    self.last_name = @last_name
    self.domain = @domain
    self.name = @name
  end
  
  private
  
  def valid?
    (@name.present? || @domain.present?) ? true : false 
  end
  
  def display_patterns
    @patterns.each {|predicted_patterns| puts predicted_patterns }
  end
  
  def to_s
    _existing_advisors.each { |advisor| puts "Existing Advisors: #{advisor}" }
  end
  
  def _existing_advisors
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

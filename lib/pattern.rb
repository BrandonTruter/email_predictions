class Pattern
  attr_accessor :patterns  
  attr_reader :advisor
  
  def initialize(advisor)
    preload_data
  end
  
  def preload_data
    @patterns = {}
    @existing_advisors = advisor.fetch_existing
  end
  
  def predict_patterns(name, domain, email)
    @name = name
    @email = email
    @domain = domain
    if name.include? (" ")
      fullname = name.split(" ")
      first_name = fullname[0].downcase
      last_name = fullname[1].downcase
      first_initial = first_name[0].downcase
      last_initial = last_name[0].downcase
      @first_name_last_name = "#{first_name}.#{last_name}@#{domain}"
      @first_name_last_initial = "#{first_name}.#{last_initial}@#{domain}"
      @first_initial_last_name = "#{first_initial}.#{last_name}@#{domain}"
      @first_initial_last_initial = "#{first_initial}.#{last_initial}@#{domain}"
    end
    assign_patterns
  end
  
  def patterns(fname, lname, domain)
    both_names = Proc.new { |pattern| pattern == "#{fname}.#{lname}@#{domain}" }
    both_initials = Proc.new { |pattern| pattern == "#{fname[0]}.#{lname[0]}@#{domain}" }
    first_name_last_initial = Proc.new { |pattern| pattern == "#{fname}.#{lname[0]}@#{domain}" }
    first_initial_last_name = Proc.new { |pattern| pattern == "#{fname[0]}.#{lname}@#{domain}" }
  end
  
  def assign_patterns
    pattern_predictions = []
    pattern_predictions << @first_name_last_name if @email == @first_name_last_name
    pattern_predictions << @first_name_last_initial if @email == @first_name_last_initial
    pattern_predictions << @first_initial_last_name if @email == @first_initial_last_name
    pattern_predictions << @first_initial_last_initial if @email == @first_initial_last_initial
    pattern_predictions
  end
  
  def generate_patterns
    @existing_advisors.each do |name, email|
      advisor.find(name, email)
      patterns[advisor.domain] ||= advisor.patterns
      patterns[advisor.domain] += advisor.patterns
      patterns[advisor.domain].uniq!
    end
  end
  
  def load_default_patterns
    @patterns = []
    @patterns << first_and_last_name
    @patterns << first_and_last_initial
    @patterns << first_name_last_initial
    @patterns << first_initial_last_name
  end

  def store_pattern(pattern)
    case pattern
    when 'first_and_last_name'
      first_and_last_name
    when 'first_and_last_initial'  
      first_and_last_initial
    when 'first_name_last_initial'
      first_name_last_initial
    when 'first_initial_last_name'  
      first_initial_last_name
    else
      name_and_domain
    end
  end
  
  def add_patterns(pattern)
    # add ability to easily add additional patterns
  end
  
  private
  
  def invalid_pattern
    "No Pattern to use or display"
  end  
  
  def first_and_last_name
    "#{@first_name}.#{@last_name}@#{@domain}"
  end

  def first_and_last_initial
    "#{@first_initial}.#{@last_initial}@#{@domain}"
  end
  
  def first_name_last_initial
    "#{@first_name}.#{@last_initial}@#{@domain}"
  end

  def first_initial_last_name
    "#{@first_initial}.#{@last_name}@#{@domain}"
  end
  
  def name_and_domain
    "#{@name.nil? ? 'test name' : @name}@#{@domain.nil? ? '@test.com' : @domain}"
  end
  
  def to_s
    display_pattern
  end
  
  def valid?
    @pattern.present?
  end
  
  def display_pattern
    @pattern || "?"
  end
    
end
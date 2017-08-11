class EmailPrediction
  def initialize(name, domain)
    @domain = domain
    _default_variables(name)
    _default_advisors
    _default_patterns
  end
  
  def _default_variables(name)
    @name = name
    if name.include? (" ")
      fullname = name.split(" ")
      @first_name = fullname[0].downcase
      @last_name = fullname[1].downcase
      @first_initial = @first_name[0].downcase
      @last_initial = @last_name[0].downcase
    end
  end
  
  def _default_advisors
    @existing_advisors = [
      {name: "John Ferguson", email: "john.ferguson@sovtech.com"},
      {name: "Damon Aw", email: "damon.aw@sovtech.com"},
      {name: "Linda Li", email: "linda.li@sovtech.com"},
      {name: "Larry Page", email: "larry.p@google.com"},
      {name: "Sergey Brin", email: "s.brin@google.com"},
      {name: "Steve Jobs", email: "s.j@apple.com"}
    ]
  end
  
  def _default_patterns
    @patterns = []
    @patterns << first_name_last_name
    @patterns << first_name_last_initial
    @patterns << first_initial_last_name
    @patterns << first_initial_last_initial
  end
  
  def display_predictions
    @patterns.each {|predicted_email| puts predicted_email}
  end
  
  def display_all
    @existing_advisors.each {|advisor| puts advisor[:email] }
  end
  
  def to_s
    display_name
  end
  
  private
  
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

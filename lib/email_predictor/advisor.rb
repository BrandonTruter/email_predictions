class Advisor
  attr_accessor :name, :domain

  def initialize(name, domain)
    generate_attributes(name, domain)
    set_attributes
  end
  
  def generate_attributes(name, domain)
    @name = name
    @domain = domain
  end
  
  def set_attributes
    self.name = @name
    self.domain = @domain
  end
  
  def to_s
    "#{@name}, #{@domain}"
  end
  
  def to_email
    generate_predictions
  end
  
  def first_name_dot_last_name
    "#{@first_name}.#{@last_name}@#{@domain}"
  end
  
  def first_initial_dot_last_name
    "#{@first_initial}.#{@last_name}@#{@domain}"
  end
  
  def generate_predictions
    if @name.include? (" ")
      fullname = @name.split(" ")
      
      @first_name = fullname[0].downcase
      @last_name = fullname[1].downcase
      
      @first_initial = @first_name[0]
      @last_initial = @last_name[0]
      
      first_name_dot_last_name
      first_initial_dot_last_name
    end
  end
  
  def help

    # advisor = Advisor.new("John Ferguson", "sovtech.com")
    # => #<Advisor:0x007fca725e9ab8 @domain="sovtech.com", @name="John Ferguson">

    # advisor.name
    # => "John Ferguson"

    # advisor.domain
    # => "sovtech.com"

    # advisor.to_s
    # => "John Ferguson, sovtech.com"

    # advisor.to_email
    # => "j.ferguson@sovtech.com"
  end
end

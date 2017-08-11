class Matcher
  
  def self.call(first_name, last_name, *domain)
    new(first_name, last_name, domain).call
  end

  def initialize(first_name, last_name, domain)
    @first_name = first_name
    @last_name = last_name
    @domain = domain.flatten
    @first_initial = first_name.chars.first
    @last_initial = last_name.chars.first
  end

  def call
    predictions = create_all_predictions
    predictions
  end

  private

  def create_all_predictions
    @domain.reduce([]) do |predictions, domain|
      substitute_pattern_placeholders_with_correct_values(domain)
      separate_each_prediction(predictions)
    end
  end

  def substitute_pattern_placeholders_with_correct_values(domain)
    PATTERNS = <<PATTERN
      {first_name}.{last_name}
      {first_initial}.{last_name}
      {first_name}.{last_initial}
      {first_initial}.{last_initial}
PATTERN
    @prediction_patterns = PATTERNS.dup
    substitute_every_pattern_placeholder_except_domain
    @prediction_patterns.gsub!('{domain}', domain)
  end

  def substitute_every_pattern_placeholder_except_domain
    all_instance_variables_except_domain.each do |var|
      @prediction_patterns.gsub!(placeholder(var), value_of(var))
    end
  end

  def all_instance_variables_except_domain
    instance_variables.dup - [:@domain]
  end

  def placeholder(var)
    "{#{var.to_s[1..-1]}}"
  end

  def value_of(var)
    instance_variable_get("@#{var[1..-1]}".to_sym)
  end

  def separate_each_prediction(predictions)
    predictions << @prediction_patterns.split("\n")
    predictions.flatten
  end
end
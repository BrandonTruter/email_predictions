require 'factory_girl'

FactoryGirl.define do
  factory :advisor do
    name 'Steve Jobs'
    first_name 'steve'
    last_name 'jobs'
    domain 'apple.com'
  end
  
  factory :test_advisor do
    name 'John Doe'
    domain 'gmail.com'
  end
end
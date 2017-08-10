require 'spec_helper'

RSpec.describe Advisor do

  # let(:advisor) { Advisor.new('steve', 'jobs', 'apple.com') }
  
  let(:predictor) { Predictor.new(advisor) }


  # Using factories
  
  # Returns a User instance that's not saved
  user = build(:advisor)

  # Returns a saved User instance
  user = create(:advisor)

  # Returns a hash of attributes that can be used to build a User instance
  attrs = attributes_for(:advisor)
  

  
  describe "predicts with advisors" do
    it "first_name_and_last_name pattern" do
      prediction = predictor.store_pattern('first_name_and_last_name')
      expect(prediction).to eq(first_and_last_initial)
    end
    
    it "first_and_last_initial pattern" do
      prediction = predictor.store_pattern('first_and_last_initial')
      expect(prediction).to eq(first_and_last_initial)
    end
  end
  
  describe "correct predicts advisor email address patterns" do
    it "predicts first_name_dot_last_name" do
      expect(prediction.first_name_dot_last_name).to eq("john.ferguson@sovtech.com")
    end
  
    it "predicts first_name_dot_last_name" do
      expect(prediction.first_name_dot_last_initial).to eq("john.f@sovtech.com")
    end
  
    it "predicts first_name_dot_last_name" do
      expect(prediction.first_initial_dot_last_name).to eq("j.ferguson@sovtech.com")
    end

    it "predicts first_name_dot_last_name" do
      expect(prediction.first_initial_dot_last_initial).to eq("j.f@sovtech.com")
    end
  end
  
end
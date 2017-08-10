require "email_predictor"

RSpec.describe Pattern do
  # let(:advisor) { Advisor.new(name, "sovtech.com") }
  
  
  describe "predicts with patterns" do
    # let(:predictor) { Predictor.new( Pattern.new('first_and_last_initial') ) }
    # let(:pattern) { Pattern.new('first_and_last_initial') }
    
    let(:pattern) { Pattern.new('first_and_last_initial') }
    let(:predictor) { Predictor.new(pattern) }
    
    
    it "first_and_last_initial pattern" do
      prediction = predictor.fetch_pattern('first_name_and_last_name', 'steve jobs', 'apple.com')
      expect(prediction).to be_predicted
    end
    
    it "first_and_last_initial pattern" do
      # prediction = predictor.fetch_pattern('first_and_last_initial')
      prediction = predictor.fetch_pattern('first_and_last_initial', 'steve jobs', 'apple.com')
      expect(prediction).to be_predicted
    end
  end
  
  
  describe 'matching patterns' do
    
    let(:prediction) { "Peter Wong" }  

    it "first_name_last_name" do
      expect(prediction).to start_with("Peter").and end_with("Wong")
    end
  
    it "first_name_last_initial" do
      expect(prediction).to start_with("Peter").and end_with("W")
    end
  
    it "first_initial_last_name" do
      expect(prediction).to start_with("P").and end_with("Wong")
    end
  
    it "first_initial_last_initial" do
      expect(prediction).to start_with("P").and end_with("W")
    end
    
  end

end



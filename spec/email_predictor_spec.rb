require 'spec_helper'

RSpec.describe EmailPredictor do
  let(:first_name) { 'steve' }
  let(:last_name) { 'jobs' }
  let(:domain) { 'apple.com' }
  let(:advisor) { Advisor.new(first_name, last_name, domain) }
  let(:predictor) { Predictor.new(first_name, last_name, domain) }
  
  describe "#attributes" do
    it "correctly displays name" do
      expect(predictor.name).to start_with("steve").and end_with("jobs")
    end
  end
  
    # def first_and_last_name
    #   'steve.jobs@apple.com'
    # end
  
    # def first_and_last_initial
    #   "s.j@apple.com"
    # end
    
  # describe "predicts with parameters" do
  #   let(:predictor) { Predictor.new('steve', 'jobs', 'apple.com') }
  #
  #   it "first_name_and_last_name pattern" do
  #     prediction = predictor.store_pattern('first_and_last_name')
  #     expect(prediction).to eq(first_and_last_initial)
  #   end
  #
  #   it "first_and_last_initial pattern" do
  #     prediction = predictor.store_pattern('first_and_last_initial')
  #     expect(prediction).to eq(first_and_last_initial)
  #   end
  # end
  
  # describe "predicts with advisors" do
  #   let(:predictor) { Predictor.new(advisor) }
  #
  #   it "first_name_and_last_name pattern" do
  #     prediction = predictor.store_pattern('first_name_and_last_name')
  #     expect(prediction).to eq(first_and_last_initial)
  #   end
  #
  #   it "first_and_last_initial pattern" do
  #     prediction = predictor.store_pattern('first_and_last_initial')
  #     expect(prediction).to eq(first_and_last_initial)
  #   end
  # end
  

  # describe "predicts with patterns" do
  #   # let(:predictor) { Predictor.new( Pattern.new('first_and_last_initial') ) }
  #   # let(:pattern) { Pattern.new('first_and_last_initial') }
  #
  #   let(:pattern) { Pattern.new('first_and_last_initial') }
  #   let(:predictor) { Predictor.new(pattern) }
  #
  #
  #   it "first_and_last_initial pattern" do
  #     prediction = predictor.fetch_pattern('first_name_and_last_name', 'steve jobs', 'apple.com')
  #     expect(prediction).to be_predicted
  #   end
  #
  #   it "first_and_last_initial pattern" do
  #     # prediction = predictor.fetch_pattern('first_and_last_initial')
  #     prediction = predictor.fetch_pattern('first_and_last_initial', 'steve jobs', 'apple.com')
  #     expect(prediction).to be_predicted
  #   end
  # end
  
end


require 'spec_helper'
require 'open-uri'

RSpec.describe Predictor do

  let(:data) { JSON.parse(File.read(File.expand_path('spec/fixtures/advisors.json'))) }
  
  let(:prediction) { Predictor.new(data) }


  describe "parameters" do
    it 'processed with pattern object' do
      pattern = Pattern.new('first_and_last_initial')
      prediction = Predictor.new(pattern)
      expect(prediction.data).to be_instance_of(Pattern)
      # expect(prediction.data).to be_instance_of(Hash)
    end
    
    it 'processed with advisor object' do
      advisor = Advisor.new('steve', 'jobs', 'apple.com')
      prediction = Predictor.new(advisor)
      expect(prediction.data).to be_instance_of(Advisor)
    end
  end
  
  describe "predictions" do
    let(:predictor) { Predictor.new('steve', 'jobs', 'apple.com') }
    
    it "first_name_and_last_name pattern" do
      prediction = predictor.store_pattern('first_and_last_name')
      expect(prediction).to eq(first_and_last_initial)
    end
    
    it "first_and_last_initial pattern" do
      prediction = predictor.store_pattern('first_and_last_initial')
      expect(prediction).to eq(first_and_last_initial)
    end
    
    it "correctly name" do
      expect(predictor.name).to start_with("steve").and end_with("jobs")
    end
  end

  
  describe '#to_s' do
    it 'returns last formatted name and email' do
      expect(prediction.first.to_s).to eq('Steve Jobs (s.j@apple.com)')
      # expect(prediction.to_s).to eq('Kevin Rose - kevinrose@gmail.com')
    end
  end
  
  describe "#attributes" do
    it 'returns a list of available' do
      expect(prediction.attributes).to eq(["email", "name", "first_name", "last_name"])
    end
    
    it 'returns the associated email address' do
      expect(prediction.data).to be_instance_of(Hash)
    end

    it 'returns the associated email address' do
      expect(prediction.email).to eq('kevinrose@gmail.com')
    end

    it 'returns the associated name' do
      expect(prediction.name).to eq('Kevin Rose')
    end

    it 'returns the associated first name' do
      expect(prediction.first_name).to eq('Kevin')
    end

    it 'returns the associated last name' do
      expect(prediction.last_name).to eq('Rose')
    end
  end

end


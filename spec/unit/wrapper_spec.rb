require 'spec_helper'

describe Qmine::Wrapper do
  context "a new Wrapper" do
    let(:wrapper) { Qmine::Wrapper.new }
    
    it "works" do
      wrapper.dataset = Qmine::Wrapper.get_dataset
      results = wrapper.analyze
      Qmine::Wrapper.print(results, wrapper.options[:inputfile])
    end
  end
end
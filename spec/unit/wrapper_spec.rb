require 'spec_helper'

describe Qmine::Wrapper do
  context "a new Wrapper" do
    let(:wrapper) { Qmine::Wrapper.new }
    
    it "works" do
      wrapper.buh
    end
  end
end
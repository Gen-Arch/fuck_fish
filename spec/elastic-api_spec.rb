$: << File.expand_path("../lib", __dir__)

require_relative 'spec_helper.rb'
require "elastic-api.rb"


RSpec.describe Elasticapi do
  subject { Elasticapi }
    describe "#get" do
    context "in 正常系" do
      it { expect(subject.get).to eq {} }
    end
    context "in 異常系" do
      it { expect { subject.get }.to raise_error }
    end
  end
end


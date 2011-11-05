require File.expand_path('spec/spec_helper')
require "security/hash_key"

describe HashKey do

  describe "#compute" do
    let(:hash_key) {
      HashKey.new(:first => "i_am_number_one", :second => "and_i_am_number_two")
    }

    subject { hash_key.compute }
    it { should == "10f76998e22c989efb6544b2f25aaf3b7c6946f7" }
  end

end

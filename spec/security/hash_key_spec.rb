require File.expand_path('spec/spec_helper')
require "digest/sha1"
require "security/hash_key"

describe HashKey do

  describe "#compute" do
    subject {
      HashKey.new(:first => "i_am_number_one", :second => "and_i_am_number_two")
    }

    it "should compute valid SHA1 hash" do
      subject.compute.should_not be_nil
    end

    it "should join parameters before computing hash" do
      subject.compute.should == sha1_for("first=i_am_number_one&second=and_i_am_number_two")
    end

    context "parameter order" do
      subject {
        HashKey.new(:unordered => "foo", :stuff => "bar")
      }

      it "should be sorted alphabetically by name" do
        expected_hash = sha1_for("stuff=bar&unordered=foo")
        subject.compute.should == expected_hash
      end
    end
  end

  private

  def sha1_for(string)
    Digest::SHA1.hexdigest string
  end

end

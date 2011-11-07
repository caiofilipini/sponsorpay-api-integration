require File.expand_path("spec/spec_helper")
require "digest/sha1"
require "security/hash_key"

describe HashKey do

  let(:api_key) { "b07a12df7d52e6c118e5d47d3f9e60135b109a1f" }

  describe "#new" do
    subject { HashKey.new(api_key, "one" => 1, :two => 2) }

    it "should convert string keys to symbols" do
      params = subject.instance_variable_get(:@params)
      params[:one].should == 1
    end
  end

  describe "#compute" do
    subject {
      HashKey.new(api_key, :first => "i_am_number_one", :second => "and_i_am_number_two")
    }

    it "should compute valid SHA1 hash" do
      subject.compute.should_not be_nil
    end

    it "should join parameters before computing hash" do
      subject.compute.should == sha1_for("first=i_am_number_one&second=and_i_am_number_two&#{api_key}")
    end

    context "parameter order" do
      subject {
        HashKey.new(api_key, :unordered => "foo", :stuff => "bar")
      }

      it "should be sorted alphabetically by name" do
        expected_hash = sha1_for("stuff=bar&unordered=foo&#{api_key}")
        subject.compute.should == expected_hash
      end
    end
  end
end

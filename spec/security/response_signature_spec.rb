require File.expand_path("spec/spec_helper")
require "security/response_signature"

describe ResponseSignature do

  let(:api_key) { "b07a12df7d52e6c118e5d47d3f9e60135b109a1f" }
  let(:valid_response) { "{\"valid\":\"response\"}" }

  describe "#valid?" do
    subject { ResponseSignature.new(api_key, valid_response) }

    context "with a valid signature" do
      let(:signature) { sha1_for("#{valid_response}#{api_key}") }

      it "should return true" do
        subject.valid?(signature).should be_true
      end
    end

    context "with an invalid signature" do
      let(:signature) { sha1_for("any_invalid_response") }

      it "should return false" do
        subject.valid?(signature).should be_false
      end
    end
  end
end

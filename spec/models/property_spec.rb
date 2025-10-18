require "rails_helper"

RSpec.describe Property, type: :model do
  let(:valid_attributes) do
    {
      mnemonic: "PROP123",
      loinc_code: "1234-5",
      description: "Test property",
      data_type: "numeric"
    }
  end

  subject { described_class.new(valid_attributes) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    [ :mnemonic, :loinc_code, :description, :data_type ].each do |attr|
      it "validates presence of #{attr}" do
        subject.send("#{attr}=", nil)
        expect(subject).not_to be_valid
        expect(subject.errors[attr]).to be_present
      end
    end

    it "enforces uniqueness of mnemonic" do
      described_class.create!(valid_attributes)
      other = described_class.new(valid_attributes.merge(loinc_code: "9999-9"))
      expect(other).not_to be_valid
      expect(other.errors[:mnemonic]).to include(/has already been taken/)
    end

    it "enforces uniqueness of loinc_code" do
      described_class.create!(valid_attributes)
      other = described_class.new(valid_attributes.merge(mnemonic: "OTHER"))
      expect(other).not_to be_valid
      expect(other.errors[:loinc_code]).to include(/has already been taken/)
    end

    context "data_type enum" do
      it "accepts allowed values" do
        %w[ numeric string enumerated ].each do |dt|
          p = described_class.new(valid_attributes.merge(data_type: dt, mnemonic: "M-#{dt}", loinc_code: "L-#{dt}"))
          expect(p).to be_valid, "expected #{dt} to be valid"
        end
      end

      it "rejects unknown values" do
        expect { subject.data_type = "unknown" }.to raise_error(ArgumentError)
      end
    end

    context "limits ordering" do
      it "is valid when low_limit < high_limit" do
        subject.low_limit = 1
        subject.high_limit = 10
        expect(subject).to be_valid
      end

      it "is invalid when low_limit >= high_limit" do
        subject.low_limit = 10
        subject.high_limit = 1
        expect(subject).not_to be_valid
        expect(subject.errors[:low_limit]).to include("must be lower than high_limit")
      end

      it "is valid when one limit is blank" do
        subject.low_limit = nil
        subject.high_limit = 10
        expect(subject).to be_valid
      end
    end
  end
end

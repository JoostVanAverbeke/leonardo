# frozen_string_literal: true

require "rails_helper"

RSpec.describe HcProvider, type: :model do
  let!(:municipality) { Municipality.create!(postal_code: "1000", city: "Brussels", country: "BE") }

  let(:valid_attributes) do
    {
      mnemonic: "HC123",
      first_name: "Alice",
      surname: "Smith",
      municipality: municipality
    }
  end

  subject { described_class.new(valid_attributes) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    [:mnemonic, :first_name, :surname].each do |attr|
      it "validates presence of #{attr}" do
        subject.send("#{attr}=", nil)
        expect(subject).not_to be_valid
        expect(subject.errors[attr]).to be_present
      end
    end

    context "mnemonic uniqueness" do
      it "enforces uniqueness" do
        described_class.create!(valid_attributes)
        dup = described_class.new(valid_attributes.merge(first_name: "Bob"))
        expect(dup).not_to be_valid
        expect(dup.errors[:mnemonic]).to include(/has already been taken/)
      end
    end

    context "identifier" do
      it "allows blank identifier" do
        subject.identifier = ""
        expect(subject).to be_valid
      end

      it "enforces uniqueness when present" do
        described_class.create!(valid_attributes.merge(identifier: "ID-1"))
        other = described_class.new(valid_attributes.merge(identifier: "ID-1", mnemonic: "HC999"))
        expect(other).not_to be_valid
        expect(other.errors[:identifier]).to include(/has already been taken/)
      end
    end

    context "email" do
      it "allows blank email" do
        subject.email = ""
        expect(subject).to be_valid
      end

      it "accepts valid email formats" do
        subject.email = "provider@example.com"
        expect(subject).to be_valid
      end

      it "rejects invalid email formats" do
        subject.email = "not-an-email"
        expect(subject).not_to be_valid
        expect(subject.errors[:email]).to be_present
      end

      it "enforces uniqueness when present" do
        described_class.create!(valid_attributes.merge(email: "dup@example.com"))
        other = described_class.new(valid_attributes.merge(email: "dup@example.com", mnemonic: "HC888"))
        expect(other).not_to be_valid
        expect(other.errors[:email]).to include(/has already been taken/)
      end
    end

    context "phone and mobile_phone" do
      it "accepts valid phone numbers" do
        subject.phone = "+32 1234-567"
        subject.mobile_phone = "+32 498 12 34 56"
        expect(subject).to be_valid
      end

      it "rejects invalid phone numbers" do
        subject.phone = "abc123"
        expect(subject).not_to be_valid
        expect(subject.errors[:phone]).to be_present
      end
    end

    context "internet" do
      it "accepts http/https urls" do
        subject.internet = "https://example.com"
        expect(subject).to be_valid
      end

      it "rejects non-http(s) urls" do
        subject.internet = "ftp://example.com"
        expect(subject).not_to be_valid
        expect(subject.errors[:internet]).to be_present
      end
    end
  end

  describe "associations and enums" do
    it "belongs to a municipality" do
      expect(subject.municipality).to eq(municipality)
    end

    it "supports gender enum values" do
      %w[male female other].each do |g|
        p = described_class.new(valid_attributes.merge(gender: g))
        expect(p).to be_valid, "expected #{g} to be a valid gender"
      end
    end
  end
end

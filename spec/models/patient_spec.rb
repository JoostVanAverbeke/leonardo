require "rails_helper"

RSpec.describe Patient, type: :model do
  let!(:municipality) do
    Municipality.create!(postal_code: "1000", city: "Brussels", country: "BE")
  end

  let(:valid_attributes) do
    {
      first_name: "John",
      surname: "Doe",
      birth_date: Date.new(1990, 1, 1),
      gender: "male",
      municipality: municipality
    }
  end

  subject { described_class.new(valid_attributes) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    [ :first_name, :surname, :birth_date, :gender ].each do |attr|
      it "validates presence of #{attr}" do
        subject.send("#{attr}=", nil)
        expect(subject).not_to be_valid
        expect(subject.errors[attr]).to be_present
      end
    end

    context "national_number" do
      it "allows blank national_number" do
        subject.national_number = ""
        expect(subject).to be_valid
      end

      it "enforces uniqueness when present" do
        described_class.create!(valid_attributes.merge(national_number: "NN123"))
        other = described_class.new(valid_attributes.merge(national_number: "NN123", email: "unique@example.com"))
        expect(other).not_to be_valid
        expect(other.errors[:national_number]).to include(/has already been taken/)
      end
    end

    context "email" do
      it "allows blank email" do
        subject.email = ""
        expect(subject).to be_valid
      end

      it "accepts valid email formats" do
        subject.email = "alice@example.com"
        expect(subject).to be_valid
      end

      it "rejects invalid email formats" do
        subject.email = "not-an-email"
        expect(subject).not_to be_valid
        expect(subject.errors[:email]).to be_present
      end

      it "enforces uniqueness when present" do
        described_class.create!(valid_attributes.merge(email: "dup@example.com"))
        other = described_class.new(valid_attributes.merge(email: "dup@example.com", national_number: "NNX"))
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

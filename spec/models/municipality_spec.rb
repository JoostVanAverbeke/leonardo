require "rails_helper"

RSpec.describe Municipality, type: :model do
  let(:valid_attributes) { { postal_code: "1000", city: "Brussels", country: "BE" } }
  subject { described_class.new(valid_attributes) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    [ :postal_code, :city, :country ].each do |attr|
      it "validates presence of #{attr}" do
        subject.send("#{attr}=", nil)
        expect(subject).not_to be_valid
        expect(subject.errors[attr]).to be_present
      end
    end

    it "normalizes country to uppercase before validation" do
      m = described_class.new(valid_attributes.merge(country: "be"))
      expect(m.valid?).to be(false).or be(true) # trigger callbacks
      expect(m.country).to eq("BE")
    end

    it "rejects non alpha-2 country codes" do
      m = described_class.new(valid_attributes.merge(country: "Belgium"))
      expect(m).not_to be_valid
      expect(m.errors[:country]).to include("must be an ISO 3166-1 alpha-2 code (2 letters)")
    end
  end

  describe "#externalize" do
    it "returns formatted address" do
      expect(subject.externalize).to eq("1000 Brussels, BE")
    end
  end

  describe "associations" do
    it "has many patients" do
      m = described_class.create!(valid_attributes)
      p = m.patients.create!(first_name: "A", surname: "B", birth_date: Date.new(1990, 1, 1), gender: "male")
      expect(m.patients).to include(p)
    end
  end
end

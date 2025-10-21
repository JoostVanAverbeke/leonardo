require "rails_helper"

RSpec.describe Order, type: :model do
  let!(:municipality) { Municipality.create!(postal_code: "1000", city: "Brussels", country: "BE") }
  let!(:patient) { Patient.create!(first_name: "John", surname: "Doe", birth_date: Date.new(1990, 1, 1), gender: "male", municipality: municipality) }
  let!(:hc_provider) { HcProvider.create!(mnemonic: "HP1", first_name: "Doc", surname: "Who", municipality: municipality) }

  let(:valid_attributes) do
    {
      filler_order_number: "F123",
      receipt_time: Time.current,
      patient: patient,
      ordering_provider_id: hc_provider.id
    }
  end

  subject { described_class.new(valid_attributes) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "validates presence and uniqueness of filler_order_number" do
      described_class.create!(valid_attributes)
      other = described_class.new(valid_attributes.merge(receipt_time: Time.current + 1.minute))
      expect(other).not_to be_valid
      expect(other.errors[:filler_order_number]).to include(/has already been taken/)
    end

    it "validates presence of receipt_time" do
      subject.receipt_time = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:receipt_time]).to be_present
    end

    it "validates phone format for order_call_back_phone" do
      subject.order_call_back_phone = "+32 1234-567"
      expect(subject).to be_valid
      subject.order_call_back_phone = "invalid-phone"
      expect(subject).not_to be_valid
      expect(subject.errors[:order_call_back_phone]).to be_present
    end
  end

  describe "associations and enums" do
    it "belongs to patient and hc_provider" do
      expect(subject.patient).to eq(patient)
      expect(subject.hc_provider).to eq(hc_provider)
    end

    it "supports priority enum values" do
      %w[routine urgent stat].each do |p|
        o = described_class.new(valid_attributes.merge(filler_order_number: "F-#{p}", priority: p))
        expect(o).to be_valid, "expected #{p} to be valid priority"
      end
    end

    it "supports order_status enum values" do
      %w[new_order in_progress completed cancelled].each do |s|
        o = described_class.new(valid_attributes.merge(filler_order_number: "O-#{s}", order_status: s))
        expect(o).to be_valid, "expected #{s} to be valid order_status"
      end
    end
  end

  describe "#ordering_provider" do
    it "returns the associated HcProvider" do
      subject.save!
      expect(subject.ordering_provider).to eq(hc_provider)
    end
  end
end

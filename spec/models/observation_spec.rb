require "rails_helper"

RSpec.describe Observation, type: :model do
  let!(:municipality) { Municipality.create!(postal_code: "1000", city: "Brussels", country: "BE") }
  let!(:patient) {
                  Patient.create!(first_name: "John", surname: "Doe", birth_date: Date.new(1990, 1, 1),
                    gender: "male", municipality: municipality)
                }
  let!(:hc_provider) {
                      HcProvider.create!(mnemonic: "HP1", first_name: "Doc", surname: "Who",
                        municipality: municipality)
                      }
  let!(:property) {
                    Property.create!(mnemonic: "P1", loinc_code: "1000-0", description: "Test",
                    data_type: "numeric")
                  }
  let!(:order) {
                Order.create!(filler_order_number: "F1", receipt_time: Time.current, patient: patient,
                ordering_provider_id: hc_provider.id)
               }

  let(:valid_attributes) do
    {
      value: "42",
      observation_date_time: Time.current,
      result_status: "initial",
      order: order,
      property: property
    }
  end

  subject { described_class.new(valid_attributes) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "validates presence of required attributes" do
      %i[value observation_date_time result_status order_id property_id].each do |attr|
        subject.send("#{attr}=", nil)
        expect(subject).not_to be_valid
        expect(subject.errors[attr]).to be_present
        # restore
        subject.send("#{attr}=", valid_attributes[attr] || valid_attributes[attr.to_s.gsub(/_id$/, "").to_sym])
      end
    end

    it "ensures patient_id is set from order on create when missing" do
      obs = described_class.new(valid_attributes.merge(patient_id: nil))
      expect(obs.patient_id).to be_nil
      expect(obs).to be_valid
      obs.save!
      expect(obs.patient_id).to eq(order.patient_id)
    end

    it "does not overwrite patient_id on update" do
      obs = described_class.create!(valid_attributes.merge(patient_id: patient.id))
      # create another patient and ensure updating the observation doesn't reset patient_id
      other = Patient.create!(first_name: "Jane", surname: "Roe", birth_date: Date.new(1991, 1, 1), gender: "female", municipality: municipality)
      obs.update!(value: "43")
      expect(obs.patient_id).to eq(patient.id)
    end
  end

  describe "enums" do
    it "accepts defined result_status values" do
      %w[initial expected available confirmed validated corrected cancelled entered_in_error].each do |s|
        o = described_class.new(valid_attributes.merge(result_status: s))
        # ensure it can be assigned (will raise on invalid assignment)
        expect { o.result_status = s }.not_to raise_error
      end
    end

    it "raises ArgumentError when assigning unknown result_status" do
      expect { subject.result_status = "unknown" }.to raise_error(ArgumentError)
    end
  end

  describe "associations" do
    it "belongs to order, patient and property" do
      subject.save!
      expect(subject.order).to eq(order)
      expect(subject.patient).to eq(patient)
      expect(subject.property).to eq(property)
    end
  end
end

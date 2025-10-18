require "rails_helper"

RSpec.describe "Property Factory" do
    it "creates a property with valid attributes from LOINC code" do
        property = FactoryBot.build(:property)

        expect(property.mnemonic).to be_present
        expect(property.loinc_code).to be_present
        expect(property.description).to be_present
        expect(property.units_of_measure).to be_present
        expect(property.low_limit).to be_a(BigDecimal)
        expect(property.high_limit).to be_a(BigDecimal)
        expect(property.data_type).to eq("numeric")
    end

    it "creates properties with different LOINC codes" do
        property1 = FactoryBot.build(:property)
        property2 = FactoryBot.build(:property)

        expect(property1.loinc_code).not_to eq(property2.loinc_code)
        expect(property1.description).not_to eq(property2.description)
    end
end

# frozen_string_literal: true

require_relative "../models/loinc"
require "csv"

# LoincStore class
# This class is responsible for loading and storing LOINC codes
# from the CSV file (resources/data/LOINC_2_78_CHEM_UTF_8.csv)
class LoincStore
  @@loinc_codes = nil
  @@chemistry_codes = nil

  # Returns all LOINC codes with class 'CHEM'.
  #
  # @return [Array<Loinc>] Array of LOINC codes with class 'CHEM'
  def self.chemistry_codes
    @@chemistry_codes ||= loinc_codes.select { |loinc| loinc.klass == "CHEM" }
  end

  # Returns all LOINC codes.
  #
  # @return [Array<Loinc>] Array of all LOINC codes
  def self.loinc_codes
    load_loinc_codes if @@loinc_codes.nil?
    @@loinc_codes
  end

  private
  # Loads all LOINC codes from the CSV file.
  #
  # @return [void]
  def self.load_loinc_codes
    csv_file_path = "#{__dir__}/../resources/data/LOINC_2_78_CHEM_UTF_8.csv"
    @@loinc_codes = []
    CSV.foreach(csv_file_path, headers: true, encoding: "utf-8") do |row|
      loinc = Loinc.new
      loinc.loinc_num = row["LOINC_NUM"]
      loinc.property = row["PROPERTY"]
      loinc.klass = row["CLASS"]
      loinc.shortname = row["SHORTNAME"]
      loinc.example_ucum_units = row["EXAMPLE_UCUM_UNITS"]
      loinc.hl7_field_subfield_id = row["HL7_FIELD_SUBFIELD_ID"]
      @@loinc_codes << loinc
    end
  end
end

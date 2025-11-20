# frozen_string_literal: true

require "uri"

class GetOrderResultsReportResource < ApplicationResource
  uri "#{URI::File.build(path: "/" + File.join(__dir__, "file_resources", "leonardo_mark_down_order_results_report.md").gsub("\\", "/"))}"
  resource_name "Leonardo/GetOrderResultsReport"
  mime_type "text/plain"
  def content
    File.read(File.join(__dir__, "file_resources", "leonardo_mark_down_order_results_report.md"))
  end
end

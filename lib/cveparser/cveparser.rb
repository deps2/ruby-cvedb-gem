require "#{FIDIUS::CveDb::GEM_BASE}/cveparser/parser"
require "#{FIDIUS::CveDb::GEM_BASE}/cveparser/rails_store"
require "#{FIDIUS::CveDb::GEM_BASE}/cveparser/ms_parser"

module FIDIUS::CveDb::CveParser
  def self.parse(file)
    entries = FIDIUS::NVDParser.parse_cve_file(file)
    FIDIUS::CveDb::RailsStore.create_new_entries(file.split("/").last, entries)
  end

  def self.fix_duplicates
    FIDIUS::CveDb::RailsStore.fix_product_duplicates
  end

  def self.update(file)
    entries = FIDIUS::NVDParser.parse_cve_file(file)
    FIDIUS::CveDb::RailsStore.update_cves(entries)
  end

  def self.parse_ms_cve
    FIDIUS::MSParser.parse_ms_cve
  end
end

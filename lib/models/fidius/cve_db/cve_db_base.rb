class FIDIUS::CveDb::CveDbBase < ActiveRecord::Base
  self.abstract_class = true

  def self.table_name_prefix
    'cvedb_'
  end
end

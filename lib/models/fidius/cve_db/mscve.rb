class FIDIUS::CveDb::Mscve < FIDIUS::CveDb::CveDbBase
  attr_accessible :nvd_entry_id, :name
  belongs_to :nvd_entry
end

class FIDIUS::CveDb::VulnerableConfiguration < FIDIUS::CveDb::CveDbBase
  attr_accessible :nvd_entry_id, :product_id
  belongs_to :nvd_entry
  belongs_to :product
  
end

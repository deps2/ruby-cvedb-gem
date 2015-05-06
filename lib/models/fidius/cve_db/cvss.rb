class FIDIUS::CveDb::Cvss < FIDIUS::CveDb::CveDbBase
  attr_accessible :score, :source, :generated_on, :access_vector, :access_complexity, :authentication,
    :confidentiality_impact_id, :integrity_impact_id, :availability_impact_id, :nvd_entry_id

  belongs_to :confidentiality_impact, class_name: 'FIDIUS::CveDb::Impact', foreign_key: 'confidentiality_impact_id'
  belongs_to :availability_impact, class_name: 'FIDIUS::CveDb::Impact', foreign_key: 'availability_impact_id'
  belongs_to :integrity_impact, class_name: 'FIDIUS::CveDb::Impact', foreign_key: 'integrity_impact_id'
end

class ChangeImpactsStructure < ActiveRecord::Migration
  def self.up
    add_column :cvedb_cvsses, :availability_impact_id, :integer
    add_column :cvedb_cvsses, :confidentiality_impact_id, :integer
    add_column :cvedb_cvsses, :integrity_impact_id, :integer
  end

  def self.down
    remove_column :cvedb_cvsses, :availability_impact_id
    remove_column :cvedb_cvsses, :confidentiality_impact_id
    remove_column :cvedb_cvsses, :integrity_impact_id
  end
end

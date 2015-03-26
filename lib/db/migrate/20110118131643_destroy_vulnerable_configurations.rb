class DestroyVulnerableConfigurations < ActiveRecord::Migration
  def self.up
    drop_table :cvedb_vulnerable_configurations
  end

  def self.down
    create_table :cvedb_vulnerable_configurations do |t|
      t.integer :nvd_entry_id
      t.integer :product_id
      t.timestamps
    end
  end
end

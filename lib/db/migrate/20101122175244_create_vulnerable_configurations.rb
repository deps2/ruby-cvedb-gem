class CreateVulnerableConfigurations < ActiveRecord::Migration
  def self.up
    create_table :cvedb_vulnerable_configurations do |t|
      t.integer :nvd_entry_id
      t.integer :product_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cvedb_vulnerable_configurations
  end
end

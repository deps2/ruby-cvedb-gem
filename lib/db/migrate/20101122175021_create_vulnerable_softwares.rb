class CreateVulnerableSoftwares < ActiveRecord::Migration
  def self.up
    create_table :cvedb_vulnerable_softwares do |t|
      t.integer :nvd_entry_id
      t.integer :product_id

      t.timestamps
    end
    add_index :cvedb_vulnerable_softwares, :nvd_entry_id
    add_index :cvedb_vulnerable_softwares, :product_id
  end

  def self.down
    drop_table :cvedb_vulnerable_softwares
  end
end

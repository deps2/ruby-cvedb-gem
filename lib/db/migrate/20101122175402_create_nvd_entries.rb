class CreateNvdEntries < ActiveRecord::Migration
  def self.up
    create_table :cvedb_nvd_entries do |t|
      t.string :cve
      t.string :cwe
      t.text :summary
      t.datetime :published
      t.datetime :last_modified

      t.timestamps
    end
    add_index :cvedb_nvd_entries, :cve
  end

  def self.down
    drop_table :cvedb_nvd_entries
  end
end

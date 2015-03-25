class CreateImpacts < ActiveRecord::Migration
  def self.up
    create_table :cvedb_impacts do |t|
      t.string :name

      t.timestamps
    end
    add_index :cvedb_impacts, :name
  end

  def self.down
    drop_table :cvedb_impacts
  end
end

class CreateXmls < ActiveRecord::Migration
  def self.up
    create_table :cvedb_xmls do |t|
      t.string :name
      t.datetime :create_time

      t.timestamps
    end
  end

  def self.down
    drop_table :cvedb_xmls
  end
end

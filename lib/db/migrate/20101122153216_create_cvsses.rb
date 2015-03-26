class CreateCvsses < ActiveRecord::Migration
  def self.up
    create_table :cvedb_cvsses do |t|
      t.float :score
      t.string :source
      t.datetime :generated_on
      t.string :access_vector
      t.string :access_complexity
      t.string :authentication
      t.integer :nvd_entry_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cvedb_cvsses
  end
end

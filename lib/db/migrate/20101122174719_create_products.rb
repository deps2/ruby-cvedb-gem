class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :cvedb_products do |t|
      t.string :part
      t.string :vendor
      t.string :product
      t.string :version
      t.string :update_nr
      t.string :edition
      t.string :language

      t.timestamps
    end

    add_index :cvedb_products, :product
    add_index :cvedb_products, :vendor
  end

  def self.down
    drop_table :cvedb_products
  end
end

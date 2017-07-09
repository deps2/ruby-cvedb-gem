class CreateDefaultImpacts < ActiveRecord::Migration
  
  IMPACT_DEFAULTS = %w[NONE PARTIAL COMPLETE]
  
  def self.up
    IMPACT_DEFAULTS.each do |name|
      FIDIUS::CveDb::Impact.find_or_create_by(name: name)
    end
  end

  def self.down
    IMPACT_DEFAULTS.each do |name|
      impacts = FIDIUS::CveDb::Impact.where({ :name => name })
      impacts.each do |impact|
        impact.destroy!
      end
    end
  end
end

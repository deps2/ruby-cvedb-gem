require 'yaml'

namespace :nvd do 
  desc 'Execute NVD migrations'
  task :migrate => :environment do
    ActiveRecord::Migrator.migrate(File.join(FIDIUS::CveDb::GEM_BASE, 'db', 'migrate'))
  end
  
  desc "Drop NVD migrations"
  task :drop => :environment do
    ActiveRecord::Migrator.down(File.join(FIDIUS::CveDb::GEM_BASE, 'db', 'migrate'))
  end
end


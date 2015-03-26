require 'open-uri'
require 'net/http'
require 'nokogiri'
require 'fidius-cvedb'
require 'cveparser/helper'

namespace :nvd do
  desc 'Parses local XML-File.'
  task :parse, [:file_name]  => :environment do |t,args|
    FIDIUS::CveDb::Helper::parse_from_file(args[:file_name])
  end
  
  desc 'Downloads XML-File from NVD. (with names from nvd:list_remote)'
  task :get, [:xml_name] => :environment do |_,args|
    if args[:xml_name]
      FIDIUS::CveDb::Helper::wget(args[:xml_name])
    else
      puts "Please call task with 'rake nvd:get[<xml_name>]'!"
    end 
  end
  
  desc 'Lists the locally available NVD-XML-Datafeeds.'
  task :list_local => :environment do
    puts FIDIUS::CveDb::Helper::local_xmls
  end  

  desc 'Lists the remotely available NVD-XML-Datafeeds.'
  task :list_remote => :environment do
    xmls = FIDIUS::CveDb::Helper::remote_xmls
    if xmls
      puts "#{xmls.size} XMLs available:\n------"
      puts xmls
    else
      puts 'No suitable XMLs found.'
    end
  end

  desc "Downloads the modified.xml from nvd.org and stores it's content in the database."
  task :update => :environment do
    FIDIUS::CveDb::Helper::update_db
  end

  desc 'Initializes the CVE-DB, parses all annual CVE-XMLs and removes duplicates.'
  task :initialize => :environment do
    FIDIUS::CveDb::Helper::initialize_db
  end

  desc 'Creates the mapping between CVEs and Microsoft Security Bulletin Notation in the database.'
  task :mscve => :environment do
    FIDIUS::CveDb::Helper::parse_ms_cve
  end
end


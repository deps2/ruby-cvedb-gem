require "#{FIDIUS::CveDb::GEM_BASE}/cveparser/parser"
require "#{FIDIUS::CveDb::GEM_BASE}/cveparser/rails_store"
require "#{FIDIUS::CveDb::GEM_BASE}/cveparser/ms_parser"
require "#{FIDIUS::CveDb::GEM_BASE}/cveparser/configuration"

module FIDIUS::CveDb::Helper
  BASE_URL = 'http://static.nvd.nist.gov/feeds/xml/cve/'
  BASE_SSL_URL = 'https://nvd.nist.gov/feeds/xml/cve/'
  DOWNLOAD_URL = 'https://nvd.nist.gov/download.cfm'
  XML_DIR = File.join(Dir.pwd, 'cveparser', 'xml')
  ANNUALLY_XML = /nvdcve-2[.]0-(\d{4})[.]xml/
  EXTENSION = '.xml.gz'

  # modified xml includes all recent published and modified cve entries
  MODIFIED_XML = 'nvdcve-2.0-modified.xml.gz'
  RECENT_XML = 'nvdcve-2.0-recent.xml.gz'


  def self.parse_from_file(file)
    entries = FIDIUS::NVDParser.parse_cve_file(file)
    FIDIUS::CveDb::RailsStore.create_new_entries(file.split("/").last, entries)
  end

  def self.fix_duplicates
    FIDIUS::CveDb::RailsStore.fix_product_duplicates
  end

  def self.update_from_file(file)
    entries = FIDIUS::NVDParser.parse_cve_file(file)
    FIDIUS::CveDb::RailsStore.update_cves(entries)
  end

  def self.parse_ms_cve
    FIDIUS::MSParser.parse_ms_cve
  end

  def self.update_db
    wget(MODIFIED_XML)
    update_from_file(xml_path(MODIFIED_XML))
    wget(RECENT_XML)
    update_from_file(xml_path(RECENT_XML))
  end

  def self.relevant_xml?(xml)
    match = xml.match(ANNUALLY_XML)
    match.present? and match[1].to_i > FIDIUS::CveDb::Configuration.configuration.min_year_fetch
  end

  # Initializes the CVE-DB with all CVE data available in the NVD.
  def self.initialize_db
    puts "[*] Configuration"
    puts "  - min_year_fetch = #{FIDIUS::CveDb::Configuration.configuration.min_year_fetch}"
    puts "  - fetch_products = #{FIDIUS::CveDb::Configuration.configuration.fetch_products_filter}"

    local_x = local_xmls
    if local_x
      puts "WARNING: The XML directory already contains XML files. "+
               "nvd:initialize is intended to be used only once to set up the "+
               "CVE-Entries. To update the CVE-Entries use nvd:update.\n\n"+
               "If you don't cancel the task I'll proceed in 20 seconds."
      sleep 20
    end
    puts "[*] Looking for XMLs at #{DOWNLOAD_URL}"
    remote_x = remote_xmls
    r_ann_xmls = []
    remote_x.each do |xml|
      r_ann_xmls << xml if relevant_xml?(xml)
    end
    puts "[*] I've found #{r_ann_xmls.size} annually XML files remotely."
    puts "[*] Checking locally available XMLs."
    l_ann_xmls = []
    if local_x
      local_x.each do |xml|
        l_ann_xmls << xml if relevant_xml?(xml)
      end
    end
    puts "[*] I've found #{l_ann_xmls.size} annually XML files locally. I'll "+
             "download the missing XMLs now."
    r_ann_xmls.each do |xml|
      puts "Downloading #{xml}."
      wget xml unless l_ann_xmls.include? xml
      puts "Downloaded #{xml}."
    end
    puts "[*] All available files downloaded, parsing the XMLs now."
    l_ann_xmls.each do |xml|
      FIDIUS::CveDb::Helper::parse_from_file(xml_path(xml))
    end

    puts "[*] All local XMLs parsed."
    FIDIUS::CveDb::Helper::fix_duplicates
    puts "[*] Initializing done."
  end

  def self.xml_path(entry)
    File.join(XML_DIR, entry)
  end

# Returns an array of xmls that were previously downloaded
  def self.local_xmls
    if Dir.exists?(XML_DIR)
      entries = []
      dir = Dir.new(XML_DIR)
      dir.each do |entry|
        entries << entry if entry =~ /.+\.xml.gz$/
      end
      return (entries.empty? ? nil : entries)
    else
      puts "ERROR: There is no directory \"#{XML_DIR}\" where I can look for XMLs."
      return nil
    end
  end

# Returns an array of available xmls or nil if none are found.
  def self.remote_xmls
    doc = Nokogiri::HTML open(DOWNLOAD_URL)
    links = doc.css("td.xml-file-type > a")
    xmls = []
    links.each do |link|
      link_name = link.attributes['href'].to_s
      if link_name
        xmls << link_name.split("/").last if link_name.include? BASE_URL and link_name.end_with?(EXTENSION)
      end
    end
    xmls.empty? ? nil : xmls
  end

  def self.wget(file)
    FileUtils.mkdir_p(XML_DIR)

    response = open("#{BASE_SSL_URL + file}")
    open("#{File.join(XML_DIR, file)}", "wb") do |f|
      # read the file object
      f.write(response.read)
    end
  end


end

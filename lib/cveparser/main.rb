require "#{FIDIUS::CveDb::GEM_BASE}/cveparser/parser"
require "#{FIDIUS::CveDb::GEM_BASE}/cveparser/rails_store"
require "#{FIDIUS::CveDb::GEM_BASE}/cveparser/ms_parser"
require "#{FIDIUS::CveDb::GEM_BASE}/cveparser/cveparser"

include FIDIUS::CveDb

PARAMS = {
  '-p' => 'Parse new XML file passed as 2nd param.',
  '-f' => 'Fix duplicate products.',
  '-u' => 'Updates CVE-Entries, needs modified.xml or recent.xml by nvd.nist.gov as 2nd argument.',
  '-m' => 'Creates the mapping between CVEs and Microsoft Security Bulletin Notation entries in the database.'
}

case ARGV[0]
  when '-p'
    Environment::parse_from_file(ARGV[1])
  when '-f'
    Environment::fix_duplicates
  when '-u'
    Environment::update_from_file(ARGV[1])
  when '-m'
    Environment::parse_ms_cve
  else
    puts "ERROR: You've passed none or an unknown parameter, available "+
      "parameters are:"
    PARAMS.each_key do |param|
      puts "#{param}\t#{PARAMS[param]}"
    end
end

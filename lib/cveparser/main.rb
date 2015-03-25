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
    CveParser::parse(ARGV[1])
  when '-f'
    CveParser::fix_duplicates
  when '-u'
    CveParser::update(ARGV[1])
  when '-m'
    CveParser::parse_ms_cve
  else
    puts "ERROR: You've passed none or an unknown parameter, available "+
      "parameters are:"
    PARAMS.each_key do |param|
      puts "#{param}\t#{PARAMS[param]}"
    end
end

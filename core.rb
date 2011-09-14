begin
  require 'rubygems'
  _cupid_path = File.expand_path(File.dirname(__FILE__))
  Dir.glob(_cupid_path + "/lib/coreutils/*.rb").each {|cu| require cu}
  require _cupid_path + '/lib/cupid/core'
  Cupid.start(_cupid_path)
rescue Exception => e
  raise StandardError, "Cupid: Failed. Message: #{e}"
end

require 'lib/chrysalis/chrysalis'
gem 'activerecord', '=2.3.8'
require 'active_record'

class ActiveRecord::Base
  alias_method :ar_core_orig_convert_number_column_value, :convert_number_column_value

  def convert_number_column_value(v)
    ar_core_orig_convert_number_column_value((v.kind_of?(String) ? v.clean_number : v))
  end
end


require 'lib/chrysalis/lib/connections'
require 'lib/chrysalis/lib/db'
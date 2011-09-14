module Chrysalis
	module KeyRing
	  # KeyRing spawns Hosts which spawn DBConnections (< AR::Base)
	  # Then DB spawns Hosts which spawn DBs which spawn AR children
	  
	  class << self
	    def const_missing(k)
	      ky = k.to_s.snake_case
	      raise(NameError, "Database Key #{ky} does not exist!") unless ::Cupid::Pragma::Database.has_key?(ky)
	      klass = Class.new(Chrysalis::Host)
	      klass.connection_key = ky
	      const_set(k, klass)
      end
    end
	end
	
	class Host
	  class << self
	    attr_accessor :connection_key
	    def const_missing(k)
	      ky = k.to_s.snake_case
	      raise "Connection Has Not Been Set!" unless @connection_key
	      raise(NameError, "Pragma For Host Connection Missing!") unless ::Cupid::Pragma::Database.has_key?(@connection_key)
	      const_set(k, Class.new(ActiveRecord::Base))
	      klass = const_get(k)
	      klass.abstract_class = true
	      klass.establish_connection(self.pragma_hash.merge('database' => ky))
	      klass
      end
      
      def pragma_hash
        ::Cupid::Pragma::Database[@connection_key].to_hash.dup
      end
    end
  end
end
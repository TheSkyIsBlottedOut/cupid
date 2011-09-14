require 'yaml'
module Cupid
	module Pragma
	  class << self
	    def const_missing(k)
  		  fn = self.path / k.to_s.snake_case + '.yml'
  		  const_set(k, self.package(fn))
  		end
	    	 
	    def package(filepath)
	      raise NameError, "File #{fn} cannot be found!" unless File.exist?(filepath)
	      Hashie::Mash.new(YAML.load(IO.read(filepath)))
      end
	    	    
	    def path
	      Cupid.root / 'etc'
      end
    end
	end
end
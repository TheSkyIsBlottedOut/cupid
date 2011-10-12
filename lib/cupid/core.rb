require 'hashie'
module Cupid
  class << self
    attr_reader :data, :env
    
    def const_missing(k)
      kval = k.to_s.snake_case

      filename = Cupid.root / 'lib' / 'cupidext' / kval / kval + '.rb'
      raise "Module #{k} could not be found!" unless File.exists?(filename)
      require filename
      const_set(k, Cupid::Extensions.const_get(k).new)
    end
    
    def root
      @env.path ||=  File.expand_path(File.dirname(__FILE__) / '../..')
    end
    
    def start(p)
      @data = Hashie::Mash.new
      @env = Hashie::Mash.new
      @env.path = p
      $:.unshift(p)
      require 'lib/cupid/pragma/pragma' # autoloading after this can be done via pragma
    end
  end
end
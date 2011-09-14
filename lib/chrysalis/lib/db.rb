module Chrysalis
  class CHost
    class << self
      attr_accessor :host, :host_class
      def const_missing(k)
        klass = Class.new(Chrysalis::CDatabase)
        klass.db = k.to_s.snake_case
        klass.db_class = @host_class.const_get(k)
        const_set(k, klass)
      end
    end
  end
  
  
  class CDatabase
    class << self
      attr_accessor :db, :db_class
      def const_missing(k)
        ky = k.to_s.snake_case
        _file_name = self.model_dir / ky + '.rb'
        if File.exist?(_file_name)
          class_eval(IO.read(_file_name))
          raise "Model file does not define constant #{k}: #{_file_name}" unless const_defined?(k)
        else
          return self.prototype(k)
        end
        return const_get(k)
      end
      
      def prototype(k)
        const_set(k, Class.new(@db_class))
        klass = const_get(k)
        yield klass if block_given?
        klass
      end
      
      def model_dir
        Cupid.root / 'db' / self.parent.host / @db
      end
    end
  end    
end




module DB
  class << self
    def const_missing(k)
      klass = Class.new(Chrysalis::CHost)
      klass.host = k.to_s.snake_case
      klass.host_class = Chrysalis::KeyRing.const_get(k)
      const_set(k, klass)
    end
  end
end
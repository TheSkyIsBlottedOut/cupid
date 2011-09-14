class Hash
  def demash
    _ = self.clone
    _.each_pair do |k,v|
      if v.kind_of?(Hash)
        _[k] = v.demash
      elsif ['',[],nil].include?(v)
        _[k] = nil
      end
    end  
    _
  end
  
  def keypath(*args)
    args.inject(self) do |s,i|
      return nil unless s.respond_to?(:has_key?) && s.has_key?(i)
      s = s[i]
    end
  end
end
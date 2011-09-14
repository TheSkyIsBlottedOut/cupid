class String
  def /(k)
    self + '/' + k
  end

	def clean_number
		self.gsub(/[^\-\d\.\s]/, '')
	end
  
  def snake_case
    gsub(/\W+/, '_').gsub(/([a-z0-9]{1})([A-Z]+)/, '\\1_\\2').gsub(/(^_+|_+$)/, '').downcase
  end

	def strip_html
	  self.gsub(/<[^>]+>/, '')
  end
  
  def wordy?
    self =~ /\w+/
  end
end
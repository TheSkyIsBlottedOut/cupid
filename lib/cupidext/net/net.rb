require 'net/http'
require 'uri'

module Cupid
  module Extensions
    class Net
      def download(url)
        begin
          ::Net::HTTP.get(URI.parse(url))
        rescue Exception => e
          ""
        end
      end
    end
  end
end  
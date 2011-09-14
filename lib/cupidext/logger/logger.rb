require 'facets/ansicode'
require 'fileutils'
module Cupid
  module Extensions
    class Logger
      def initialize
        @files = []
        enable_stdout
      end
      
      def close_all_files
        @files.collect {|x| x.close}
      end
      
      def open(fn)
        logfile_path = File.dirname(fn)
        FileUtils.mkdir_p(logfile_path) unless File.directory?(logfile_path)
        file_handle = File.open(fn, 'w+')
        self.log_to_file(file_handle)
      end
            
      def disable_stdout
        @stdout = false
      end
      
      def enable_stdout
        @stdout = true
      end
      
      def write_log(severity, message)
        severity = severity.to_s.upcase
        message = message.to_s
        logtime = Time.now.strftime('%Y.%m.%d.%H.%M')
        @files.each {|x| x.write("[%8s@%s] %s\n" % [severity, logtime, message]) }
        if @stdout
          color = case severity
          when /ERROR/ then :red
          when /WARN/ then :yellow
          when /INFO/ then :blue
          when /DEBUG/ then :green
          else
            :white
          end
          puts [ANSICode.bold, ANSICode.white, ("[%10s] " % logtime), ANSICode.reset, ANSICode.send(color), message, ANSICode.reset, $/].join('')
        end
      end
      
      def debug(msg); write_log('debug', msg); end
      def error(msg); write_log('error', msg); end
      def info(msg); write_log('info', msg); end
      def log(msg); write_log('log', msg); end
      def warn(msg); write_log('warn', msg); end
      
      
      def log_to_file(fn)
        raise "Passed object is not a file!" unless fn.kind_of?(IO)
        @files << fn
      end
    end
  end
end
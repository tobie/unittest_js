module UnittestJS
  module Browser
    class Abstract
      def supported?
        true
      end

      def setup
      end

      def teardown
      end

      def open(url)
      end

      def host
        require 'rbconfig'
        Config::CONFIG['host']
      end

      def macos?
        host.include?('darwin')
      end

      def windows?
        host.include?('mswin')
      end

      def linux?
        host.include?('linux')
      end

      def applescript(script)
        raise "Can't run AppleScript on #{host}" unless macos?
        `osascript -s o -e '#{script}' 2>&1`
      end
      
      def installed?
        if macos?
          # if anyone has a simpler solution for this... input welcomed.
          applescript('exists application "' + app_name + '"') =~ /^true/
        else
          true #TODO
        end
      end
      
      def app_name
        self.class.name.split('::').last
      end
      
      def to_s
        app_name
      end
    end
  end
end
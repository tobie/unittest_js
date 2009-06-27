module UnittestJS
  module Browser
    class Safari < UnittestJS::Browser::WebKit
      def initialize(version = nil)
        @version = version
      end
      
      def supported?
        macos? && installed?
      end
      
      def app_name
        @version ? "Safari #{@version}" : 'Safari'
      end
    end
  end
end

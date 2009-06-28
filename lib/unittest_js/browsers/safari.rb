module UnittestJS
  module Browser
    class Safari < UnittestJS::Browser::WebKit
      def initialize(version = nil)
        @version = version
      end
      
      def supported?
        macos? && installed?
      end
      
      def name
        @version ? "Safari #{@version}" : 'Safari'
      end
    end
  end
end

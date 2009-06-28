module UnittestJS
  module Browser
    class Chrome < Abstract
      def initialize(path = nil)
        @path = path || File.join(
          ENV['UserPath'] || "C:/Documents and Settings/Administrator",
          "Local Settings",
          "Application Data",
          "Google",
          "Chrome",
          "Application",
          "chrome.exe"
        )
      end

      def supported?
        windows? || macos?
      end
      
      def name
        'Google Chrome'
      end
    end
  end
end


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
        windows?
      end

      def visit(url)
        system("#{@path} #{url}")
      end

      def to_s
        "Chrome"
      end
    end
  end
end

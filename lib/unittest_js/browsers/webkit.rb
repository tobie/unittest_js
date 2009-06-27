module UnittestJS
  module Browser
    class WebKit < Abstract
      def supported?
        macos?
      end

      def setup
        applescript('tell application "' + app_name + '" to make new document')
      end

      def visit(url)
        applescript('tell application "' + app_name + '" to set URL of front document to "' + url + '"')
      end
    end
  end
end

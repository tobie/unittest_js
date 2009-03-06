module UnittestJS
  module Browser
    class Safari < Abstract
      def supported?
        macos?
      end

      def setup
        applescript('tell application "' + to_s + '" to make new document')
      end

      def visit(url)
        applescript('tell application "' + to_s + '" to set URL of front document to "' + url + '"')
      end

      def teardown
        #applescript('tell application "' + to_s + '" to close front document')
      end

      def to_s
        "Safari"
      end
    end
  end
end

module UnittestJS
  module Browser
    class WebKit < Abstract
      def supported?
        macos?
      end

      def setup
        applescript('tell application "' + name + '" to make new document')
      end

      def visit(url)
        applescript('tell application "' + name + '" to set URL of front document to "' + url + '"')
      end
      
      private
      def applescript(script)
        raise "Can't run AppleScript on #{host}" unless macos?
        system "osascript -e '#{script}' 2>&1 >/dev/null"
      end
    end
  end
end

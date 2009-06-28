module UnittestJS
  module Browser
    class Chromium < Abstract
      def supported?
        macos?
      end
    end
  end
end


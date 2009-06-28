module UnittestJS
  module Browser
    class Firefox < Abstract
      def initialize(path=File.join(ENV['ProgramFiles'] || 'c:\Program Files', '\Mozilla Firefox\firefox.exe'))
        @path = path
      end
    end
  end
end

module UnittestJS
  module Browser
    class Firefox < Abstract
      def initialize(path=File.join(ENV['ProgramFiles'] || 'c:\Program Files', '\Mozilla Firefox\firefox.exe'))
        @path = path
      end

      def visit(url)
        system("open -a Firefox '#{url}'") if macos?
        system("#{@path} #{url}") if windows? 
        system("firefox #{url}") if linux?
      end
    end
  end
end

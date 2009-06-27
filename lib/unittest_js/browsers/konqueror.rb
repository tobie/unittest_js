module UnittestJS
  module Browser
    class Konqueror < Abstract
      @@configDir = File.join((ENV['HOME'] || ''), '.kde', 'share', 'config')
      @@globalConfig = File.join(@@configDir, 'kdeglobals')
      @@konquerorConfig = File.join(@@configDir, 'konquerorrc')

      def supported?
        linux?
      end

      # Forces KDE's default browser to be Konqueror during the tests, and forces
      # Konqueror to open external URL requests in new tabs instead of a new
      # window.
      def setup
        cd @@configDir, :verbose => false do
          copy @@globalConfig, "#{@@globalConfig}.bak", :preserve => true, :verbose => false
          copy @@konquerorConfig, "#{@@konquerorConfig}.bak", :preserve => true, :verbose => false
          # Too lazy to write it in Ruby...  Is sed dependency so bad?
          system "sed -ri /^BrowserApplication=/d  '#{@@globalConfig}'"
          system "sed -ri /^KonquerorTabforExternalURL=/s:false:true: '#{@@konquerorConfig}'"
        end
      end

      def teardown
        cd @@configDir, :verbose => false do
          copy "#{@@globalConfig}.bak", @@globalConfig, :preserve => true, :verbose => false
          copy "#{@@konquerorConfig}.bak", @@konquerorConfig, :preserve => true, :verbose => false
        end
      end

      def visit(url)
        system("kfmclient openURL #{url}")
      end
    end
  end
end
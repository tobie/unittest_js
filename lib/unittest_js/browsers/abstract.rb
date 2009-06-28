module UnittestJS
  module Browser
    class Abstract
      def supported?
        true
      end

      def setup
      end

      def teardown
      end

      def host
        require 'rbconfig'
        Config::CONFIG['host']
      end

      def macos?
        host.include?('darwin')
      end

      def windows?
        host.include?('mswin')
      end

      def linux?
        host.include?('linux')
      end
      
      def visit(url)
        if macos?
          system("open -g -a '#{name}' '#{url}'")
        elsif windows?
          system("#{path} #{url}")
        elsif linux?
          system("#{name} #{url}")
        end
      end
      
      def installed?
        if macos?
          File.exists?(path)
        else
          true #TODO
        end
      end
      
      def name
        n = self.class.name.split('::').last
        linux? ? n.downcase : n
      end
      
      def path
        if macos?
          File.expand_path("/Applications/#{name}.app")
        else
          @path
        end
      end
      
      def to_s
        name
      end
    end
  end
end

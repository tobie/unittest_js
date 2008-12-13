module UnittestJS
  module WEBrickRunner
    class RunnerOptions
      INPUT    = 'tmp'
      ASSETS   = 'assets'
      FIXTURES = 'fixtures'
      
      def initialize(options = {})
        @options = options
      end
      
      def test_dir
        @test_dir ||= DirPathname.new(@options[:test_dir] || File.join(File.dirname($0), INPUT))
      end
      
      def assets_dir
        @assets_dir ||= normalize_dir(@options[:assets_dir], ASSETS)
      end
      
      def fixtures_dir
        @fixtures_dir ||= normalize_dir(@options[:fixtures_dir], FIXTURES)
      end
      
      def port
        @port ||= @options[:port] || 4711
      end
      
      def test_file_suffix
        @test_file_suffix ||= @options[:test_file_suffix] || '_test.html'
      end
      
      def test_file_pattern
        "*#{test_file_suffix}"
      end
      
      private
        def normalize_dir(dir, default)
          dir = File.join(test_dir, default) unless dir
          DirPathname.new(dir)
        end
    end
  end
end

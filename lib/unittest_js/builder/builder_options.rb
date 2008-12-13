module UnittestJS
  module Builder
    class BuilderOptions
      OUTPUT     = 'tmp'
      ASSETS     = 'assets'
      LIB_ASSETS = 'lib_assets'
      FIXTURES   = 'fixtures'
      TEMPLATES  = 'templates'
      TESTS      = 'tests'
      
      def initialize(options = {})
        @options = options
      end
      
      def input_dir
        @input_dir ||= DirPathname.new(@options[:input_dir] || File.join(File.dirname($0), INPUT))
      end
      
      def assets_dir
        @assets_dir ||= normalize_input_dir(@options[:assets_dir], ASSETS)
      end
      
      def fixtures_dir
        @fixtures_dir ||= normalize_input_dir(@options[:fixtures_dir], FIXTURES)
      end
      
      def templates_dir
        @templates_dir ||= normalize_input_dir(@options[:templates_dir], TEMPLATES)
      end
      
      def output_dir
        @output_dir ||= DirPathname.new(@options[:output_dir] ? @options[:output_dir] : input_dir.join(OUTPUT))
      end
      
      def output_assets_dir
        @output_assets_dir ||= DirPathname.new(output_dir, @options[:output_assets_dir_name] || ASSETS)
      end
      
      def output_unittest_assets_dir
        @output_unittest_assets_dir ||= DirPathname.new(output_dir, LIB_ASSETS)
      end
      
      def output_fixtures_dir
        @output_fixtures_dir ||= DirPathname.new(output_dir, @options[:output_fixtures_dir_name] || FIXTURES)
      end
      
      def output_tests_dir
        @output_tests_dir ||= DirPathname.new(output_dir, TESTS)
      end

      def template
        @template ||= Template.from(@options[:template] || :default, templates_dir)
      end
      
      def test_file_suffix
        @test_file_suffix ||= @options[:test_file_suffix] || '_test.js'
      end
      
      def test_file_pattern
        "*#{test_file_suffix}"
      end
      
      def self_contained?
        @self_contained ||= @options[:self_contained] || true
      end

      private
        def normalize_input_dir(dir, default)
          dir = File.join(input_dir, default) unless dir
          DirPathname.new(dir)
        end
    end
  end
end

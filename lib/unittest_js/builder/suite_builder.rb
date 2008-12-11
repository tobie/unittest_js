module UnittestJS
  module Builder
    class SuiteBuilder
      def initialize(options = {})
        @options = BuilderOptions.new(options)
      end
      
      def collect(*args)
        if args.empty?
          @tests = all_tests
        else
          @tests = all_tests.select { |test| args.include?(test.name) }
        end
      end
      
      def render
        assets_handler.copy
        @options.output_tests_dir.mk_and_stamp!
        render_tests
      end
      
      def assets_handler
        @assets_handler ||= AssetsHandler.new(@options)
      end
      
      def render_tests
        @tests.each { |test| test.render }
      end
      
      private
        def all_tests
          @all_tests ||= Dir[@options.input_dir.join(@options.test_file_pattern)].map do |file|
            TestBuilder.new(file, @options)
          end
        end
    end
  end
end

module UnittestJS
  module WEBrickRunner
    class SuiteResults
      attr_reader :browser, :tests, :assertions, :failures, :errors
      def initialize(browser)
        @browser    = browser.to_s
        @tests      = 0
        @assertions = 0
        @failures   = 0
        @errors     = 0
        @error_files   = []
        @failure_files = []
      end

      def <<(result)
        @tests      += result.tests
        @assertions += result.assertions
        @failures   += result.failures
        @errors     += result.errors
        @error_files.push(result.filename)   if result.error?
        @failure_files.push(result.filename) if result.failure?
      end

      def error?
        @errors > 0
      end

      def failure?
        @failures > 0
      end

      def to_s
        str = ""
        str << "\n  Failures: #{@failure_files.join(', ')}" if failure?
        str << "\n  Errors:   #{@error_files.join(', ')}" if error?
        "#{str}\n#{summary}\n\n"
      end

      def summary
        "#{@tests} tests, #{@assertions} assertions, #{@failures} failures, #{@errors} errors."
      end
    end
  end
end
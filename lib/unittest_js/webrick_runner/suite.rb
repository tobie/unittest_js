module UnittestJS
  module WEBrickRunner
    class Suite
      def initialize(browser, tests)
        @browser = browser
        @tests   = tests
        @results = SuiteResults.new(@browser)
      end

      def run(queue)
        setup
        @tests.each do |test|
          test.run(@browser, @results, queue)
        end
        teardown
      end

      def setup
        @browser.setup
        puts "\nStarted tests in #{@browser}."
        @t0 = Time.now
      end

      def teardown
        print "\nFinished in #{Time.now - @t0} seconds."
        print @results
        @browser.teardown
      end
    end
  end
end

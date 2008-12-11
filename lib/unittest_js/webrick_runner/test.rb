module UnittestJS
  module WEBrickRunner
    class Test
      def initialize(filename, testcases, options)
        @filename  = filename
        @testcases = testcases
        @options   = options
      end

      def run(browser, results, queue)
        browser.visit(url)
        result = queue.pop
        results << result
        print result
      end

      def url
        "http://localhost:#{@options.port}/#{@options.test_dir.name}/#{@filename}?#{params}"
      end

      def to_s
        @filename
      end

      private
        def params
          {
            :resultsURL => "http://localhost:#{@options.port}/results",
            :t          => "%.6f" % Time.now.to_f,
            :tests      => @testcases
          }.map { |k, v| "#{k}=#{v}" if v }.compact.join('&')
        end
    end
  end
end
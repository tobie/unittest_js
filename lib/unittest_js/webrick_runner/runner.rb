module UnittestJS
  module WEBrickRunner
    class Runner
      def initialize(options = {})
        @options  = RunnerOptions.new(options)
        @tests    = []
        @browsers = []
        @queue    = Queue.new
        @server   = WEBrick::HTTPServer.new(:Port => @options.port)
        mount_default_servlets
        mount_helper_servlets
      end

      def run
        t = Thread.new { setup }
        @browsers.each do |browser|
          if browser.supported?
            Suite.new(browser, @tests).run(@queue)
          else
            puts "\nSkipping #{browser}, not supported on this OS."
          end
        end
        teardown
        t.join
      end

      def setup
        @server.start
      end

      def teardown
        @server.shutdown
      end

      def mount(path, dir=nil)
        dir = Dir.pwd + path unless dir
        @server.mount(path, Servlet::NonCachingFileHandler, dir)
      end
      
      # def collect_tests(tests = nil, testcases = nil)
      #         Dir[@options.test_dir.join('*_test.html')].each do |file|
      #           file = File.basename(file)
      #           add_test(file, testcases)
      #         end
      #       end

      def add_test(filepath, testcases = nil)
        @tests << Test.new(filepath, testcases, @options)
      end

      def add_browser(browser)
        browser =
          case(browser)
            when :firefox
              Browser::Firefox.new
            when :safari
              Browser::Safari.new
            when :safari20, :safari200
              Browser::Safari.new('2.0')
            when :safari202
              Browser::Safari.new('2.0.2')
            when :safari203
              Browser::Safari.new('2.0.3')
            when :safari204
              Browser::Safari.new('2.0.4')
            when :safari304
              Browser::Safari.new('3.0.4')
            when :safari312
              Browser::Safari.new('3.1.2')
            when :safari321
              Browser::Safari.new('3.2.1')
            when :ie
              Browser::IE.new
            when :konqueror
              Browser::Konqueror.new
            when :opera
              Browser::Opera.new
            when :chrome
              Browser::Chrome.new
            when :chromium
              Browser::Chromium.new
            when :webkit
              Browser::WebKit.new
            else
              browser
          end

        @browsers << browser
      end

      private
        def mount_default_servlets
          @server.mount('/results', Servlet::Result, @queue)
          Dir.chdir(@options.test_dir.join('..')) do
            mount('/')
            mount("/#{@options.test_dir.name}")
            mount("/#{@options.fixtures_dir.name}")
            mount("/#{@options.assets_dir.name}")
          end
        end

        def mount_helper_servlets
          @server.mount('/response', Servlet::Basic)
          @server.mount('/slow',     Servlet::Slow)
          @server.mount('/down',     Servlet::Down)
          @server.mount('/inspect',  Servlet::Inspection)
        end
    end
  end
end
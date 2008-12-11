module UnittestJS
  module WEBrickRunner
    module Servlet
      class Slow < Basic
        def do_GET(req, res)
          sleep(2)
          super
        end
      end
    end
  end
end


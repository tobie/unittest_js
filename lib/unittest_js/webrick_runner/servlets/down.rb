module UnittestJS
  module WEBrickRunner
    module Servlet
      class Down < Basic
        def do_GET(req, res)
          res.fail_silently!
        end
      end
    end
  end
end


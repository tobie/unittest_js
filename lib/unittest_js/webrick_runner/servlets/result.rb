module UnittestJS
  module WEBrickRunner
    module Servlet
      class Result < WEBrick::HTTPServlet::AbstractServlet
        def do_GET(req, res)
          prevent_caching(res)
          queue.push(WEBrickRunner::TestResults.new(req))
          raise WEBrick::HTTPStatus::OK
        end

        def queue
          @options.first
        end

        def do_POST(req, res)
          do_GET(req, res)
        end
      end
    end
  end
end


module UnittestJS
  module WEBrickRunner
    module Servlet
      class Basic < WEBrick::HTTPServlet::AbstractServlet
        def do_GET(req, res)
          prevent_caching(res)
          res['Content-Type'] = "text/plain"

          req.query.each do |k, v|
            res[k] = v unless k == 'responseBody'
          end
          res.body = req.query["responseBody"]

          raise WEBrick::HTTPStatus::OK
        end

        def do_POST(req, res)
          do_GET(req, res)
        end
      end
    end
  end
end


module UnittestJS
  module WEBrickRunner
    module Servlet
      class Inspection < Basic
        def do_GET(req, res)
          prevent_caching(res)
          res['Content-Type'] = "application/json"
          res.body = req.to_json
          raise WEBrick::HTTPStatus::OK
        end
      end
    end
  end
end


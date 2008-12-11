module UnittestJS
  module WEBrickRunner
    module Servlet
      class NonCachingFileHandler < WEBrick::HTTPServlet::FileHandler
        def do_GET(req, res)
          super
          res['Content-Type'] = default_content_type(req.path)
          prevent_caching(res)
        end

        def default_content_type(path)
          case path
            when /\.js$/   then 'text/javascript'
            when /\.html$/ then 'text/html'
            when /\.css$/  then 'text/css'
            else 'text/plain'
          end
        end
      end
    end
  end
end


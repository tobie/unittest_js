module UnittestJS
  module WEBrickRunner
    module Servlet
      class TestList < WEBrick::HTTPServlet::AbstractServlet
        
        def initialize(server, options)
          super(server)
          @options = options
        end
        
        def do_GET(req, res)
          html_for_tests = @options[:tests].map do |test|
            %Q{<li><a href="#{test.url}">#{test.to_s}</a></li>}
          end
          
          html = <<-HTML
          <!DOCTYPE html>
          <html>
            <head>
              <title>Tests</title>
              <style type="text/css" media="screen">
                body {
                  font-family: Verdana, sans-serif;
                  font-size: 12px;
                  line-height: 130%;
                }
                
                h1 {
                  font-family: "Helvetica Neue", Helvetica, sans-serif;
                }
              </style>
            </head>
            <body>
              <h1>Tests</h1>
              <ul>
                #{html_for_tests.join("\n")}
              </ul>
            </body>
          </html>
          HTML
          
          res['Content-Type'] = 'text/html'
          res.status = 200
          res.body = html
        end
      end # TestList
    end
  end
end


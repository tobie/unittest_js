class ::WEBrick::HTTPServer
 def access_log(config, req, res)
   # nop
 end
end

class ::WEBrick::BasicLog
 def log(level, data)
   # nop
 end
end

class ::WEBrick::HTTPResponse
  alias send send_response
  def send_response(socket)
    send(socket) unless fail_silently?
  end
  
  def fail_silently?
    @fail_silently
  end
  
  def fail_silently!
    @fail_silently = true
  end
end

class ::WEBrick::HTTPRequest
  def to_json
    headers = []
    each { |k, v| headers.push "#{k.inspect}: #{v.inspect}" }
    headers = "{" << headers.join(', ') << "}"
    %({ "headers": #{headers}, "body": #{body.inspect}, "method": #{request_method.inspect} })
  end
end

class ::WEBrick::HTTPServlet::AbstractServlet
  def prevent_caching(res)
    res['ETag']          = nil
    res['Last-Modified'] = Time.now + 100**4
    res['Cache-Control'] = 'no-store, no-cache, must-revalidate, post-check=0, pre-check=0'
    res['Pragma']        = 'no-cache'
    res['Expires']       = Time.now - 100**4
  end
end
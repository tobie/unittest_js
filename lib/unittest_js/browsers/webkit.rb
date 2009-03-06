module UnittestJS
  module Browser
    class WebKit < UnittestJS::Browser::Safari
      def to_s
        "WebKit"
      end
    end
  end
end

module UnittestJS
  module Builder
    module HtmlHelper
      def to_script_tag(filename)
        "<script src=\"#{filename}?#{cache_buster}\" type=\"text/javascript\" charset=\"utf-8\"></script>"
      end

      def to_link_tag(filename)
        "<link rel=\"stylesheet\" href=\"#{filename}?#{cache_buster}\" type=\"text/css\" />"
      end
      
      def cache_buster
        @cache_buster ||= Time.now.to_i.to_s
      end
    end
  end
end

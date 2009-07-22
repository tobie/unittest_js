module UnittestJS
  module Builder
    module HtmlHelper
      def script_tag(filename)
        "<script src=\"#{filename}?#{cache_buster}\" type=\"text/javascript\" charset=\"utf-8\"></script>"
      end
      # for backwards compatibility:
      alias :to_script_tag :script_tag
      
      def link_tag(filename)
        "<link rel=\"stylesheet\" href=\"#{filename}?#{cache_buster}\" type=\"text/css\" />"
      end
      # for backwards compatibility:
      alias :to_link_tag :link_tag
      
      def cache_buster
        @cache_buster ||= Time.now.to_i.to_s
      end
    end
  end
end

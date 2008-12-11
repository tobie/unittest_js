module UnittestJS
  module Builder
    module HtmlHelper
      def to_script_tag(filename)
        "<script src=\"#{filename}\" type=\"text/javascript\" charset=\"utf-8\"></script>"
      end

      def to_link_tag(filename)
        "<link rel=\"stylesheet\" href=\"#{filename}\" type=\"text/css\" />"
      end
    end
  end
end

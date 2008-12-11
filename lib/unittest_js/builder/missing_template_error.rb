module UnittestJS
  module Builder
    class MissingTemplateError < StandardError
      def initialize(template)
        super("Can't find template '#{template}'")
      end
    end
  end
end

module UnittestJS
  module Builder
    class Fixture
      include HtmlHelper
      
      attr_reader :name
      def initialize(name, options)
        @name = name
        @options = options
      end
    
      def exists?
        File.exists?(filepath)
      end
    
      def filepath
        @options.fixtures_dir.join(name)
      end
      
      def rel_filepath
        @options.output_fixtures_dir.join(name).relative_path_from(@options.output_dir)
      end
    
      def filename
        name
      end
    end
  
    class HTMLFixture < Fixture
      def initialize(name, options)
        super("#{name}.html", options)
      end
    
      def to_s
        exists? ? File.read(filepath) : ''
      end
    end
  
    class CSSFixture < Fixture
      def initialize(name, options)
        super("#{name}.css", options)
      end
      
      def to_s
        exists? ? to_link_tag(rel_filepath) : ''
      end
    end
  
    class JSFixture < Fixture
      def initialize(name, options)
        super("#{name}.js", options)
      end
      
      def to_s
        exists? ? to_script_tag(rel_filepath) : ''
      end
    end
  end
end

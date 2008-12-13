module UnittestJS
  module Builder
    class TestBuilder
      include HtmlHelper
      
      attr_reader :name, :file, :filename
      alias :path :file
      alias :pathname :file
      
      def initialize(file, options)
        @file     = file
        @options  = options
        @filename = File.basename(file)
        @name     = @filename.sub(@options.test_file_suffix, '')
      end
      
      def html_fixtures
        @html_fixtures ||= HTMLFixture.new(name, @options)
      end
      
      def js_fixtures
        @js_fixtures ||= JSFixture.new(name, @options)
      end
      
      def css_fixtures
        @css_fixtures ||= CSSFixture.new(name, @options)
      end
      
      def test_file
        to_script_tag("#{@options.output_tests_dir.name}/#{filename}")
      end
      
      def timestamp
        @timestamp ||= Time.now.strftime("%Y-%m-%d %H:%M")
      end
      
      def lib_files
        assets = @options.output_unittest_assets_dir.name
        [
          to_script_tag("#{assets}/prototype.js"),
          to_script_tag("#{assets}/unittest.js"),
          to_link_tag("#{assets}/unittest.css")
        ].join("\n")
      end
      
      def title
        @title ||= name.split('_').map{ |w| w.capitalize }.join(' ').strip
      end
      
      def render
        File.open(rendered_file, 'w+') do |file|
          file << template.result(binding)
        end
        copy_file
      end
      
      def rendered_filename
        to_filename(name, short_template_name, 'test', :html)
      end
      
      def rendered_file
        @options.output_dir.join(rendered_filename)
      end
      
      def template
        @options.template
      end
      
      def template_name
        template.name
      end
      
      private
        def short_template_name
          template_name == 'default' ? '' : template_name
        end
        
        def to_filename(*args)
          args.reject!{ |a| a.nil? || a === '' }
          ext = args.pop
          "#{args.join('_')}.#{ext}"
        end
        
        def copy_file
          FileUtils.cp(file, @options.output_tests_dir)
        end
    end
  end
end


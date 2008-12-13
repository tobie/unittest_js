module UnittestJS
  module Builder
    class AssetsHandler
      ASSETS = 'assets'
      
      def initialize(options = {})
        @options = options
      end
      
      def copy_assets
        if @options.assets_dir.exists?
          assets = Dir[@options.assets_dir.join('*')]
          @options.output_assets_dir.mk_and_stamp!
          FileUtils.cp_r(assets, @options.output_assets_dir)
        end
      end
      
      def copy_unittest_assets
        @options.output_unittest_assets_dir.mk_and_stamp!
        assets = Dir[unittest_assets_dir.join('*')]
        FileUtils.cp_r(assets, @options.output_unittest_assets_dir)
      end
      
      def unittest_assets_dir
        @unittest_assets_dir ||= DirPathname.new(File.dirname(__FILE__), '..', '..', '..', ASSETS)
      end
      
      def copy_fixtures
        @options.fixtures_dir.copy_to(@options.output_fixtures_dir) if @options.fixtures_dir.exists?
      end
      
      def copy
        copy_unittest_assets
        copy_assets
        copy_fixtures
      end
    end
  end
end

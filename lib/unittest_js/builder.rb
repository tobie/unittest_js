$:.unshift File.expand_path(File.join(File.dirname(__FILE__), 'builder'))

require 'assets_handler'
require 'html_helper'
require 'test_builder'
require 'template'
require 'fixtures'
require 'builder_options'
require 'suite_builder'
require 'missing_template_error'

module UnittestJS
  module Builder
    def self.empty_dir!(dir)
      dir = DirPathname.new(dir)
      dir.exists? ? dir.empty! : dir.mk_and_stamp!
    end
  end
end

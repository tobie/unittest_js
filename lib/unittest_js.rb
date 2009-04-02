require 'fileutils'
include FileUtils

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), 'unittest_js'))

require File.expand_path(File.join(File.dirname(__FILE__), 'unittest_js', 'dir_pathname'))
require File.expand_path(File.join(File.dirname(__FILE__), 'unittest_js', 'builder'))
require File.expand_path(File.join(File.dirname(__FILE__), 'unittest_js', 'webrick_runner'))
require File.expand_path(File.join(File.dirname(__FILE__), 'unittest_js', 'browsers'))

module UnittestJS
  TEMPLATES_DIR_NAME = 'templates'
  FIXTURES_DIR_NAME  = 'fixtures'
  ASSETS_DIR_NAME    = 'assets'
  
  def self.browsers
    @browsers ||= Browser.supported.freeze
  end
end

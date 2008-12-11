require 'fileutils'
include FileUtils

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), 'unittest_js'))

require 'dir_pathname'
require 'builder'
require 'webrick_runner'
require 'browsers'

module UnittestJS
  TEMPLATES_DIR_NAME = 'templates'
  FIXTURES_DIR_NAME  = 'fixtures'
  ASSETS_DIR_NAME    = 'assets'
  
  def self.browsers
    @browsers ||= Browser.supported.freeze
  end
end
$:.unshift File.expand_path(File.join(File.dirname(__FILE__), 'servlets'))

require 'basic'
require 'slow'
require 'down'
require 'inspection'
require 'file_handler'
require 'result'
require 'test_list'

module UnittestJS
  module WEBrickRunner
    module Servlet
    end
  end
end


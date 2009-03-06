$:.unshift  File.expand_path(File.join(File.dirname(__FILE__), 'browsers'))

require 'abstract'

module UnittestJS
  module Browser
    SUPPORTED = %w[chrome firefox ie konqueror opera safari webkit].freeze
  end
end

UnittestJS::Browser::SUPPORTED.each{ |browser| require browser }
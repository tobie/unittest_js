require 'uri'
module UnittestJS
  module WEBrickRunner
    class TestResults
      FAILURE = 'F'
      ERROR   = 'E'
      SUCCESS = '.'

      attr_reader :tests, :assertions, :failures, :errors

      def initialize(req)
        @req        = req
        @tests      = req.query['tests'].to_i
        @assertions = req.query['assertions'].to_i
        @failures   = req.query['failures'].to_i
        @errors     = req.query['errors'].to_i
      end

      def filename
        @filename ||= URI::parse(@req.header['referer'].first).path
      end

      def error?
        @errors > 0
      end

      def failure?
        @failures > 0
      end

      def to_s
        if error?
          ERROR
        elsif failure?
          FAILURE
        else
          SUCCESS
        end
      end
    end
  end
end
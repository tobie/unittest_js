require 'erb'
module UnittestJS
  module Builder
    class Template
      TEMPLATES = 'templates'
      TEMPLATES_DIR = DirPathname.new(File.dirname(__FILE__), '..', '..', '..', TEMPLATES)
      
      def self.default_dir
        TEMPLATES_DIR
      end
      
      def self.from(name, directory = nil)
        if name.is_a?(Symbol)
          self.from_sym(name, directory)
        elsif File.exists?(name)
          self.from_file(name)
        else
          self.from_filename(name, directory)
        end
      end
      
      def self.from_sym(sym, directory = nil)
        self.from_filename("#{sym}.erb", directory)
      end
      
      def self.from_filename(filename, directory = nil)
        file = directory.join(filename) if directory
        file = self.default_dir.join(filename) unless file.exists?
        raise MissingTemplateError.new(filename) unless file.exists?
        self.new(file)
      end
      
      def self.from_file(file)
        raise MissingTemplateError.new(file) unless File.exist?(file)
        self.new(file)
      end
      
      def initialize(file)
        @file = file
        @template = ERB.new(IO.read(file), nil, '%')
      end
    
      def result(bind)
        @template.result(bind)
      end
      
      def name
        @name ||= File.basename(@file, File.extname(@file))
      end
    
      def to_s
        name
      end
    end
  end
end

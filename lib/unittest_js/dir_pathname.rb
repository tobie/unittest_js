require 'pathname'
module UnittestJS
  class DirPathname < Pathname
    STAMP = '.unittest'
    
    alias :path :to_s
    alias :to_str :to_s
    
    def initialize(*args)
      args.map! { |a| a.to_s }
      super(File.expand_path(File.join(args)))
    end
    
    def name
      File.basename(path)
    end

    def exists?
      File.exists?(path)
    end
    
    def empty?
      Dir.entries(path).size <= 2
    end
    
    def writeable?
      exists? && !frozen? && (empty? || stamped?)
    end
    
    def stamp!
      File.open(stamp, 'w+') unless frozen?
    end
    
    def stamped?
      File.exists?(stamp)
    end
    
    def mk!
      Dir.mkdir(path)
    end
    
    def mk_and_stamp!
      unless exists?
        mk!
        stamp!
      end
    end
    
    def empty!
      if writeable?
        FileUtils.rm_rf(path)
        mk_and_stamp!
      else
        raise "Cannot empty directory '#{name}'."
      end
    end
    
    def copy_to(dest)
      FileUtils.cp_r(path, dest.to_s)
    end
    
    def join(*args)
      self.class.new(path, *args)
    end
    
    def freeze
      @frozen = true
      self
    end
    
    def frozen?
      @frozen ||= false
    end
    
    private
      def stamp
        join(STAMP)
      end
  end
end

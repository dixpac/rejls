module ActiveSupport
  module Dependecies
    extend self

    attr_accessor :autoload_paths

    def search_for_file(name)
      autoload_paths.each do |path|
        file = File.join(path, "#{name}.rb")
        if File.file? file
          return file
        end
      end
      nil
    end

  end
end

class Module
  def const_missing(name)
    if file = ActiveSupport::Dependecies.search_for_file(name.to_s.underscore)
      require file.sub(/\.rb$/, '')
      const_get name
    else
      raise NameError, "Unitialize instance #{name}"
    end
  end
end

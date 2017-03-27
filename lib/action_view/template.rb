require "erb"

module ActionView
  class Template
    def initialize(source, name)
      @source = source
      @name = name
      @compiled = false
    end

    def method_name
      @name.gsub(/[^\w]/, "_")
    end

    def render(context, &block)
      compile
      context.send(method_name, &block)
    end

    def compile
      return if @compiled

      code = ERB.new(@source).src

      CompiledTemplates.module_eval <<-CODE
        def #{method_name}
          #{code}
        end
      CODE

      @compiled = true
    end
  end
end

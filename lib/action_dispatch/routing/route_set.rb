module ActionDispatch
  module Routing
    class Route < Struct.new(:method, :path, :controller, :action, :name)
      def match?(request)
        method == request.request_method && path == request.path_info
      end
    end

    class RouteSet
      def initialize
        @routes = []
      end

      def add_route(*args)
        route = Route.new(*args)
        @routes << route
        route
      end

      def find_route(request)
        @routes.detect { |route| route.match?(request) }
      end

      def draw(&block)
        mapper = Mapper.new(self)
        mapper.instance_exec(&block)
      end
    end
  end
end

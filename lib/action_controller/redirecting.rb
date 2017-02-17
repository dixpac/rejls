module ActionController
  module Redirecting
    def redirect_to(location)
      response.status = 302
      response.location = location
      response.body = ["Redirecting..."]
    end
  end
end

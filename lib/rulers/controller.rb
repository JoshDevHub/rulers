require "erubis"
require "rack/request"
require "rulers/file_model"

module Rulers
  class Controller
    include Rulers::Model

    attr_reader :env

    def initialize(env)
      @env = env
    end

    def render(view_name, locals = {})
      File
        .join("app", "views", controller_name, "#{view_name}.html.erb")
        .then { File.read _1 }
        .then { Erubis::Eruby.new _1 }
        .result(locals.merge(env:))
    end

    def controller_name
      entity_name = self.class.to_s.delete_suffix("Controller")
      Rulers.to_underscore entity_name
    end

    def request
      @request ||= Rack::Request.new(@env)
    end

    def params
      request.params
    end

    def response(text, status = 200, headers = {})
      raise "Already responded!" if @response

      a = [text].flatten
      @response = Rack::Response.new(a, status, headers)
    end

    def get_response
      @response
    end

    def render_response(*args)
      response(render(*args))
    end
  end
end

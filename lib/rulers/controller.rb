require "erubis"
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
  end
end

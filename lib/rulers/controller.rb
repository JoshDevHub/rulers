require "erubis"

module Rulers
  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end

    def render(view_name)
      filename = File.join "app", "views", controller_name, "#{view_name}.html.erb"
      template = File.read filename
      eruby = Erubis::Eruby.new(template)

      eruby.evaluate(self)
    end

    def controller_name
      entity_name = self.class.to_s.delete_suffix("Controller")
      Rulers.to_underscore entity_name
    end
  end
end

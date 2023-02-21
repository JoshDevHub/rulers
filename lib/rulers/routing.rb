module Rulers
  class Application
    def get_controller_and_action(env)
      return [HomeController, :index] if env["PATH_INFO"] == "/"

      _, cont, action, = env["PATH_INFO"].split("/", 4)
      cont = cont.capitalize
      cont += "Controller"

      [Object.const_get(cont), action]
    end
  end
end

# frozen_string_literal: true

require "rulers/version"
require "rulers/array"
require "rulers/routing"

module Rulers
  class Application
    CONTENT_HEADER = { "Content-Type" => "text/html" }.freeze

    def call(env)
      return not_found if env["PATH_INFO"] == "/favicon.ico"

      begin
        klass, act = get_controller_and_action(env)
        controller = klass.new(env)
        text = controller.send(act)
        [
          200,
          CONTENT_HEADER,
          [text]
        ]
      rescue NameError
        [
          500,
          CONTENT_HEADER,
          ["Rescued a controller exception!"]
        ]
      end
    end

    private

    def not_found
      [
        404,
        CONTENT_HEADER,
        []
      ]
    end
  end

  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end
  end
end

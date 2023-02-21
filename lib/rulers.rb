# frozen_string_literal: true

require "rulers/version"
require "rulers/array"
require "rulers/routing"

module Rulers
  class Application
    CONTENT_HEADER = { "Content-Type" => "text/html" }.freeze
    STATUS = {
      ok: 200,
      not_found: 404,
      internal_server_error: 500
    }.freeze

    def call(env)
      if env["PATH_INFO"] == "/favicon.ico"
        return [
          STATUS[:not_found],
          CONTENT_HEADER,
          []
        ]
      end

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      begin
        text = controller.send(act)
        [
          STATUS[:ok],
          CONTENT_HEADER,
          [text]
        ]
      rescue RuntimeError
        [
          STATUS[:internal_server_error],
          CONTENT_HEADER,
          ["Rescued a controller exception!"]
        ]
      end
    end
  end

  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end
  end
end

# frozen_string_literal: true

require "rulers/version"
require "rulers/array"
require "rulers/routing"
require "rulers/util"
require "rulers/dependencies"

module Rulers
  class Application
    STATUS_CODES = {
      ok: 200,
      not_found: 404,
      internal_error: 500
    }.freeze

    def call(env)
      return build_html_response(:not_found) if env["PATH_INFO"] == "/favicon.ico"

      begin
        klass, act = get_controller_and_action(env)
        controller = klass.new(env)
        text = controller.send(act)
        build_html_response(:ok, text)
      rescue NameError
        build_html_response(:internal_error, "Controller error raised!")
      end
    end

    private

    def build_html_response(status_name, text_content = "")
      [
        STATUS_CODES.fetch(status_name),
        { "Content-Type" => "text/html" },
        [text_content]
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

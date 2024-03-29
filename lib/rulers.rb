# frozen_string_literal: true

require "rulers/array"
require "rulers/controller"
require "rulers/dependencies"
require "rulers/file_model"
require "rulers/routing"
require "rulers/util"
require "rulers/version"

module Rulers
  def self.framework_root
    __dir__
  end

  class Application
    STATUS_CODES = {
      ok: 200,
      not_found: 404,
      internal_error: 500
    }.freeze

    def call(env)
      return build_html_response(:not_found) if env["PATH_INFO"] == "/favicon.ico"

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      res = controller.get_response
      if res
        [res.status, res.headers, [res.body].flatten]
      else
        build_html_response(:ok, text)
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
end

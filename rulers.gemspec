# frozen_string_literal: true

require_relative "lib/rulers/version"

Gem::Specification.new do |spec|
  spec.name = "rulers"
  spec.version = Rulers::VERSION
  spec.authors = ["Josh"]
  spec.email = ["jmsmith1018@gmail.com"]

  spec.summary = "A Rack-based Web Framework"
  spec.description = "A Rack-based Web Framework"
  spec.homepage = ""
  spec.required_ruby_version = ">= 3.1.2"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "erubis"
  spec.add_dependency "rack", "~>2.2"
  spec.add_dependency "webrick"

  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rack-test"
end

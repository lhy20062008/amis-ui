# frozen_string_literal: true

require_relative "lib/amis_ui/version"

Gem::Specification.new do |spec|
  spec.name = "amis_ui"
  spec.version = AmisUi::VERSION
  spec.authors = ["Amis UI contributors"]
  spec.summary = "Small Rails view helpers for building AMis schemas"
  spec.description = "A small collection of Rails view helpers for building AMis JSON schemas."
  spec.homepage = "https://github.com/lhy20062008/amis-ui"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0"

  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = if File.directory?(File.join(__dir__, ".git"))
    Dir.chdir(__dir__) { `git ls-files -z`.split("\x0") }
  else
    []
  end
  # Keep the gem usable before the repository has been initialised with Git.
  spec.files = Dir["LICENSE.txt", "README.md", "lib/**/*"] if spec.files.empty?
  spec.require_paths = ["lib"]

  spec.add_dependency "railties", ">= 6.1", "< 9.0"

  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake", "~> 13.0"
end

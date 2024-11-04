# frozen_string_literal: true

require_relative "lib/omniauth/asana/version"

Gem::Specification.new do |spec|
  spec.name = "omniauth-asana"
  spec.version = Omniauth::Asana::VERSION
  spec.authors = ["Italo Matos"]
  spec.email = ["italomatos@gmail.com"]

  spec.summary       = "OmniAuth strategy for Asana"
  spec.description   = "This gem provides an OmniAuth strategy for authenticating with Asana using OAuth2."
  spec.homepage = "https://github.com/italomatos/omniauth-asana"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/italomatos/omniauth-asana"
  spec.metadata["changelog_uri"] = "https://github.com/italomatos/omniauth-asana/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "omniauth", "~> 2.0"
  spec.add_dependency "omniauth-oauth2", "~> 1.7"
end

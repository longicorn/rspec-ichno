# frozen_string_literal: true

require_relative "lib/rspec/ichno/version"

Gem::Specification.new do |spec|
  spec.name = "rspec-ichno"
  spec.version = Rspec::Ichno::VERSION
  spec.authors = ["longicorn"]
  spec.email = ["longicorn.c@gmail.com"]

  spec.summary = "An RSpec adapter for `ichno` that enables intelligent test skipping based on OS-level file dependency tracking."
  spec.description = "rspec-ichno integrates RSpec with the `ichno` tool to precisely track file dependencies during test execution. Unlike traditional Ruby-only caching, it leverages OS-level monitoring (fanotify) to detect access to any file type—including JavaScript, configuration files, and assets. This ensures safe and efficient test skipping for modern, polyglot applications where dependencies extend beyond Ruby code."
  spec.homepage = "https://github.com/longicorn/rspec-ichno"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore test/ .github/])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rspec"
end

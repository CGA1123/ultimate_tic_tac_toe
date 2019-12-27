lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ultimate_tic_tac_toe/version"

Gem::Specification.new do |spec|
  spec.name = "ultimate_tic_tac_toe"
  spec.version = UltimateTicTacToe::VERSION
  spec.authors = ["Christian Gregg"]
  spec.email = ["c_arlt@hotmail.com"]

  spec.summary = "A ruby ultimate tic-tac-toe server"
  spec.homepage = "https://github.com/CGA1123/utimate_tic_tac_toe"
  spec.license = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "standard"
  spec.add_development_dependency "pry"

  spec.add_dependency "google-protobuf"
  spec.add_dependency "grpc"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "omniauth-nexaas_id"
  spec.version       = "0.2.1"
  spec.authors       = ["Rodrigo Tassinari de Oliveira", "Luiz Carlos Buiatte"]
  spec.email         = ["rodrigo@pittlandia.net", "luiz.buiatte@nexaas.com"]

  spec.summary       = %q{Nexaas ID OAuth2 strategy for Omniauth.}
  spec.description   = %q{Nexaas ID OAuth2 strategy for Omniauth.}
  spec.homepage      = "https://github.com/myfreecomm/omniauth-nexaas_id"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "omniauth-oauth2", "~> 1.3"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 11.2"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "byebug", "~> 9.0"
end

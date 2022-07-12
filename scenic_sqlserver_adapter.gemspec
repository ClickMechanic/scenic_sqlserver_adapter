lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "scenic_sqlserver_adapter/version"

Gem::Specification.new do |spec|
  spec.name          = "scenic_sqlserver_adapter"
  spec.version       = ScenicSqlserverAdapter::VERSION
  spec.authors       = ["Ben Forrest"]
  spec.email         = ["ben@clickmechanic.com"]

  spec.summary       = "SQL Server adapter for Thoughtbot's Scenic gem"  
  spec.homepage      = "https://github.com/ClickMechanic/scenic_sqlserver_adapter"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]
  
  spec.add_dependency "scenic", "~> 1.4"
  spec.add_dependency "activerecord", ">= 4.0", "< 8"
  
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'rspec_junit_formatter'
end

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vindinium/client'

Gem::Specification.new do |spec|
  spec.name     = 'vindinium-client'
  spec.version  = Vindinium::Client::VERSION
  spec.summary  = 'A Ruby client for the Vindinium game'
  spec.authors  = ['Eric MSP Veith']
  spec.email    = ['eveith+vindinium@veith-m.de']
  spec.license  = 'GPLv3'
  spec.homepage = 'https://github.com/eveith/vindinium-client'
  spec.files    = Dir['lib/**/*.rb'] + Dir['test/**/*.rb']
end

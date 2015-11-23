lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xhyve/version'

Gem::Specification.new do |s| 
  s.name        = 'xhyve-ruby'
  s.version     = Xhyve::VERSION
  s.date        = '2015-11-23'
  s.summary     = 'Ruby wrapper for xhyve'
  s.description = 'Provides a means of interacting with xhyve from ruby'
  s.authors     = ['Dale Hamel']
  s.email       = 'dale.hamel@srvthe.net'
  s.files       = Dir['lib/**/*', 'ext/**/*']
  s.homepage    =   
    'http://rubygems.org/gems/ruby-xhyve'
  s.license       = 'MIT'
  s.add_development_dependency 'rake', ['=10.4.2']
  s.add_development_dependency 'rake-compiler', ['=0.9.5']
  s.extensions = %w[ext/vmnet/extconf.rb]
end

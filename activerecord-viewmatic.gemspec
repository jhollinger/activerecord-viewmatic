require_relative 'lib/viewmatic/version'

Gem::Specification.new do |s|
  s.name = 'activerecord-viewmatic'
  s.version = Viewmatic::VERSION
  s.licenses = ['MIT']
  s.summary = "An easy way to use database views in ActiveRecord"
  s.description = "Helpers for using live and materialized views in ActiveRecord"
  s.date = '2017-10-10'
  s.authors = ['Jordan Hollinger']
  s.email = 'jordan.hollinger@gmail.com'
  s.homepage = 'https://github.com/jhollinger/activerecord-viewmatic'
  s.require_paths = ['lib']
  s.files = [Dir.glob('lib/**/*'), 'README.md'].flatten
  s.required_ruby_version = '>= 2.1.0'
  s.add_runtime_dependency 'activerecord', ['>= 4.2', '< 5.2']
end

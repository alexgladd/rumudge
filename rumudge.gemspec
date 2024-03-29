# gem specification for rumudge
Gem::Specification.new do |s|
  s.name        = 'rumudge'
  s.version     = '0.0.0'
  s.date        = '2014-12-02'
  s.summary     = 'A Ruby MUD game engine'
  s.description = 'A framework for building a MUD with Ruby'
  s.authors     = ['Alex Gladd']
  s.email       = 'rumudge@alexgladd.com'
  s.homepage    = 'https://github.com/alexgladd/rumudge'
  s.license     = 'LGPL-3.0+'
  s.files       = Dir['lib/**/*.rb']

  s.add_development_dependency 'rspec', '3.1.0'

  s.add_runtime_dependency     'sqlite3', '1.3.10'
end

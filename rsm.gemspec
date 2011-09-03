# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rsm/version"

Gem::Specification.new do |s|
  s.name = 'rsm'
  s.summary = 'Rails server manager'
  s.description = 'Thor tasks for rapid deployment new rails apps on server'
  s.homepage = 'https://github.com/asux/rsm'
  s.email = 'a.ulyanitsky@gmail.com'
  s.author = 'Oleksandr Ulianytskyi'
  s.license = 'BSD'
  s.version = Rsm::VERSION
  s.date = File.mtime(File.expand_path('VERSION',  File.dirname(__FILE__)))
  s.extra_rdoc_files = ['README.md', 'CHANGES.md', 'VERSION']
  s.rdoc_options << '--main' << 'README.md' << '--line-numbers'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.default_executable = 'rsm'

  s.requirements << 'A coreutils installed'
  s.requirements << 'A Git installed'
  s.requirements << 'A Nginx installed'
  s.add_dependency 'thor', '~> 0.14.6'
end
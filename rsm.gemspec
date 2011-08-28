Gem::Specification.new do |s|
  s.name = 'rsm'
  s.summary = 'Rails server manager'
  s.description = 'Thor tasks for rapid deployment new rails apps on server'
  s.homepage = 'https://github.com/asux/rsm'
  s.email = 'a.ulyanitsky@gmail.com'
  s.author = 'Oleksandr Ulianytskyi'
  s.version = File.read('VERSION')
  s.files = `git ls-files`.split("\n")
  s.date = File.mtime('VERSION')
  s.executables = Dir['bin/*'].map{|f| File.basename(f)}
  s.default_executable = 'rsm'
  s.extra_rdoc_files = ['README.md', 'CHANGES.md']
  s.license = 'MIT'
  s.rdoc_options << '--main' << 'README.md' << '--line-numbers'
  s.requirements << 'A coreutils installed'
  s.requirements << 'A Git installed'
  s.requirements << 'A Nginx installed'
  s.requirements << 'You must have super-user access'
  s.add_dependency 'thor'
end
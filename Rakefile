require 'rake'
 
require 'rake/gempackagetask'         # Create a gem specification 
gem_spec = Gem::Specification.new do |s| 
  s.name = "fretboard"
  s.summary = "Program for learning the guitar fretboard"
  s.email = "mark.dewandel@gmail.com"
  s.homepage = "http://msd.github.com"
  s.extra_rdoc_files = FileList["README", "COPYING"]
  s.authors = ["Mark DeWandel"]
  s.files = FileList['lib/fretboard.rb', 'bin/fb', 'Rakefile',
    'README', 'COPYING', 'doc/**/*']
  s.executables = ['fb'] 
  s.email = "mark.dewandel@gmail.com"
  s.homepage = "http://msd.github.com"
  s.has_rdoc = true
  #s.test_files = FileList['tests/**/*'] 
  s.version = '0.0.6' 
  s.add_dependency("term-ansicolor")
end 

Rake::GemPackageTask.new(gem_spec) do |pkg| 
  pkg.need_zip = false 
  pkg.need_tar = false 
end 

require 'rake/testtask' 
desc "Run basic tests"
Rake::TestTask.new('test') do |t| 
  t.pattern = 'test/**/test_*.rb' 
  t.warning = true 
end 

require 'rake/rdoctask'
desc "Build RDOC documentation"
Rake::RDocTask.new('rdoc') do |t| 
  t.rdoc_dir = 'doc'
  t.rdoc_files.include('README', 'lib/**/*.rb') 
  t.main = 'README' 
  t.title = "PlayingCards API documentation" 
end 

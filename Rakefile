require 'rake'
 
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "fretboard"
    gem.summary = "Program for learning the guitar fretboard"
    gem.email = "mark.dewandel@gmail.com"
    gem.homepage = "http://msd.github.com"
    # gem.extra_rdoc_files = FileList["README", "COPYING"]
    gem.authors = ["Mark DeWandel"]
    gem.files = FileList['lib/fretboard.rb', 'bin/fb', 'Rakefile',
      'README', 'COPYING', 'doc/**/*']
    gem.executables = ['fb'] 
    gem.email = "mark.dewandel@gmail.com"
    gem.homepage = "http://msd.github.com"
    gem.has_rdoc = true
    # gem.test_files = FileList['tests/**/*'] 
    # gem.version = '0.0.7' 
    #gem.add_dependency("term-ansicolor")
  end
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available."
  puts "Install it with: sudo gem install technicalpickles-jeweler"
  puts "    -s http://gems.github.com"
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

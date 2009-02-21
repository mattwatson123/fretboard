Gem::Specification.new do |spec|
  spec.name = "fretboard"
  spec.summary = "Program for learning the guitar fretboard"
  spec.version = '0.0.5'
  spec.author = "Mark DeWandel"
  spec.executables = "fb"
  spec.email = "mark.dewandel@gmail.com"
  spec.files = ["COPYING", "bin/fb", "lib/fretboard.rb"]
  spec.has_rdoc = false
  spec.add_dependency("term-ansicolor")
end

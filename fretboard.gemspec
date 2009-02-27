# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fretboard}
  s.version = "0.0.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark DeWandel"]
  s.date = %q{2009-02-27}
  s.default_executable = %q{fb}
  s.email = %q{mark.dewandel@gmail.com}
  s.executables = ["fb"]
  s.files = ["lib/fretboard.rb", "bin/fb", "Rakefile", "README", "COPYING", "doc/files", "doc/files/README.html", "doc/files/lib", "doc/files/lib/fretboard_rb.html", "doc/files/lib/fretboard_rb.src", "doc/files/lib/fretboard_rb.src/M000001.html", "doc/files/lib/fretboard_rb.src/M000002.html", "doc/files/lib/fretboard_rb.src/M000003.html", "doc/fr_class_index.html", "doc/rdoc-style.css", "doc/classes", "doc/classes/Fretboard.html", "doc/classes/Fretboard.src", "doc/classes/Fretboard.src/M000004.html", "doc/classes/Fretboard.src/M000010.html", "doc/classes/Fretboard.src/M000008.html", "doc/classes/Fretboard.src/M000005.html", "doc/classes/Fretboard.src/M000006.html", "doc/classes/Fretboard.src/M000007.html", "doc/fr_method_index.html", "doc/created.rid", "doc/fr_file_index.html", "doc/index.html"]
  s.has_rdoc = true
  s.homepage = %q{http://msd.github.com}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Program for learning the guitar fretboard}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<term-ansicolor>, [">= 0"])
    else
      s.add_dependency(%q<term-ansicolor>, [">= 0"])
    end
  else
    s.add_dependency(%q<term-ansicolor>, [">= 0"])
  end
end

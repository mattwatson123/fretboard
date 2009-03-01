# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fretboard}
  s.version = "0.0.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark DeWandel"]
  s.date = %q{2009-03-01}
  s.default_executable = %q{fb}
  s.email = %q{mark.dewandel@gmail.com}
  s.executables = ["fb"]
  s.files = ["lib/fretboard.rb", "bin/fb", "Rakefile", "README", "COPYING"]
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
    else
    end
  else
  end
end

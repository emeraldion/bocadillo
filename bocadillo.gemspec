Gem::Specification.new do |s|
  s.name                      = "bocadillo"
  s.version                   = "1.0.1"
  s.date                      = %q{2017-01-18}
  s.license                   = "MIT"

  s.summary                   = %q{Compacts a list of strings}
  s.description               = %q{Converts a list of strings into a compact, readable representation with delimiters of choice}
  s.authors                   = ["Claudio Procida"]
  s.email                     = %q{claudio.procida@gmail.com}
  s.homepage                  = %q{http://rubygems.org/gems/bocadillo}

  s.files                     = ["Rakefile", "lib/bocadillo.rb", "lib/bocadillo/args.rb", "lib/bocadillo/cover.rb",
                                  "lib/bocadillo/parser.rb", "lib/bocadillo/serializer.rb", "lib/bocadillo/usage.rb",
                                  "bin/bocadillo", "README.md", "LICENSE.md"]
  s.require_paths             = ["lib"]
  s.test_files                = ["test/test_bocadillo.rb"]
  s.executables               << "bocadillo"

  s.rubygems_version          = %q{2.6.8}
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

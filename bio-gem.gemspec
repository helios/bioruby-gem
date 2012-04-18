# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "bio-gem"
  s.version = "1.3.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Raoul J.P. Bonnal", "Pjotr Prins"]
  s.date = "2012-04-18"
  s.description = "Biogem is a software generator for those bioinformaticans who want to start coding an application or a library for using/extending BioRuby core library and sharing it through rubygems.org .\n  The basic idea is to simplify and promote a modular approach to bioinformatics software development"
  s.email = "ilpuccio.febo@gmail.com"
  s.executables = ["biogem"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc",
    "Tutorial.rdoc"
  ]
  s.files = [
    ".document",
    ".travis.yml",
    ".yardopts",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "Tutorial.rdoc",
    "VERSION",
    "bin/biogem",
    "bio-gem.gemspec",
    "doc/biogem-hacking.md",
    "doc/integration-testing.md",
    "lib/bio-gem.rb",
    "lib/bio-gem/application.rb",
    "lib/bio-gem/generator/render.rb",
    "lib/bio-gem/mod/biogem-rails.rb",
    "lib/bio-gem/mod/biogem.rb",
    "lib/bio-gem/mod/jeweler.rb",
    "lib/bio-gem/mod/jeweler/github_mixin.rb",
    "lib/bio-gem/mod/jeweler/options.rb",
    "lib/bio-gem/templates/README.md",
    "lib/bio-gem/templates/README.rdoc",
    "lib/bio-gem/templates/bin/bio-plugin",
    "lib/bio-gem/templates/database",
    "lib/bio-gem/templates/db_connection",
    "lib/bio-gem/templates/db_model",
    "lib/bio-gem/templates/engine",
    "lib/bio-gem/templates/ffi/ext.c",
    "lib/bio-gem/templates/ffi/ext.h",
    "lib/bio-gem/templates/foos_controller",
    "lib/bio-gem/templates/foos_view_example",
    "lib/bio-gem/templates/foos_view_index",
    "lib/bio-gem/templates/foos_view_new",
    "lib/bio-gem/templates/foos_view_show",
    "lib/bio-gem/templates/gitignore",
    "lib/bio-gem/templates/lib/bioruby-plugin.rb",
    "lib/bio-gem/templates/lib/plugin.rb",
    "lib/bio-gem/templates/library",
    "lib/bio-gem/templates/migration",
    "lib/bio-gem/templates/rakefile",
    "lib/bio-gem/templates/routes",
    "lib/bio-gem/templates/seeds",
    "lib/bio-gem/templates/travis.yml",
    "test/helper.rb",
    "test/test_bio-gem.rb"
  ]
  s.homepage = "http://github.com/helios/bioruby-gem"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README", "--line-numbers"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("~> 1.9")
  s.rubygems_version = "1.8.10"
  s.summary = "Biogem is a software generator for Ruby in bioinformatics"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bundler>, [">= 1.0.21"])
      s.add_runtime_dependency(%q<jeweler>, [">= 0"])
      s.add_runtime_dependency(%q<rdoc>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, [">= 1.0.21"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, [">= 1.0.21"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
  end
end


# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "csv_import"
  s.summary = "CSV import tool for mapping CSV columnsto database fields."
  s.description = "Coming soon..."
  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.md"]
  s.version = "0.0.2"
end
$gemspec = Gem::Specification.new do |s|
  s.name     = 'rubycas-server'
  s.version  = '1.1.3.pre'
  s.authors  = ["Matt Zukowski"]
  s.email    = ["matt@zukowski.ca"]
  s.homepage = 'https://github.com/rubycas/rubycas-server'
  s.platform = Gem::Platform::RUBY
  s.summary  = %q{Provides single sign-on authentication for web applications using the CAS protocol.}
  s.description  = %q{Provides single sign-on authentication for web applications using the CAS protocol.}

  s.files  = [
    "CHANGELOG", "LICENSE", "README.md", "Rakefile",
    "bin/*", "db/**/*", "lib/**/*.rb", "public/**/*", "locales/**/*", "resources/*.*",
    "config.ru", "config/**/*", "tasks/**/*.rake", "lib/**/*.erb", "lib/**/*.builder",
    "Gemfile", "rubycas-server.gemspec"
  ].map{|p| Dir[p]}.flatten

  s.test_files = `git ls-files -- spec`.split("\n")

  s.executables = ["rubycas-server"]
  s.bindir = "bin"
  s.require_path = "lib"

  s.extra_rdoc_files = ["CHANGELOG", "LICENSE", "README.md"]

  s.has_rdoc = true
  s.post_install_message = "For more information on RubyCAS-Server, see http://rubycas.github.com"

  s.add_dependency("pg", "0.17.1")
  s.add_dependency("activerecord", ">= 2.3.12", "<= 6.0")
  s.add_dependency("activesupport", ">= 2.3.12", "<= 6.0")
  s.add_dependency("sinatra", "~> 1.0")
  s.add_dependency("sinatra-r18n", '~> 1.1.0')
  s.add_dependency("crypt-isaac", "~> 0.9.1")

  s.add_development_dependency("rack-test",'0.6.3')
  s.add_development_dependency("capybara", '1.1.2')
  s.add_development_dependency("rspec")
  s.add_development_dependency("rspec-core")
  s.add_development_dependency("rake", "0.8.7")
  s.add_development_dependency("sqlite3", "~> 1.3.1")
  s.add_development_dependency("appraisal", "~> 0.4.1")
  s.add_development_dependency("guard", "~> 1.4.0")
  s.add_development_dependency("guard-rspec", "2.0.0")
  s.add_development_dependency("public_suffix", "1.4.3") # Staging and prod run Ruby 1.9.3. This is the last version supported for that version of ruby, so pin it.
  #s.add_development_dependency("public_suffix", "3.1.1") # If we upgrade to Ruby 2.1, use this version. This is a dependency of webmock below (through addressable). Newer versions require Ruby 2.3 or higher.
  s.add_development_dependency("webmock", "~> 1.8")
  s.add_development_dependency("nokogiri", "1.6.3.1")

  # pull in os specific FS monitoring lib for guard
  case RUBY_PLATFORM
  when /darwin/i
    s.add_development_dependency("rb-fsevent", "~> 0.9.2")
  when /linux/i
    s.add_development_dependency("rb-inotify", "~> 0.8.8")
  when /mswin|bccwin|wince/i
    s.add_development_dependency('wdm', '~> 0.0.3') if RUBY_VERSION >= '1.9.2'
    s.add_development_dependency('win32console', "~> 1.3.2")
  end

  s.rdoc_options = [
    '--quiet', '--title', 'RubyCAS-Server Documentation', '--opname',
    'index.html', '--line-numbers', '--main', 'README.md', '--inline-source'
  ]
end

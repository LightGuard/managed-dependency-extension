begin
  require_relative 'lib/quarkus/managed-dependency/version'
rescue LoadError
  require 'quarkus/managed-dependency/version'
end

Gem::Specification.new do |s|
  s.name = 'quarkus-managed-dependency'
  s.version = Quarkus::ManagedDependency::VERSION
  s.summary = ''
  s.description = ''
  s.authors = ['Jason Porter', 'George Gastaldi']
  s.email = 'lightguard.jp@gmail.com'
  s.homepage = 'https://quarkus.io'
  s.license = 'MIT'
  # NOTE required ruby version is informational only; it's not enforced since it can't be overridden and can cause builds to break
  #s.required_ruby_version = '>= 2.7.0'
  s.metadata = {
    'bug_tracker_uri' => 'https://github.com/lightguard/managed-dependency-extension/issues',
    'changelog_uri' => 'https://github.com/lightguard/managed-dependency-extension/blob/ruby/CHANGELOG.adoc',
    'mailing_list_uri' => 'https://github.com/quarkusio/quarkus/discussions',
    'source_code_uri' => 'https://github.com/lightguard/managed-dependency-extension/tree/ruby'
  }

  # NOTE the logic to build the list of files is designed to produce a usable package even when the git command is not available
  begin
    files = (result = `git ls-files -z`.split ?\0).empty? ? Dir['**/*'] : result
  rescue
    files = Dir['**/*']
  end
  s.files = files.grep %r/^(?:lib\/.+|LICENSE|(?:CHANGELOG|README)\.adoc|#{s.name}\.gemspec)$/
  s.require_paths = ['lib']

  s.add_runtime_dependency 'asciidoctor', '~> 2.0'
  s.add_runtime_dependency 'rexml', '~> 3.2'

  s.add_development_dependency 'rake', '~> 13.0.0'
  s.add_development_dependency 'rspec', '~> 3.11.0'
end
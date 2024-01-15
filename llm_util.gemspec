require_relative 'lib/llm_util/version'

Gem::Specification.new do |spec|
  host = 'https://github.com/mslinn/llm_util'

  spec.authors               = ['Mike Slinn']
  spec.description           = <<~END_DESC
    LlmUtil is a script front-end for large language models that are managed and run by Ollama.
  END_DESC
  spec.email                 = ['mslinn@mslinn.com']
  spec.files                 = Dir['.rubocop.yml', 'LICENSE.*', 'Rakefile', '{lib,spec}/**/*', '*.gemspec', '*.md']
  spec.homepage              = 'https://github.com/mslinn/llm_util'
  spec.license               = 'MIT'
  spec.metadata = {
    'allowed_push_host' => 'https://rubygems.org',
    'bug_tracker_uri'   => "#{host}/issues",
    'changelog_uri'     => "#{host}/CHANGELOG.md",
    'homepage_uri'      => spec.homepage,
    'source_code_uri'   => host,
  }
  spec.name                 = 'llm_util'
  spec.post_install_message = <<~END_MESSAGE

    Thanks for installing #{spec.name}!

  END_MESSAGE
  spec.require_paths         = ['lib']
  spec.required_ruby_version = '>= 3.0.0'
  spec.summary               = 'LlmUtil is a script front-end for large language models that are managed and run by Ollama.'
  spec.version               = LlmUtil::VERSION

  spec.add_dependency 'ollama-ai'
end
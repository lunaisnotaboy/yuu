# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 3.0'

gem 'bcrypt', '~> 3.1', '>= 3.1.18'
gem 'bootsnap', '~> 1.14', require: false
gem 'dalli', '~> 3.2', '>= 3.2.3'
gem 'dotenv-rails', '~> 2.8', '>= 2.8.1'
gem 'hiredis', '~> 0.6.3'
gem 'image_processing', '~> 1.12', '>= 1.12.2'
gem 'inertia_rails', '~> 3.0'
gem 'oj', '~> 3.13', '>= 3.13.23'
gem 'pg', '~> 1.4', '>= 1.4.5'
gem 'puma', '~> 6.0'
gem 'rails', '~> 7.0', '>= 7.0.4'
gem 'redis', '~> 5.0', '>= 5.0.5'
gem 'scenic', '~> 1.6'
gem 'shrine', '~> 3.4'
gem 'sidekiq', '~> 7.0', '>= 7.0.1'
gem 'vite_rails', '~> 3.0', '>= 3.0.13'

group :development, :test do
  gem 'debug', '~> 1.6', '>= 1.6.3', platforms: %i[mri mingw x64_mingw]
  gem 'rspec_junit_formatter', '~> 0.6.0'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.1'
  gem 'rubocop', '~> 1.39', require: false
  gem 'rubocop-performance', '~> 1.15', '>= 1.15.1', require: false
  gem 'rubocop-rails', '~> 2.17', '>= 2.17.3', require: false
  gem 'rubocop-rspec', '~> 2.15', require: false
  gem 'solargraph', '~> 0.47.2', require: false
end

group :development do
  gem 'annotate', '~> 3.2'
  gem 'better_errors', '~> 2.9', '>= 2.9.1'
  gem 'binding_of_caller', '~> 1.0'
  gem 'brakeman', '~> 5.4'
  gem 'letter_opener', '~> 1.8', '>= 1.8.1'
  gem 'letter_opener_web', '~> 2.0'
end

group :production do
  gem 'lograge', '~> 0.12.0'
end

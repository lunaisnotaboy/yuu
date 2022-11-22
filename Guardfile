require 'active_support/inflector'

guard :rspec, cmd: 'bin/rspec -f doc' do
  # `spec/*_helper.rb` -> all specs
  watch(%r[spec/.*_helper.rb]) { 'spec' }

  # `spec/support/*.rb` -> all specs
  watch(%r[spec/support/.*.rb]) { 'spec' }

  # `app/**/(application|base)_*.rb` -> all relevant spec groups
  watch('app/controllers/application_controller.rb') { 'spec/controllers' }
  watch('app/policies/application_policy.rb') { 'spec/policies' }
  watch('app/resources/base_resource.rb') { 'spec/controllers' }

  # `spec/**/*` -> itself
  watch(%r[^spec/.+_spec\.rb$])

  # `app/**/*` -> corresponding spec
  watch(%r[^app/(.+)\.rb$]) { |m| "spec/#{m[1]}_spec.rb" }
end

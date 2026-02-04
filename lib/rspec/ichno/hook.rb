# frozen_string_literal: true

require 'rspec'

def RSpec.ichno
  @ichno ||= RspecIchno.new
end

RSpec.configuration.before(:suite) do |config|
  RSpec.ichno.disable = !(['1', 'true'].include?(ENV['ICHNO']))
  RSpec.ichno.check_global?
end

RSpec.configuration.around(:each) do |example|
  RSpec.ichno.spec(example) do |ichno_spec|
    if ichno_spec.skip? && example.metadata[:ichno] != false
      example.execution_result.pending_fixed = true
      example.execution_result.pending_message = 'skipped by rspec-ichno'
      example.skip
      next
    end

    example.run
  end
end

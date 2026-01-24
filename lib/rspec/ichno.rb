# frozen_string_literal: true

require_relative "ichno/version"
require_relative "ichno/example"
require_relative "ichno/hook"
require "json"

class RspecIchno
  class Error < StandardError; end

  def initialize
    @disable = false
    @json = JSON.parse(File.read('ichno.cache.json'))
  end
  attr_accessor :disable

  def spec(example)
    if @disable
      example.run
    else
      example = Example.new(example, cache: @json)
      yield example
    end
  end
end

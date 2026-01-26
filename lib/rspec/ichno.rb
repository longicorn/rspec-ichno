# frozen_string_literal: true

require_relative "ichno/version"
require_relative "ichno/example"
require_relative "ichno/hook"
require "json"

class RspecIchno
  class Error < StandardError; end

  def initialize
    @disable = false
    ichno_dir = ENV['ICHNO_DIR'] || 'tmp/cache/ichno/'
    json_path = Rails.root.join("#{ichno_dir}/manifest.json")
    @cache = JSON.parse(File.read(json_path)) if File.exist?(json_path)
    @disable = !(@cache['version'] != RUBY_VERSION)
  end
  attr_accessor :disable

  def spec(example)
    if @disable
      example.run
    else
      example = Example.new(example, cache: @cache)
      yield example
    end
  end
end

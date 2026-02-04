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
  end
  attr_accessor :disable

  def check_global?
    return true if @disable

    @disable = (@cache['version'] != RUBY_VERSION)
    return true if @disable

    @cache['global'].each do |path, data|
      if data['md5'] != Digest::MD5.file(path).hexdigest
        @disable = true
        return true
      end
    end
    return false
  end

  def spec(example)
    if @disable
      example.run
    else
      example = Example.new(example, cache: @cache)
      yield example
    end
  end
end

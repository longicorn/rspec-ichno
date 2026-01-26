# frozen_string_literal: true

require 'digest/md5'

class RspecIchno
  class Example
    @@md5s = {}

    def initialize(example, cache:)
      @example = example
      @cache = cache
    end
    attr_reader :cache

    def skip?
      path = @example.metadata[:absolute_file_path]
      cache = @cache[path]
      return false unless cache

      return false if cache['failed']
      cache['data'].each do |data|
        cache_path = data['path']
        @@md5s[cache_path] ||= Digest::MD5.file(cache_path).hexdigest
        return false if data['md5'] != @@md5s[cache_path]
      end
      true
    rescue
      false
    end
  end
end

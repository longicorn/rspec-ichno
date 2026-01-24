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
      return false unless @cache[path]

      @cache[path].each do |cache|
        cache_path = cache['path']
        @@md5s[cache_path] ||= Digest::MD5.file(cache_path).hexdigest
        return false if cache['md5'] != @@md5s[cache_path]
      end
      true
    end
  end
end

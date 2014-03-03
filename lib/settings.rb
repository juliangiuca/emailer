require 'json'
require 'active_support/core_ext/hash/indifferent_access'

module Settings
  extend self

  def config
    @config ||= begin
      file = open("config/settings.json")
      json = file.read
      JSON.parse(json)
    end
  end

  def inspect
    json_obj.inspect
  end

  def method_missing(name, *args)
    json_obj.public_send(name)
  end

  private

  def json_obj
    @json_obj ||= JsonObj.new(config)
  end

  class JsonObj < Hash

    def initialize(json_hash)
      @json = {}
      defaults = {}
      json_hash.each_pair do |key, value|
        defaults = value if key == "defaults"
        @json[key] = value.is_a?(Hash) ? JsonObj.new(defaults.merge(value)) : value

        define_singleton_method(key) do
          @json[key]
        end
      end
    end

    def [](key)
      @json[key].is_a?(Hash) ? @json[key].to_hash : @json[key]
    end

    def inspect
      @json
    end

    def to_hash
      @json.with_indifferent_access
    end

    def keys
      @json.keys
    end

    def fetch(key)
      self[key]
    end

    def values_at(*args)
      args.map  do |arg|
        self[arg]
      end
    end
  end
end

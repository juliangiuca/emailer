require 'json'

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

  class JsonObj
    def initialize(json_hash)

      @json = {}
      json_hash.each_pair do |key, value|
        @json[key] = value.is_a?(Hash) ? JsonObj.new(value) : value

        define_singleton_method(key) do
          @json[key]
        end
      end
    end

    def [](key)
      @json[key]
    end

    def inspect
      @json
    end

    def to_hash
      @json
    end

    def keys
      @json.keys
    end

  end
end

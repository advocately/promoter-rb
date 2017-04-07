require 'net/https'
require 'uri'
require 'cgi'
require 'multi_json'
require 'set'
require 'thread'

require 'promoter/version'
require 'promoter/utils'
require 'promoter/json'

require 'promoter/enumerable_resource_collection'
require 'promoter/resource'
require 'promoter/operations/all'
require 'promoter/operations/retrieve'
require 'promoter/resources/feedback'
require 'promoter/resources/contact'
require 'promoter/resources/metric'

require 'promoter/errors'
require 'promoter/http_response'
require 'promoter/http_adapter'
require 'promoter/client'

module Promoter
  @mutex = Mutex.new

  class << self
    attr_accessor :api_key, :api_base_url, :http_adapter
    attr_writer :shared_client

    def shared_client
      @mutex.synchronize do
        @shared_client ||= Client.new(api_key: api_key, api_base_url: api_base_url, http_adapter: http_adapter)
      end
    end
  end
end

module Promoter
  class Client
    DEFAULT_API_BASE_URL = "https://app.promoter.io/api"
    DEFAULT_HTTP_ADAPTER = HTTPAdapter.new

    def initialize(opts = {})
      @api_key = opts[:api_key] or raise ArgumentError, "You must provide an API key by setting Promoter.api_key = '123abc' or passing { :api_key => '123abc' } when instantiating Promoter::Client.new"
      @api_base_url = opts[:api_base_url] || DEFAULT_API_BASE_URL
      @http_adapter = opts[:http_adapter] || DEFAULT_HTTP_ADAPTER
    end

    def get_json(path, params = {})
      perform_request(:get, path, params)
    end

  private

    def perform_request(method, path, params)
      uri = prepare_uri(path)
      headers = default_headers

      if method == :get
        uri.query = Utils.to_query(params) unless params.empty?
        response = @http_adapter.request(method, uri, headers)
      else
        data = prepare_data(params)
        headers['Content-Type'] = 'application/json'
        response = @http_adapter.request(method, uri, headers, data)
      end

      handle_json_response(response)
    end

    def prepare_uri(path)
      URI.parse(File.join(@api_base_url, path))
    end

    def prepare_data(params)
      JSON.dump(params) unless params.empty?
    end

    def handle_json_response(response)
      case response.status_code
      when 200, 201, 202
        Utils.symbolize_keys(JSON.load(response.body))
      when 401
        raise AuthenticationError, response
      when 406
        raise UnsupportedFormatRequestedError, response
      when 422
        raise ResourceValidationError, response
      when 503
        raise ServiceUnavailableError, response
      else
        raise GeneralAPIError, response
      end
    end

    def default_headers
      @default_headers ||= {
        'Authorization' => "Token #{@api_key}",
        'User-Agent' => "Promoter RubyGem #{Promoter::VERSION}",
        'Content-Type' => 'application/json'
      }.freeze
    end
  end
end

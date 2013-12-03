module OAuth2
  class UntappdClient < OAuth2::Client
    def get_token(params, access_token_opts = {}, access_token_class = AccessToken)
      response = request(options[:token_method], token_url, request_token_opts(params))
      access_token_class.new(self, parse_token(response), access_token_opts)
    end

    private

    def parse_token(response)
      access_token = response.parsed.is_a?(Hash) && response.parsed['response']['access_token']
      raise Error.new(response) if options[:raise_errors] && !access_token
      access_token
    end

    def request_token_opts(params)
      { raise_errors: options[:raise_errors],
        parse: params.delete(:parse),
        params: params }
    end
  end
end

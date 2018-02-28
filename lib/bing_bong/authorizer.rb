require 'uri'
require 'net/http'
require 'openssl'
require 'cgi'
require 'json'

module BingBong
  class Authorizer

    AUTH_ENDPOINT = "https://login.live.com/oauth20_authorize.srf?client_id=%s&scope=bingads.manage&response_type=code&redirect_uri=%s"

    attr_accessor :client_id, :load_token, :save_token

    def initialize(client_id)
      self.client_id = client_id
      self.load_token = nil
      self.save_token = nil
      yield self if block_given?
    end

    def auth_url
      AUTH_ENDPOINT % [client_id, redirect_uri]
    end

    def current_token
      load_from_storage
    end

    def clear_token!
      save_to_storage({})
    end

    def access_token
      if !current_token
        promt_user_for_code
      elsif current_token.expired?
        regenerate_token
      end
      current_token['access_token']
    end

    protected

    def parse_code(value)
      if value =~ URI::regexp
        uri = URI(value)
        Hash[URI.decode_www_form(uri.query)]['code']
      else
        value
      end
    end

    def load_from_storage
      hash = load_token.call
      if hash && !hash.empty?
        Token.new(hash)
      end
    end

    def save_to_storage(token)
      save_token.call(token)
    end

    def promt_user_for_code
      puts "Visit #{auth_url} and login. Grab the code from URL"
      input = [(print 'Code: '), gets.rstrip][1]
      code = parse_code(input)
      if payload = request_token_by_code(code)
        token = Token.new(payload)
        save_to_storage(token)
      end
    end

    def redirect_uri
      'https://login.live.com/oauth20_desktop.srf'
    end

    def regenerate_token
      if payload = request_token_by_refresh_token(current_token['refresh_token'])
        token = Token.new(payload)
        save_to_storage(token)
      end
    end

    def request_token_by_code(code)
      request(code: code, grant_type: 'authorization_code')
    end

    def request_token_by_refresh_token(refresh_token)
      request(grant_type: 'refresh_token', refresh_token: refresh_token)
    end

    def request(params = {})

      uri = URI.parse("https://login.live.com/oauth20_token.srf")
      header = { 'Content-Type' => 'application/x-www-form-urlencoded' }

      data = {
        client_id: client_id,
        redirect_uri: redirect_uri
      }.merge(params)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Post.new(uri.request_uri, header)
      request.body = URI.encode_www_form(data)

      response = http.request(request)
      JSON.parse(response.body)

    end

  end
end

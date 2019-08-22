require 'pry'
module Metrc
  module Request
    def request(method, path, user_api_key, _options)
      binding.pry
      options = default_body.merge(_options)
      options.has_key?(:license_number) ? append_endpoint = "?licenseNumber=#{options[:license_number]}" : append_endpoint = ""
      final_path = path + append_endpoint 
      metrc_request = initialize_faraday(user_api_key, options)

      case method
      when :get
        response = metrc_request.get(final_path)
      when :post
        response = metrc_request.post(final_path)
      end

      status = check_status(response) if !!(response.status)
      return JSON.parse(response.body) if status == nil
      raise Metrc::UnknownError
    end

    def initialize_faraday(user_api_key, options)
      metrc_request = Faraday.new(endpoint)
      metrc_request.basic_auth(default_body[:vendor_api_key], user_api_key)
      metrc_request
    end

    def check_status(response)
      case response.status
      when 400
        #raise Metrc::ParameterMissing, data["message"]
        binding.pry
      when 401
        raise Metrc::Unauthorized, 'Unauthorized'
      when 403
        #raise Metrc::ShowErrorMessage, data["message"]
        binding.pry
      when 404
        raise Metrc::UrlNotFound, '404- File or directory not found'
      when 429
        binding.pry
      when 200
        return nil
      else
        binding.pry
        raise Metrc::ShowErrorMessage
      end
    end

  end
end
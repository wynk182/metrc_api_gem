require 'pry'
module Metrc
  module Request
    def request(method, path, user_api_key, options)
      options.has_key?(:license_number) ? append_endpoint = "?licenseNumber=#{options[:license_number]}" : append_endpoint = ""
      options.delete(:license_number) if options.has_key?(:license_number)
      final_path = path + append_endpoint
      metrc_request = initialize_faraday(user_api_key, options)

      case method
      when :get
        response = metrc_request.get(final_path)
      when :post
        response = metrc_request.post(final_path, [options].to_json)
      end
      
      status = check_status(response) if !!(response.status)
      if status == nil
        if response.body != ''
          return JSON.parse(response.body)
        else
          return 'Ok!'
        end
      end
      raise Metrc::UnknownError
    end

    def initialize_faraday(user_api_key, options)
      options = { headers: { "Accept" => "application/json",
                             "Content-Type" => "application/json" },
                  url: endpoint }.merge(connection_options)
      metrc_request = Faraday.new(options)
      metrc_request.basic_auth(default_body[:vendor_api_key], user_api_key)
      metrc_request
    end

    def check_status(response)
      case response.status
      when 400
        raise Metrc::ParameterMissing, JSON.parse(response.body) unless response.body == ''
      when 401
        raise Metrc::Unauthorized, 'Unauthorized'
      when 403
        #raise Metrc::ShowErrorMessage, data["message"]
        p 'ERROR 403', JSON.parse(response.body) unless response.body == ''
      when 404
        raise Metrc::UrlNotFound, '404- File or directory not found'
      when 415
        raise Metrc::ShowErrorMessage, 'Unsupported Media Type' #did you forget to set json headers?
      when 429
        p 'ERROR 429', JSON.parse(response.body) unless response.body == ''
      when 200
        return nil
      else
        raise Metrc::ShowErrorMessage, JSON.parse(response.body) unless response.body == ''
      end
    end

  end
end
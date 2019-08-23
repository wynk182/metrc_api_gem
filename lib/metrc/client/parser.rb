require 'pry'
module Metrc
  class Client
    module Parser
      def symbolize_response(response_array)
        symbolized_response = {}
        symbolized_array = []
        response_array.each do |response|
          symbolized_response.merge(recursively_symbolize_keys(response, symbolized_response))
          symbolized_array << symbolized_response
        end
        symbolized_array
      end

      def recursively_symbolize_keys(response, symbolized_response)
        response.each do |key, value|
          if value.class == Hash
            value = recursively_symbolize_keys(value, symbolized_response) 
            symbolized_response.delete(key)
            key = nil
          end
          symbolized_response[key.gsub(/[A-Z]/, ' \0').downcase.split.join("_").to_sym] = value unless key == nil
        end
        symbolized_response
      end

      def save_response_to_object!(response_array, user_object)
        response_array.each do |response|
          response.each do |key, value|
            user_object[key] = value if user_object.respond_to?(key)
          end
        end
      end

      extend self
    end
  end
end
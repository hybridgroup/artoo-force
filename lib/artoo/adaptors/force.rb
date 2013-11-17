require 'artoo/adaptors/adaptor'

module Artoo
  module Adaptors
    # Connect to a force device
    # @see device documentation for more information
    class Force < Adaptor
      attr_reader :oauth, :client

      # Creates a connection with device
      # @return [Boolean]
      def connect
        require 'restforce' unless defined?(::Restforce)
        username = additional_params[:username] || ""
        password = additional_params[:password] || ""
        security_token = additional_params[:security_token] || ""
        client_id = additional_params[:client_id] || ""
        client_secret = additional_params[:client_secret] || ""
        instance_url = additional_params[:instance_url] || ""

        @client = Restforce.new(
          username: username,
          password: password,
          security_token: security_token,
          client_id: client_id,
          client_secret: client_secret,
          instance_url: instance_url
        )

        @oauth = @client.authenticate!
        super
      end

      # Closes connection with device
      # @return [Boolean]
      def disconnect
        super
      end

      # Name of device
      # @return [String]
      def name
        "force"
      end

      # Version of device
      # @return [String]
      def version
        Artoo::Force::VERSION
      end
      
      # Uses method missing to call device actions
      # @see device documentation
      def method_missing(method_name, *arguments, &block)
        client.send(method_name, *arguments, &block)
      end
    end
  end
end

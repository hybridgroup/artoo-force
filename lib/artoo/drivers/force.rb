require 'artoo/drivers/driver'

module Artoo
  module Drivers
    # The force driver behaviors
    class Force < Driver

      attr_reader :query_results, :query

      # Start driver and any required connections
      def start_driver
        begin
          every(interval) do
            query_force
          end

          super
        rescue Exception => e
          Logger.error "Error starting Force driver!"
          Logger.error e.message
          Logger.error e.backtrace.inspect
        end
      end

      def query= query
        @query = query
      end

      def query_force
        @query_results = connection.client.query(query)
        publish(event_topic_name("query_results"), @query_results)
      end
    end
  end
end

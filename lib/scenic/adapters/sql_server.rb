module Scenic
  module Adapters
    
    class SqlServer
      def initialize(connectable = ActiveRecord::Base)
        @connectable = connectable
      end
    
      def views
         Views.new(connection).all
      end
    
      private
      
      attr_reader :connectable
      
      def connection
        connectable.connection
      end
    end
    
  end
end
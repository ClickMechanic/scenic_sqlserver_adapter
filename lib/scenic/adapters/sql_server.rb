module Scenic
  module Adapters
    
    class SqlServer
      def initialize(connectable = ActiveRecord::Base)
        @connectable = connectable
      end
    
      def views
         Views.new(connection).all
      end
      
      def create_view(name, sql_definition)
        execute "CREATE VIEW #{quote_table_name(name)} AS #{sql_definition};"
      end

      def update_view(name, sql)
        drop_view name
        create_view name, sql
      end

      def drop_view(name)
        execute "DROP VIEW IF EXISTS #{quote_table_name(name)};"
      end
      
      private
      
      attr_reader :connectable
      delegate :execute, :quote_table_name, to: :connection
      
      def connection
        connectable.connection
      end
    end
    
  end
end
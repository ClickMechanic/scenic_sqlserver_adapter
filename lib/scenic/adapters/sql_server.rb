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
        execute "IF OBJECT_ID('#{quote_table_name(name)}') IS NOT NULL DROP VIEW #{quote_table_name(name)};"
      end
      
      class NotSupportedError < StandardError
        def initialize
          super 'SQL Server does not support this feature'
        end
      end
      
      %i[
        replace_view
        create_materialized_view
        refresh_materialized_view
        update_materialized_view
        drop_materialized_view
      ].each do |operation|
        define_method(operation) do |*args|
          raise NotSupportedError
        end
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
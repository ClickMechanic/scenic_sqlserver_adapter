module Scenic
  module Adapters
    class SqlServer
      
      class Views
        def initialize(connection)
          @connection = connection
        end

        def all
          views_from_sql_server.map(&method(:to_scenic_view))
        end

        private

        attr_reader :connection

        def views_from_sql_server
          connection.exec_query(<<~SQL)
            SELECT v.name, sm.definition
            FROM sys.views v
              INNER JOIN sys.sql_modules sm ON v.object_id = sm.object_id
          SQL
        end

        def to_scenic_view(result)
          Scenic::View.new(
            name: result['name'],
            definition: extract_definition(result),
            materialized: false,
          )
        end

        def extract_definition(result)
          result['definition'].strip.sub(/\A.*#{result['name']}\W*AS\s*/, '')
        end
      end
      
    end
  end
end

module Scenic
  module Adapters
    
    RSpec.describe SqlServer::Views do
      let(:connection) { double(:connection) }
      let(:views) { [
        {
          'name' => 'view_to_a_kill',
          'definition' => 'SELECT phoenix FROM the_flame'
        }
        ] }
      
      let(:views_sql) { <<~SQL
          SELECT v.name, sm.definition
          FROM sys.views v
            INNER JOIN sys.sql_modules sm ON v.object_id = sm.object_id
        SQL
      }
      
      subject { SqlServer::Views.new(connection) }
      
      before do 
        allow(connection).to receive(:exec_query).with(views_sql).and_return(views)
      end
      
      describe 'all' do
        it 'returns the database views as array of Scenic::View' do
          expect(subject.all).to eq [
            Scenic::View.new(
              name: 'view_to_a_kill',
              definition: 'SELECT phoenix FROM the_flame',
              materialized: false
            )
          ]
        end
      end
    end
    
  end
end
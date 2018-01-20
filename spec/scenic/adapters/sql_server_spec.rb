require 'spec_helper'

module Scenic
  module Adapters
    
    RSpec.describe SqlServer do
      let(:connection) { double :connection }
      let(:connectable) { double :connectable, connection: connection }
      
      subject { SqlServer.new(connectable) }
      
      context 'with no connectable specified' do
        subject { SqlServer.new }
        
        it 'defaults connectiable to ActiveRecord::Base' do
          expect(subject.send(:connectable)).to be ActiveRecord::Base
        end
      end
      
      describe 'views' do
        it 'returns all from an instance of SqlServer::Views with the connection' do
          all = double :all
          views = double :views, all: all
          allow(SqlServer::Views).to receive(:new).with(connection).and_return(views)
          expect(subject.views).to be all
        end
      end
      
      describe 'create_view' do
        before do
          allow(connection).to receive(:quote_table_name) { |name| "[#{name}]" }
        end
        
        it 'executes CREATE VIEW SQL on the connection' do
          expect(connection).to receive(:execute).with('CREATE VIEW [to_a_kill] AS SELECT phoenix FROM the_flame;')
          subject.create_view('to_a_kill', 'SELECT phoenix FROM the_flame')
        end
      end
    end
    
  end
end
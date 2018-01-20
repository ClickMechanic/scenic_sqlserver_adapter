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
      
      describe :views do
        it 'returns all from an instance of SqlServer::Views with the connection' do
          all = double :all
          views = double :views, all: all
          allow(SqlServer::Views).to receive(:new).with(connection).and_return(views)
          expect(subject.views).to be all
        end
      end
    end
    
  end
end
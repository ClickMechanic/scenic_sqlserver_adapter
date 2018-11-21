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
      
      describe 'view operations' do
        before do
          allow(connection).to receive(:quote_table_name) { |name| "[#{name}]" }
        end
        
        describe 'create_view' do  
          it 'executes CREATE VIEW SQL on the connection' do
            expect(connection).to receive(:execute).with('CREATE VIEW [to_a_kill] AS SELECT phoenix FROM the_flame;')
            subject.create_view('to_a_kill', 'SELECT phoenix FROM the_flame')
          end
        end
        
        describe 'drop_view' do  
          it 'executes DROP VIEW SQL on the connection' do
            expect(connection).to receive(:execute).with("IF OBJECT_ID('[to_a_kill]') IS NOT NULL DROP VIEW [to_a_kill];")
            subject.drop_view('to_a_kill')
          end
        end
        
        describe 'update_view' do  
          it 'drops and recreates the view' do
            allow(connection).to receive(:execute)
            expect(subject).to receive(:drop_view).with('to_a_kill')
            expect(subject).to receive(:create_view).with('to_a_kill', 'SELECT fatal_kiss FROM all_we_need')
            subject.update_view('to_a_kill', 'SELECT fatal_kiss FROM all_we_need')
          end
        end
      end
      
      describe 'unsupported operations' do
        let(:name) { 'feel_the_chill' }
        let(:sql) { 'SELECT fatal_kiss FROM all_we_need' }
        
        %i[
          replace_view
          create_materialized_view
          update_materialized_view
        ].each do |operation|
          it "does not support #{operation}" do
            expect{subject.send(operation, name, sql)}.to raise_error SqlServer::NotSupportedError
          end
        end
        
        %i[
          refresh_materialized_view
          drop_materialized_view
        ].each do |operation|
          it "does not support #{operation}" do
            expect{subject.send(operation ,name)}.to raise_error SqlServer::NotSupportedError
          end
        end
      end
    end
    
  end
end
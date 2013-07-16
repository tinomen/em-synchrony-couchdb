require 'rubygems'
require 'em-syncrony'
require "em-http"
require "json"
require "uri"

module EventMachine
  module Protocols
    class CouchDB
      def self.connect connection_params
        puts "*****Connecting" if $debug
        self.new(connection_params)
      end
      def initialize(connection_params)
        @host = connection_params[:host] || '127.0.0.1'
        @port = connection_params[:port] || 80
        @timeout = connection_params[:timeout] || 10
      end

      # DB API

      def get_all_dbs(&callback)
        EventMachine::HttpRequest.new("http://#{@host}:#{@port}/_all_dbs/").get :timeout => @timeout, :head => {"Content-Type" => "application/json"}, callback
      end

      def create_db(db_name, &callback)
        http = EventMachine::HttpRequest.new("http://#{@host}:#{@port}/#{db_name}/").put :head => {"Content-Type" => "application/json"}, callback
      end
      
      def get_db(db_name, &callback)
        http = EventMachine::HttpRequest.new("http://#{@host}:#{@port}/#{db_name}/").get :timeout => @timeout, :head => {"Content-Type" => "application/json"}, callback
      end
      
      def delete_db(db_name, &callback)
        http = EventMachine::HttpRequest.new("http://#{@host}:#{@port}/#{db_name}/").delete :head => {"Content-Type" => "application/json"}, callback
      end
      
      def compact(db_name, &callback)
        http = EventMachine::HttpRequest.new("http://#{@host}:#{@port}/#{db_name}/_compact").post :head => {"Content-Type" => "application/json"}, callback
      end

      # Document API

      def get(database, id, &callback)
        http = EventMachine::HttpRequest.new("http://#{@host}:#{@port}/#{database}/#{id}").get :timeout => @timeout, :head => {"Content-Type" => "application/json"}, callback
      end
      
      def save(database, doc, &callback)
        http = EventMachine::HttpRequest.new("http://#{@host}:#{@port}/#{database}/").post :body => JSON.dump(doc), :head => {"Content-Type" => "application/json"}, callback
      end
      
      def update(database, old_doc, new_doc, &callback)
        id, rev = get_id_and_revision(old_doc)
        new_doc["_rev"] = rev
        new_doc["_id"] = id
        http = EventMachine::HttpRequest.new("http://#{@host}:#{@port}/#{database}/#{id}").put :body => JSON.dump(new_doc), :head => {"Content-Type" => "application/json"}, callback
      end
      
      def delete(database, doc, &callback)
        doc_id, doc_revision = get_id_and_revision(doc)
        http = EventMachine::HttpRequest.new(URI.parse("http://#{@host}:#{@port}/#{database}/#{doc_id}?rev=#{doc_revision}")).delete :head => {"Content-Type" => "application/json"}, callback
      end
      
      def get_id_and_revision(doc)
        if doc.has_key? "_id"
          return doc["_id"], doc["_rev"]
        else
          return doc["id"], doc["rev"]
        end
      end
    end
  end
end
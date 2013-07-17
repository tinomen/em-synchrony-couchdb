require 'rubygems'
require 'em-http'
require 'em-synchrony'
require 'em-synchrony/em-http'
require "json"
require "uri"

module EventMachine
  module Synchrony
    class CouchDB
      def self.connect(connection_params={})
        puts "*****Connecting" if $debug
        self.new(connection_params)
      end

      def initialize(connection_params={})
        @host = connection_params[:host] || '127.0.0.1'
        @port = connection_params[:port] || 5984
        @timeout = connection_params[:timeout] || 10
      end

      # DB API

      def get_all_dbs
        get_request "/_all_dbs/", :timeout => @timeout
      end

      def create_db(db_name)
        put_request "/#{db_name}/"
      end

      def get_db(db_name)
        get_request "/#{db_name}/", :timeout => @timeout
      end

      def delete_db(db_name)
        delete_request "/#{db_name}/"
      end

      def compact(db_name)
        post_request "/#{db_name}/_compact"
      end

      # Document API

      def get(db_name, id)
        get_request "/#{db_name}/#{id}", :timeout => @timeout
      end

      def save(db_name, doc)
        post_request "/#{db_name}/", :body => JSON.dump(doc)
      end

      def update(db_name, old_doc, new_doc)
        id, rev = get_id_and_revision(old_doc)
        new_doc["_rev"] = rev
        new_doc["_id"] = id
        put_request "/#{db_name}/#{id}", :body => JSON.dump(new_doc)
      end

      def delete(db_name, doc)
        doc_id, doc_revision = get_id_and_revision(doc)
        delete_request "/#{db_name}/#{doc_id}?rev=#{doc_revision}"
      end

      def get_id_and_revision(doc)
        if doc.has_key? "_id"
          return doc["_id"], doc["_rev"]
        else
          return doc["id"], doc["rev"]
        end
      end

      private

      def get_request(path, options={})
        request :get, path, options
      end

      def post_request(path, options={})
        request :post, path, options
      end

      def put_request(path, options={})
        request :put, path, options
      end

      def delete_request(path, options={})
        request :delete, path, options
      end

      def request(type, path, options)
        uri = URI.parse("http://#{@host}:#{@port}#{path}")
        options = options.merge(:head => {"content-type" => "application/json"})
        conn = EventMachine::HttpRequest.new(uri).send type, options
        JSON.load conn.response
      end
    end
  end
end

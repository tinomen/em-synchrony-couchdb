require 'minitest/autorun'
require 'minitest/spec'
require 'em-synchrony/couchdb'

module EventMachine
  module Synchrony
    describe CouchDB do
      it 'should work' do
        EM.synchrony do
          db_name = 'em-synchrony-couchdb'
          doc = {"id" => "test", "meaning" => "42"}
          conn = CouchDB.connect

          conn.create_db db_name
          conn.get_all_dbs.must_include db_name

          #conn.save db_name, doc
          #conn.get(db_name, "test").must_equal doc

          conn.delete_db db_name
          conn.get_all_dbs.wont_include db_name
          EM.stop
        end
      end
    end
  end
end
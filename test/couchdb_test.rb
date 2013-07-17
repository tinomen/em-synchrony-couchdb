require 'minitest/autorun'
require 'minitest/spec'
require 'em-synchrony/couchdb'

module EventMachine
  module Synchrony
    describe CouchDB do
      it 'should work' do
        EM.synchrony do
          db_name = 'em-synchrony-couchdb'
          conn = CouchDB.connect

          conn.create_db db_name
          conn.get_all_dbs.must_include db_name

          id = conn.save(db_name, {'meaning' => 42})['id']
          conn.get(db_name, id)['meaning'].must_equal 42

          conn.delete_db db_name
          conn.get_all_dbs.wont_include db_name
          EM.stop
        end
      end
    end
  end
end

Gem::Specification.new do |spec|
  spec.name = 'em-synchrony-couchdb'
  spec.version = '0.0.1'
  spec.platform = Gem::Platform::RUBY
  spec.summary = 'A non-blocking client protocol for CouchDB using em-synchrony'
  spec.description = <<END_DESC
  em-synchrony-couchdb is a simple, convenient, and non-blocking client for CouchDB
  implemented using the em-synchrony version of EventMachine::HttpRequest and based
  completely on the em-couchdb gem. With em-synchrony-couchdb, you can easily save,
  query, delete documents, databases to/from a CouchDB database in your favourite
  language - Ruby.
END_DESC

  spec.requirements << 'CouchDB 0.8.0 and upwards'

  spec.add_dependency('json', '>= 1.4.3')
  spec.add_dependency('em-http-request', '>= 1.1.0')
  spec.add_dependency('em-synchrony', '>= 1.0.3')

  spec.files       = `git ls-files -- lib/*`.split("\n")
  spec.test_files  = `git ls-files -- test/*`.split("\n")

  spec.author = 'tinomen (Jake Mallory)'
  spec.email = 'tinomen@gmail.com'
  spec.homepage = 'http://github.com/tinomen/em-synchrony-couchdb'
end
Gem::Specification.new do |spec|
  spec.name = PACKAGE_NAME.downcase
  spec.version = PACKAGE_VERSION
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
  spec.add_dependency('em-synchrony', '>= 1.0.3')
  
  spec.files = FileList.new do |fl|
    fl.include 'lib/**/*.rb'
    #fl.include 'test/**/*.rb'
    fl.include 'README.md'
  end
  spec.test_files = FileList.new do |fl|
    fl.include 'test/**/*_test.rb'
  end

  spec.author = 'tinomen (Jake Mallory)'
  spec.email = 'tinomen@gmail.com'
  spec.homepage = 'http://github.com/tinomen/em-synchrony-couchdb'
end
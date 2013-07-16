module EmSynchronyCouchDB
  VERSION = '0.1.0'

  LIBPATH = ::File.expand_path(::File.dirname(__FILE__)) + ::File::SEPARATOR
  PATH = ::File.dirname(LIBPATH) + ::File::SEPARATOR

  def self.version
    VERSION
  end

  def self.libpath( *args )
    args.empty? ? LIBPATH : ::File.join(LIBPATH, args.flatten)
  end

  def self.path( *args )
    args.empty? ? PATH : ::File.join(PATH, args.flatten)
  end
end
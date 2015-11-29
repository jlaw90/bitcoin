class RPCObject
  attr_reader :source

  def initialize(source)
    @source = source;
  end
end

class RPCResponse < RPCObject
  attr_reader :data

  def initialize(rpc, hash)
    super(rpc)
    @data = hash
  end

  def method_missing(name, *args)
    key = "#{name}"
    return @data[key] if @data.include?(key)
    super.method_missing(name, args)
  end

  def [](key)
    return key.is_a?(Symbol) ? @data[key.to_s]: @data[key]
  end

  def to_s
    @data.to_s
  end
end
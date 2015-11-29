require_relative 'bitcoinrpc'
require_relative 'address'

class Account < RPCObject
  def initialize(source, name)
    super(source)
    @name = name
  end

  def balance
    @source.getreceivedbyaccount(@name).to_f
  end

  def address
    Address.new(@source, @source.getaccountaddress(@name))
  end

  def new_address
    Address.new(@source, @source.newaddress(@name))
  end

  def addresses
    @source.getaddressesbyaccount(@name).map{|addr| Address.new(@source, addr)}
  end

  def total_received
    @source.getreceivedbyaccount(@name)
  end

  def transactions(from=0, count=99999999)
    @source.listtransactions(@name)
  end

  def to_s
    "#{@name} - #{"%.8f" % balance} BTC"
  end
end
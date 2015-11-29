require_relative 'bitcoinrpc'

class Address < RPCObject
  attr_reader :address

  def initialize(source, address)
    super(source)
    @address = address
  end

  def private_key
    @source.dumpprivkey @address
  end

  def account
    Account.new(@source, @source.getaccount(@address))
  end

  def total_received
    @source.getreceivedbyaddress(@address)
  end

  def to_s
    "#@address"
  end
end
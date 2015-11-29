require_relative 'bitcoinrpc'

class Transaction < RPCObject
  attr_reader :txid

  def initialize(source, txid)
    super(source)
    @txid = txid
  end

  def amount
    load[:amount]
  end

  def confirmations
    load[:confirmations]
  end

  private
  def load
    @txdat ||= @source.getrawtransaction(@txid)
  end
end
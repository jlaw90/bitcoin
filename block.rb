require_relative 'bitcoinrpc'

class Block < RPCObject
  attr_reader :hash, :confirmations, :size, :height, :version, :merkleroot, :time, :nonce, :bits, :difficulty

  def initialize(source, data)
    super(source)
    @hash = data[:hash]
    @confirmations = data[:confirmations]
    @size = data[:size]
    @height = data[:height]
    @version = data[:version]
    @merkleroot = data[:merkleroot]
    @tx = data[:tx]
    @time = Time.at(data[:time])
    @nonce = data[:nonce]
    @bits = data[:bits]
    @difficulty = data[:difficulty]
    @next = data[:nextblockhash]
    @prev = data[:previousblockhash]
  end

  def previous
    return nil if @prev.nil?
    @source[@prev]
  end

  def next
    return nil if @next.nil?
    @source[@next]
  end

  def transactions
    @tx.map{|txid| Transaction.new(@source, txid)}
  end

  def to_s
    @hash
  end
end
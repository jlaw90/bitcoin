require 'net/http'
require 'uri'
require 'json'

require_relative 'rpc'
require_relative 'account'
require_relative 'block'
require_relative 'transaction'

class BitcoinRPC
  def initialize(url)
    @uri = URI.parse(url)
  end

  def accounts
    listaccounts.data.keys.map{|name| Account.new(self, name)}
  end

  def block_count
    getblockcount
  end

  def block_hash(idx)
    getblockhash(idx)
  end

  def get_block(hashish)
    hashish = block_hash(hashish) if hashish.is_a? Integer
    Block.new(self, getblock(hashish))
  end

  def [](hashish)
    get_block(hashish)
  end

  def difficulty
    getdifficulty
  end

  def method_missing(name, *args)
    rpc_request(name, *args)
  end

  def rpc_request(name, *args)
    post_body = { 'method' => name, 'params' => args, 'id' => 'jsonrpc' }.to_json
    resp = JSON.parse( http_post_request(post_body) )
    raise JSONRPCError, resp['error'] if resp['error']
    res = resp['result']
    res.is_a?(Hash)? RPCResponse.new(self, res): res
  end

  private
  def http_post_request(post_body)
    http    = Net::HTTP.new(@uri.host, @uri.port)
    request = Net::HTTP::Post.new(@uri.request_uri)
    request.basic_auth @uri.user, @uri.password
    request.content_type = 'application/json'
    request.body = post_body
    http.request(request).body
  end

  class JSONRPCError < RuntimeError; end
end
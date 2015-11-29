require_relative 'bitcoinrpc'

bitcoin = BitcoinRPC.new('')

# bitcoin.accounts.each do |acc|
#   puts acc
#   addr = acc.addresses
#   puts "\t" + (addr.empty? ? 'No addresses': 'Addresses:')
#   addr.each do |add|
#     puts "\t\t#{add}"
#   end
#
#   puts acc.transactions
# end

p bitcoin.check

block = bitcoin[0]
until block.nil?
  p block.transactions[0]
  block = block.next
end
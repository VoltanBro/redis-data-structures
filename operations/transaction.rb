# frozen_string_literal: true

require_relative '../redis_init'

client = Redis.new

puts 'Lets to execution of a group of commands in a single step'
client.multi
client.set(:names, ['Bob', 'Mark'])
client.hmset(:books, :jack_london, 'Whit Fang', :stephen_king, 'It')
client.exec
puts client.get(:names)
puts client.hgetall(:books)

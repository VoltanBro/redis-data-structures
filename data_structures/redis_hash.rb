# frozen_string_literal: true

require_relative '../redis_init'

class RedisHash < RedisInit
  def hmset(key, *values)
    client.hmset(key, *values)
  end

  def hget(key, value)
    client.hget(key, value)
  end

  def hgetall(key)
    client.hgetall(key)
  end

  def hkeys(key)
    client.hkeys(key)
  end

  def hvals(key)
    client.hvals(key)
  end

  def hexists(key, value)
    client.hexists(key, value)
  end

  def hdel(key, *values)
    client.hdel(key, *values)
  end
end

redis_hash = RedisHash.new
redis_hash.hmset(:books, :jack_london, 'Whit Fang', :stephen_king, 'It')
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts "My favorite book of Stephen King is a #{redis_hash.hget(:books, :stephen_king)}"
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts "Our library has: #{redis_hash.hgetall(:books)}"
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts "In our library you is present next authors: #{redis_hash.hkeys(:books)}"
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts "In our library you is present next books: #{redis_hash.hvals(:books)}"
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts 'Let me check availability of this author'
puts redis_hash.hexists(:books, :stephen_king) ? 'Yeah! We have it' : 'Sorry, this book is not available'
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
redis_hash.hdel(:books, :jack_london)
puts 'Let me check availability of this author'
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts redis_hash.hexists(:books, :jack_london) ? 'Yeah! We have it' : 'Sorry, this book is not available'

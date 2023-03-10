# frozen_string_literal: true
require 'securerandom'
require_relative '../redis_init'

class RedisString < RedisInit
  def set(key, value)
    client.set(key, value)
  end

  def get(key)
    client.get(key)
  end

  def getset(key, value)
    client.getset(key, value)
  end

  def strlen(key)
    client.strlen(key)
  end

  def incr(key)
    client.incr(key)
  end

  def incrby(key, incr)
    client.incrby(key, incr)
  end

  def append(key, value)
    client.append(key, value)
  end

  def setex(key, seconds, value)
    client.setex(key, seconds, value)
  end
end

redis_string = RedisString.new
redis_string.set(:name, 'FooName')
redis_string.set(:email, 'test@bar.com')
redis_string.set(:year, 2000)

puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts
puts "Welcome #{redis_string.get(:name)}: your email is - #{redis_string.get(:email)}"
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts
puts "Your previous email #{redis_string.getset(:email, 'second_test@bar.com')} was updated to second_test@bar.com"
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts
puts "Your email has #{redis_string.strlen(:email)} symbols"
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts
puts "The next year after #{redis_string.get(:year)} is a #{redis_string.incr(:year)}"
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts
puts "Year was incremented by 20: #{redis_string.incrby(:year, 20)}"
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts
redis_string.append(:email, '_deleted')
puts "Suffix deleted was added to your email: #{redis_string.get(:email)}"
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts
puts 'Token will be expired in 1 second'
redis_string.setex(:token, 1, SecureRandom.hex(10))
puts "Current token is: #{redis_string.get(:token)}"
sleep 2
puts 'Token was expired' unless redis_string.get(:token)
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts

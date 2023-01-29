# frozen_string_literal: true

require_relative '../redis_init'

class RedisList < RedisInit
  def lpush(key, *values)
    client.lpush(key, values)
  end

  def rpush(key, *values)
    client.rpush(key, values)
  end

  def rpop(key)
    client.rpop(key)
  end

  def lpop(key)
    client.lpop(key)
  end

  def lindex(key, index)
    client.lindex(key, index)
  end

  def llen(key)
    client.llen(key)
  end

  def lrange(key, start, stop)
    client.lrange(key, start, stop)
  end

  def lset(key, index, value)
    client.lset(key, index, value)
  end
end

redis_list = RedisList.new
redis_list.lpush(:week_days, 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday')
redis_list.lpush(:names, 'Bob', 'Tom')

puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts
puts "The first day of the week is a #{redis_list.lindex(:week_days, 0)}"
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts
puts "The week has #{redis_list.llen(:week_days)} days"
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts
puts "First three days of the week are #{redis_list.lrange(:week_days, 0, 2).join(', ')}"
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts
redis_list.rpush(:names, 'Mike', 'Alex')
puts "Appends Max and Alex to end of the list"
puts "=> #{redis_list.lrange(:names, 0, -1)}"
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts "Prepends John to start of the list"
redis_list.lpush(:names, 'John')
puts "=> #{redis_list.lrange(:names, 0, -1)}"
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts "Remove Alex from the list"
redis_list.rpop(:names)
puts "=> #{redis_list.lrange(:names, 0, -1)}"
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts "Remove John from the list"
redis_list.lpop(:names)
puts "=> #{redis_list.lrange(:names, 0, -1)}"
puts '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'
puts 'Replace Bob by Mark'
redis_list.lset(:names, 1, 'Mark')
puts "=> #{redis_list.lrange(:names, 0, -1)}"

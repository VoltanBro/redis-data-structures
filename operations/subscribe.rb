# frozen_string_literal: true

require_relative '../redis_init'

client = Redis.new

client.subscribe(:garage_chat)
client.publish(:garage_chat, 'Hello Garage!')
client.unsubscribe(:garage_chat)

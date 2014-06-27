class RedisWrapper

 def self.publish(message)
  	redis.publish 'realtime_msg', message.to_json
  end

  def redis
    return $redis # global set in redis.rb initializer
  end

  def self.redis
    return $redis # global set in redis.rb initializer
  end

end
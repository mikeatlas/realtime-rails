module Realtime
	module Controller
		extend ActiveSupport::Concern

		module ClassMethods
			def realtime_controller(options = {})
                                queue = options.delete(:queue)
			 	before_action :do_realtime_token, options
			 	before_action :do_realtime_user_id, options
			 	before_action :do_realtime_server_url, options
			 	if queue.nil? || queue == :redis
			 		after_action :store_realtime_session_redis, options
			 	elsif queue == :zmq
			 		after_action :store_realtime_session_zmq, options
			 	end
			end
		end

		def do_realtime_token
			@realtime_token = Digest::MD5.hexdigest("#{session[:session_id]}:#{realtime_user_id}")
			return @realtime_token
		end

		def do_realtime_user_id
			@realtime_user_id = realtime_user_id
			return @realtime_user_id
		end

		def do_realtime_server_url
			@realtime_server_url = realtime_server_url
			return @realtime_server_url
		end

		 # create shared session tokens for redis/socketio realtime server running on node.js
		def store_realtime_session_zmq
			# store session data or any authentication data you want here, generate to JSON data
			session_data = {
					"user_id" => realtime_user_id,
			}

			# todo: merge additional session data passed in
			stored_session_data = JSON.generate(session_data)

			ZmqWrapper.store_session(
				realtime_user_id,
				@realtime_token,
				stored_session_data,
				86400
			)
		end

	    # create shared session tokens for redis/socketio realtime server running on node.js
		def store_realtime_session_redis
			# store session data or any authentication data you want here, generate to JSON data
			session_data = {
					"user_id" => realtime_user_id,
			}

			# todo: merge additional session data passed in

			stored_session_data = JSON.generate(session_data)

			RedisWrapper.redis.hset(
				"rtSession-" + realtime_user_id.to_s,
				@realtime_token,
				stored_session_data,
			)

			# expire this realtime session after one day.
			RedisWrapper.redis.expire("rtSession-" + realtime_user_id.to_s, 86400)
		end

	end
end

module Realtime
	module Controller
		extend ActiveSupport::Concern

		module ClassMethods
			def realtime_controller(options = nil)
			 	before_filter :do_realtime_token
			 	before_filter :do_realtime_user_id
			 	before_filter :do_realtime_server_url
			 	if options.nil?
			 		after_filter :store_realtime_session_redis
			 	elsif options[:queue] == :redis
			 		after_filter :store_realtime_session_redis
			 	elsif options[:queue] == :zmq
			 		after_filter :store_realtime_session_zmq
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
class ZmqWrapper

	if defined?(ZMQ) && defined?(EmZeromq)
		require 'em-zeromq'

		def self.publish(the_message)
			EM.run {
				zmq = EM::ZeroMQ::Context.new(1)
				pusher = zmq.socket(ZMQ::PUSH)
				pusher.connect($zmq_server)
				message = "realtime_msg:" + the_message.to_json	
				puts "Pushing realtime message: " + message
				pusher.send_msg(message)
				EM.stop
			}
		end

		def self.store_session(user_id, session_id, session_data, expiration)
			EM.run {
				zmq = EM::ZeroMQ::Context.new(1)
				pusher = zmq.socket(ZMQ::PUSH)
				pusher.connect($zmq_server)
				the_message = {user_id: user_id, 
					session_id: session_id,
					session_data: session_data,
					expiration: expiration}
					message = "rtSession:" + the_message.to_json	
					puts "Pushing session message: " + message
					pusher.send_msg(message)
					EM.stop
				}
		end
	end
end

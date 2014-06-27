module Realtime
	
	class Railtie < Rails::Railtie
    
	    initializer "realtime.action_controller" do
		    ActiveSupport.on_load(:action_controller) do				
				ActionController::Base.send :include, Realtime::Controller
			end
		end

		initializer "realtime.view_helpers" do
			ActionView::Base.send :include, ViewHelpers

			# kinda blah way to force rails to load our helper views path
			curr_path = File.expand_path(File.dirname(__FILE__))
			view_path = "#{curr_path}/../../app/views"
			ActionController::Base.append_view_path(view_path)
		end

	end

end
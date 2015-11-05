module Realtime
  module ViewHelpers

    def realtime_support
      return render(template: "realtime/realtime_support",
                    layout: nil,
                    locals:
                    { realtime_token: @realtime_token,
                      realtime_domain: @realtime_domain,
                      realtime_server_url: @realtime_server_url,
                      realtime_user_id: @realtime_user_id }).to_s
    end

    def realtime_message_handler
      return render(template: "realtime/realtime_message_handler",
                    layout: nil,
                    locals: {}).to_s
    end

    def realtime_message_console_logger
      return render(template: "realtime/realtime_message_console_logger",
                    layout: nil,
                    locals: {}).to_s
    end
  end
end

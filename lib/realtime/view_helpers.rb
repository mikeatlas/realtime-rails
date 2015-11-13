module Realtime
  module ViewHelpers

    def realtime_support(args = {})
      async = args[:async] ? 'async_' : ''
      return render(template: "realtime/#{async}realtime_support",
                    layout: nil,
                    locals:
                    { realtime_token: @realtime_token,
                      realtime_domain: @realtime_domain,
                      realtime_server_url: @realtime_server_url,
                      realtime_user_id: @realtime_user_id,
                      message_handler: args[:message_handler],
                      message_console_logger: args[:message_console_logger] }).to_s
    end
  end
end

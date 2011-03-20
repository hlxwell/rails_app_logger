require 'pp'
require 'action_controller/log_subscriber'

class DatabaseLogger < ActionController::LogSubscriber
  def process_action(event)
    super
    AppLog.create event.payload
  end

end

DatabaseLogger.attach_to :action_controller
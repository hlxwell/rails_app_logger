require 'pp'
require 'action_controller/log_subscriber'

class DatabaseLogger < ActionController::LogSubscriber
  def process_action(event)
    super
    h = event.payload
    h.delete(:method)
    AppLog.create h
  end

end

DatabaseLogger.attach_to :action_controller
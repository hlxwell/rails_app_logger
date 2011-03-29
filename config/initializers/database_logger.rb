require 'action_controller/log_subscriber'
require 'action_view/log_subscriber'

class MyControllerLogger < ActionController::LogSubscriber
  def process_action(event)
    super
    h = event.payload
    h.delete(:method)
    AppLog.create h
  end
end
MyControllerLogger.attach_to :action_controller

# class MyActionViewLogger < ActionView::LogSubscriber
#   def render_template(event)
#     super
#     pp event.duration
#     pp event.payload[:identifier]
#     pp event.payload[:layout]
#   end
# end
# MyActionViewLogger.attach_to :action_view
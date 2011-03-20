require 'pp'
require 'action_controller/log_subscriber'

class DatabaseLogger < ActionController::LogSubscriber
  # INTERNAL_PARAMS = %w(controller action format _method only_path)

  # def start_processing(event)
  #   payload = event.payload
  #   params  = payload[:params].except(*INTERNAL_PARAMS)
  #
  #   info "  Processing by #{payload[:controller]}##{payload[:action]} as #{payload[:formats].first.to_s.upcase}"
  #   info "  Parameters: #{params.inspect}" unless params.empty?
  # end

  def process_action(event)
    super
    
    # {:status=>200,
    #  :path=>"/",
    #  :view_runtime=>11.1467838287354,
    #  :params=>{"action"=>"index", "controller"=>"logs"},
    #  :controller=>"LogsController",
    #  :action=>"index",
    #  :method=>"GET",
    #  :formats=>[nil]}
    
    
  end

end

DatabaseLogger.attach_to :action_controller
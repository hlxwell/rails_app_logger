# {
#   'action'           : action_name,
#   'application_name' : application_name (rails root),
#   'controller'       : controller_name,
#   'ip'               : ip_address,
#   'messages'         : {
#                          'info'  : [ ],
#                          'debug' : [ ],
#                          'error' : [ ],
#                          'warn'  : [ ],
#                          'fatal' : [ ]
#                        },
#   'params'           : { },
#   'path'             : path,
#   'request_time'     : date_of_request,
#   'runtime'          : elapsed_execution_time_in_milliseconds,
#   'url'              : full_url
# }

class Log
  include Mongoid::Document
  
  field :action
  field :controller
  field :application_name
  field :ip
  field :messages
  field :params
  field :path
  field :request_time
  field :runtime
  field :url
  
  embeds_one :messages
end
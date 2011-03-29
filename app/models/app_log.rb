# {:status=>200,
#  :path=>"/",
#  :view_runtime=>11.1467838287354,
#  :params=>{"action"=>"index", "controller"=>"logs"},
#  :controller=>"LogsController",
#  :action=>"index",
#  :method=>"GET",
#  :formats=>[nil]}

class AppLog
  include Mongoid::Document
  include Mongoid::Timestamps

  enslave
  cache

  field :status
  field :path
  field :view_runtime
  field :params
  field :controller
  field :action
  field :formats

  index :created_at
  index :params
  index :_id

  shard_key :_id

  def repeating_requests
    self.class.where(:params => self.params).order_by(:created_at.desc)
  end
end
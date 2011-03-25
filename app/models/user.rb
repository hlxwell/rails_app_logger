class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  index :name
  shard_key :name

  def self.create_many count = 100 
    1..count.times { User.create! :name => (0...8).map{65.+(rand(25)).chr}.join }
  end
end
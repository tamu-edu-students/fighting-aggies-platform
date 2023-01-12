class Players < ActiveRecord::Base
    has_many :route_instances
end
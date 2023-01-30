class Player < ActiveRecord::Base
    has_many :route_instances, class_name: "RouteInstance"
end
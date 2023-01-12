class RouteInstances < ActiveRecord::Base
    belongs_to :player, class_name: 'Players'
end
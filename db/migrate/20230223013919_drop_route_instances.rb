class DropRouteInstances < ActiveRecord::Migration[7.0]
  def change
    drop_table :route_instances, if_exists: true
  end
end

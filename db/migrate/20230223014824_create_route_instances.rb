class CreateRouteInstances < ActiveRecord::Migration[7.0]
  def change
    drop_table :route_instances, if_exists: true
    create_table :route_instances do |t|
      t.integer :player_id
      t.string :route_name
      t.string :play_name
      t.string :timestamp_start
      t.string :timestamp_end
      t.integer :success
      t.string :practice_id
      t.date :date
      t.timestamps
    end
  end
end

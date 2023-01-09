class Users < ActiveRecord::Migration[7.0]
  def change
    drop_table :users
    create_table :users do |t|
      t.string :name
      t.string :role
      t.string :email
    end
  end
end

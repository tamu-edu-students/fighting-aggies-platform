class AddLengthToPracticeVideos < ActiveRecord::Migration[7.0]
  def change
    add_column :practice_videos, :length, :float
  end
end

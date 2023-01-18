class CreatePracticeVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :practice_videos do |t|
      t.string :filename
      t.string :video_name
      t.timestamp :video_create_date
      t.string :description
      t.timestamp :video_upload_date

      t.timestamps
    end
  end
end

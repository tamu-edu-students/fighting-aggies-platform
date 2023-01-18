json.extract! practice_video, :id, :filename, :video_name, :video_create_date, :description, :video_upload_date, :created_at, :updated_at
json.url practice_video_url(practice_video, format: :json)

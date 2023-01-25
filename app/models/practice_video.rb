class PracticeVideo < ApplicationRecord
  validates :filename, :description,
            presence: true

  validates :video_name,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :video_create_date, :video_upload_date,
            presence: true
end

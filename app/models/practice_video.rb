class PracticeVideo < ApplicationRecord
  has_one_attached :clip
  validates :description, #:filename,
            presence: true

  validates :video_name,
            presence: true,
            uniqueness: { case_sensitive: false }

  # validates :video_create_date, :video_upload_date,
  #           presence: true
end

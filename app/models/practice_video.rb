class PracticeVideo < ApplicationRecord
  has_one_attached :clip
  before_save :store_metadata
  validates :description,
            presence: true

  validates :video_name,
            presence: true,
            uniqueness: { case_sensitive: false }

  # validates :video_create_date, :video_upload_date,
  #           presence: true

  private
  def store_metadata
    self.filename = clip.filename
    # self.video_create_date = clip.created_at
    self.video_upload_date = Time.now.utc.iso8601
  end
end
